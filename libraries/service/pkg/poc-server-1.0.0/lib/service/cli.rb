# Classpath
$:.unshift(File.join(File.dirname(__FILE__),'..'))

# Required Libraries
require 'gli'
require 'rack'
require 'fileutils'
require 'securerandom'
require 'poc-logger'
require 'net/lorynto/poc/service/settings'

# Include Modules
include GLI::App

module Service

  #
  # CLI module for interacting with the poc-service
  module Cli

    # Describe the main command
    program_desc 'Invokes the poc-service Sinatra Service'
    version File.read(File.join(File.dirname(__FILE__),'..','..','VERSION'))

    # Validate the number of arguments
    arguments                  :strict
    subcommand_option_handling :normal

    # Define this Sub-Command
    desc 'Starts the POC service'
    command :run do |c|

      c.desc    'Specify the log location.  By default, logging goes to STDOUT'
      c.flag    [:l, 'log'],
                :type => String

      c.desc    'The context path for the service endpoints'
      c.flag    [:c, 'context'],
                :type => String,
                :default_value => 'poc-service'

      c.desc    'Specify the Sinatra backing service'
      c.flag    [:e, 'server'],
                :type => String,
                :default_value => 'thin'

      c.desc    'Specify the port'
      c.flag    [:o, 'port'],
                :type => String,
                :default_value => '4242'

      c.desc    'Specify the PID location'
      c.flag    [:i, 'pid'],
                :type => String,
                :default_value => '/var/run/poc.pid'

      c.desc    'Debug Option - valid values are debug, info, warn, error, fatal'
      c.flag    [:d, 'debug'],
                :type => String,
                :default_value => 'error'

      c.desc    'The address to bind'
      c.flag    [:n, 'bind'],
                :type => String,
                :default_value => '0.0.0.0'

      c.desc    'Specify the location of the database connection parameters'
      c.flag    [:b, 'db-props'],
                :type => String,
                :default_value => File.expand_path(File.join(File.dirname(__FILE__),'..','..','config','db-props.yml'))

      # Implementation
      c.action do |global_options,options,args|
        STDOUT.puts('INFO: Starting poc-service')
        #
        # Configure the logger
        ENV['LOG_LOCATION'] = options[:l] if options[:l]
        ENV['LOG_LEVEL']    = options[:d]
        @logger = ::Net::Lorynto::Poc::Logger.instance()

        # Instantiate the settings for the server
        settings = ::Net::Lorynto::Poc::Service::Settings.instance()

        # Add the db properties location as a setting
        settings.add_property('db_props_loc', options['db-props'])

        if File.exists?(options[:pid])
          STDOUT.puts("WARN: The PID file '#{options[:pid]}' already exists, skipping startup...")
        else
          # Make pid dir if it doesn't exist
          FileUtils.mkdir_p(File.dirname(options[:pid])) if !File.exists?(File.dirname(options[:pid]))

          @logger.debug('Executing the command')
          @logger.debug('Global Options: ' + global_options.to_s)
          @logger.debug('Options: ' + options.to_s)
          @logger.debug('Args: ' + args.to_s)

          # poc-service library
          root_dir = File.expand_path(File.join(File.dirname(__FILE__),'..','..'))
          @logger.debug("root_dir: #{root_dir}")

          # Wrap the rackup command
          class PocServiceWrapper < Rack::Server;end

          # Append the location of the config.ru file to the ARGV constant
          @logger.debug('Finding config.ru')
          config_ru = "config=#{File.join(root_dir,'config.ru')}"
          ARGV << '-O'
          ARGV << config_ru

          # Binding Address
          @logger.debug("Binding server to '#{options[:bind]}'")
          ARGV << '-o'
          ARGV << options[:bind]

          # Port
          @logger.debug("Setting the port to '#{options[:port]}'")
          ARGV << '-p'
          ARGV << options[:port]
          settings.add_property('port', options[:port])

          # Server Type
          @logger.debug("Setting the server type to '#{options[:server]}'")
          ARGV << '--server'
          ARGV << options[:server]
          settings.add_property('server', options[:server])

          # Pid
          @logger.debug("Setting the pid to '#{options[:pid]}'")
          ARGV << '--pid'
          ARGV << options[:pid]
          settings.add_property('pid', options[:pid])

          # Logging for the server
          @logger.debug("Logging to '#{options[:l]}'")
          ARGV << '-O'
          ARGV << "log=#{options[:l]}"
          if options[:l]
            settings.add_property('log', options[:l])
          else
            settings.add_property('log','STDOUT')
          end

          # Daemonize
          @logger.debug("Daemonizing '#{options[:server]}'")
          ARGV << '--daemonize'
          settings.add_property('daemonize', true)

          # Strip nils from ARGV
          ARGV.compact!

          # Capture additional properties that are passed in from the command line
          settings.add_property('context-path', options[:context])

          # Invoke the Process
          @logger.debug('Starting the poc-service application...')
          @logger.debug(ARGV.inspect)
          PocServiceWrapper.start()
        end
      end
    end

    #
    # Define this Sub-Command
    desc 'Stop the POC service'
    command :stop do |c|
      c.desc    'Specify the PID location'
      c.flag    [:p,'pid'],
                :type => String,
                :default_value => '/var/run/POC.pid'

      c.desc    'Debug Option - valid values are debug, info, warn, error, fatal'
      c.flag    [:d, 'debug'],
                :type => String,
                :default_value => 'debug'

      # Implementation
      c.action do |global_options,options,args|
        STDOUT.puts('INFO: Stopping poc-service')

        ENV['LOG_LEVEL'] = options[:d]
        if !File.exists?(options[:p])
          STDOUT.puts("WARN: The PID file '#{options[:p]}' does not exist, skipping stop of POC.")
        else
          # stop thin

          cmd = "thin stop -P #{options[:p]}"
          `#{cmd}`
          if $?.exitstatus != 0
            raise(RuntimeError, 'Failed to stop POC properly.')
          else
            STDOUT.puts("INFO: POC stopped...")
          end
        end
      end
    end

    #
    # Default Error catching
    on_error do |e|
      # Print the stacktrace
      backtrace = '  '
      backtrace = "ERROR:  Command Line Error Occurred\n" \
          "    #{e.backtrace.join("\n    ")}"
      puts backtrace
      true
    end
      exit run(ARGV)

    end
  end
