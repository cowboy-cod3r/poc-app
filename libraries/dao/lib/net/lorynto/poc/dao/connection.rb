# Classpath
$:.unshift(File.join(File.dirname(__FILE__),'..','..','..','..'))

#
# MongoMapper connections are done through modules.
# This file will typically only be used by our Model classes
#

# Libraries
require 'mongo_mapper'
require 'poc-logger'
require 'net/lorynto/poc/dao/db_props_parser'

# TODO: Might want to try and put this into a module

# Logger
logger = ::Net::Lorynto::Poc::Logger.instance()

#
# To override the default connection parameters, set the
# POC_DAO_PROPS environment variable to the location of your
# custom YAML file
if ENV['POC_DAO_PROPS'].nil? || ENV['POC_DAO_PROPS'].empty?
  db_props_loc = File.join(File.dirname(__FILE__),'..','..','..','..','..','config','db-props.yml')
end

# Get the properties
props = ::Net::Lorynto::Poc::Dao::DbPropsParser.new(db_props_loc).raw

# Host/port/database
host    = props[:host]
port    = props[:port]
db_name = props[:database]

# Delete host and port from the hash
props.delete(:host)
props.delete(:port)
props.delete(:database)

# Mongo Connection
# We wrap this in a begin block because if this dao is to be used
# by a service, we don't want the service to fail to start because the
# database isn't available.  Instead, the service should have a healthcheck
# endpoint that indicates a connection to the DB could not be acquired.
begin
  MongoMapper.connection = ::Mongo::Connection.new(host, port, props)
  MongoMapper.database   = db_name
  $db_ping=true
rescue Exception => e
  # TODO: Make this better
  $db_ping=false

  # Capture the connection error
  backtrace = '  '
  backtrace = "ERROR:  Command Line Error Occurred\n" \
        "    #{e.backtrace.join("\n    ")}"
  logger.error(backtrace)
end