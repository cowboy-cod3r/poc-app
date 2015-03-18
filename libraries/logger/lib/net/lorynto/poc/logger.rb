# Libararies
require 'logger'
require 'singleton'
require 'fileutils'

class Net
  class Lorynto
    class Poc

      #
      # Logger Class.  The default log level is **ERROR**. You can override
      # the default log level by setting an environment variable called **LOG_LEVEL**.
      # You can also override the default log location to a file by seeing the **LOG_LOCATION**
      # environment variable.
      #
      #
      # Valid **LOG_LEVEL** values are as follows to one of the following values:
      #
      # * DEBUG
      # * INFO
      # * WARN
      # * ERROR
      # * FATAL
      #
      # @author Sean Humbarger
      class Logger < ::Logger

        # Modules
        include Singleton

        #
        # Constructor
        def initialize()
          log_env_var = 'LOG_LOCATION'
          env_var = 'LOG_LEVEL'
          if ENV[log_env_var].nil? || ENV[log_env_var].strip.empty?
            super(STDOUT)
          else
            FileUtils.mkdir_p(File.dirname(ENV[log_env_var])) if !File.exists?(ENV[log_env_var])
            super(ENV[log_env_var])
          end

          if ! ENV[env_var].kind_of?(String) || ENV[env_var].strip.empty?
            @level = ::Logger::ERROR
          else
            case ENV[env_var].upcase
            when "DEBUG"
              @level = ::Logger::DEBUG
            when "INFO"
              @level = ::Logger::INFO
            when "WARN"
              @level = ::Logger::WARN
            when "ERROR"
              @level = ::Logger::ERROR
            when "FATAL"
              @level = ::Logger::FATAL
            else
              @level = ::Logger::ERROR
            end
          end
        end
      end
    end
  end
end