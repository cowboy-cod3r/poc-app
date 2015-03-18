# Classpath
$:.unshift(File.join(File.dirname(__FILE__),'..','..','..','..'))

# Required Libraries
require 'poc-logger'
require 'net/lorynto/poc/service/settings'

module Sinatra

  #
  # Custom Sinatra extensions for poc-service
  # @author Sean Humbarger
  module PocService

    #
    # Retrieves custom settings for the poc-service Sinatra application
    # @public
    # @example
    #     require 'net/lorynto/poc/service/extensions'
    #     register ::Sinatra::PocSerivce
    #     custom_settings.properties['context-path']
    #
    # @return [::Net/Lorynto/Poc::Service::Settings]
    public
    def custom_settings()
      ::Net::Lorynto::Poc::Service::Settings.instance()
    end

  end
end