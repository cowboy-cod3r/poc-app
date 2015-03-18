#
# Rackup config.ru file used to start the service.  This file
# is called by the CLI module.

# Classpath
$:.unshift(File.join(File.dirname(__FILE__),'lib'))

# Libraries
require 'sinatra'
require 'net/lorynto/poc/service/init'

# Start the Sinatra App
run ::Net::Lorynto::Poc::Service::Init
