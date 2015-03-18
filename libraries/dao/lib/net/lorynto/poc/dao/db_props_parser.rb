# Classpath
$:.unshift(File.join(File.dirname(__FILE__),'..','..','..','..','lib'))

# Libraries
require 'yaml'
require 'poc-logger'
require 'net/lorynto/poc/dao/exceptions'

class Net
  class Lorynto
    class Poc
      class Dao

        #
        # Concrete class for parsing DB properties
        # @author Sean Humbarger
        # @attr [Hash] raw - The raw data after parsing the yml file
        class DbPropsParser

          # Accessors
          attr_accessor :raw

          #
          # Constructor
          # @param [String] yml_loc - the full path to the yml file
          def initialize(yml_loc)
            # Error Checking
            raise(ArgumentError, @arg_msg % ['yml_loc']) if !yml_loc.kind_of?(String) || yml_loc.strip.empty?

            @logger  = ::Net::Lorynto::Poc::Logger.instance()
            @yml_loc = yml_loc

            # Parse the yml file
            parse()
            validate()
          end

          #
          # Parses the yml database properties file
          # @private
          private
          def parse()
            @logger.info("Loading #{@yml_loc}")
            @raw = ::YAML.load_file(@yml_loc)
          end

          #
          # Defines and validates the nodes section of the yml file
          # @private
          private
          def validate()
            @logger.debug('Validating Database Properties')

            # Error Checking (FalseClass will pick up a blank yml file)
            if @raw.nil? || @raw.kind_of?(FalseClass) || @raw.empty?
              emsg = 'You must provide connection parameters. Ensure your file is in the correct format.'
              raise(::Net::Lorynto::Poc::Dao::Exceptions::YmlPropertyMissing, emsg)
            end

            required_props = [:host,:port,:database]
            required_props.each do |prop|
              if !@raw.has_key?(prop) || @raw[prop].nil?
                emsg = "You must supply a ':#{prop.to_s}' property"
                raise(::Net::Lorynto::Poc::Dao::Exceptions::YmlPropertyMissing, emsg)
              end
            end
          end

        end
      end
    end
  end
end