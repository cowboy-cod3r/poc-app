# Classpath
$:.unshift(File.join(File.dirname(__FILE__),'..','..','..','..','lib'))

# Libraries
require 'poc-logger'
require 'singleton'

class Net
  class Lorynto
    class Poc
      class Service

        #
        # Class to hold all settings for this service.  This class is implemented as a singleton and is useful
        # for storing information about the service as well as a means of providing information to the service
        # upon startup and shutdown.
        # @author Sean Humbarger
        # @attr_reader [Hash] properties - the settings for the service in Hash format
        # @example
        #        props = ::Net::Lorynto::Poc::Service::Settings.instance()
        #        props.add_property("somekey", "somevalue")
        class Settings

          # Modules
          include Singleton

          # Accessors
          attr_reader :properties

          #
          # Constructor
          def initialize()
            @arg_msg    = 'The %s attributes cannot be nil, empty, or a zero-length string'
            @logger     = ::Net::Lorynto::Poc::Logger.instance()
            @properties = {}

            # Set a default db location
            db_props_loc = File.join(File.dirname(__FILE__),'..','..','..','..','..','config','db-props.yml')
            add_property('db_props_loc', db_props_loc)
          end

          #
          # Adds a property to this service
          # @public
          # @param [String] The key of the key/value pair
          # @param [Anything] The value of the key/value pair
          public
          def add_property(key, value)
            raise(ArgumentError, @arg_msg % ['key']) if !key.kind_of?(String) || key.strip.empty?

            if @properties.has_key?(key)
              # no op: skip
              @logger.warn("The '#{key}' already exists as a property.  Updating it...")
              @properties[key] = value
            else
              # add it
              @logger.debug("Adding '#{key} => #{value}'' to properties")
              @properties.merge!({ key => value })
            end
          end

          #
          # Adds a property to this service
          # @public
          # @param [String] The key of the property to delete
          public
          def delete_property(key)
            raise(ArgumentError, @arg_msg % ['key']) if !key.kind_of?(String) || key.strip.empty?
            @properties.delete(key)
          end

        end
      end
    end
  end
end