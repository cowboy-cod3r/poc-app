# Classpath
$:.unshift(File.join(File.dirname(__FILE__),'..','..','..','..'))

# Libraries
require 'json'
require 'uri'
require 'sinatra/base'
require 'sinatra/namespace'
require 'poc-logger'
require 'poc-dao'
require 'net/lorynto/poc/service/exceptions'
require 'net/lorynto/poc/service/extensions'
require 'net/lorynto/poc/service/settings'

class Net
  class Lorynto
    class Poc
      class Service

        #
        # This class is the initialization point for all endpoints related to poc-service
        #
        # @author Sean Humbarger
        class Init < Sinatra::Base

          # Register modules
          register ::Sinatra::PocService
          register ::Sinatra::Namespace

          # Allows exceptions to go to our log
          set :show_exceptions, false

          #
          # Bootstrap when the server starts up
          configure :production, :development do
            #enable :logging
            #file      = File.new("log", 'a+')
            #file.sync = true
            #use Rack::CommonLogger, file
          end

          #
          # If we were going to do any real authorization and auditing for this service, we'd probably put a
          # filter in right here.
          before do
            # Default Logger
            @logger = Net::Lorynto::Poc::Logger.instance()
            @logger.debug('Start Request')

            # Default content type
            content_type :json
          end

          #
          # Make sure we log any errors
          error do
            log       = Net::Lorynto::Poc::Logger.instance()
            e         = env['sinatra.error']
            url       = request.url
            ip        = request.ip
            backtrace = "Application error - #{e.class}\n" \
                        "  Message: #{e.message}\n" \
                        "  Request URL: #{url}\n" \
                        "  Request IP:  #{ip}\n" \
                        "    #{e.backtrace.join("\n    ")}"
            log.error(backtrace)
            backtrace
          end

          #
          # Default behavior when a 404 is returned
          not_found do
            log       = Net::Lorynto::Poc::Logger.instance()
            url       = request.url
            ip        = request.ip
            backtrace = "Client error - 404\n" \
                        "  Message: Route not found\n" \
                        "  Request URL: #{url}\n" \
                        "  Request IP:  #{ip}\n"
            log.error(backtrace)
            backtrace
          end

          #
          # This namespace evaluates to 'poc-service'
          namespace "/#{custom_settings.properties['context-path']}" do

            #
            # Options for some of the endpoint
            %w('/healthcheck','/version','/db-props').each do |ep|
              options ep do
                content_type :text
                methods = 'GET'
                response.headers['Access-Control-Allow-Methods'] = methods
                response.headers['Allow'] = methods
              end
            end

            #
            # Healthcheck Endpoint
            # Add other third party services to this status as more come online
            get '/healthcheck' do
              @logger.debug('Getting healthcheck')
              
              db_utils             = ::Net::Lorynto::Poc::Dao::Utilities.new()
              health               = {}
              health[:sinatra]     = 'Up' # If we got this far, Sinatra is obviously up
              health[:mongo]       = db_utils.db_ping() ? 'Up' : 'Down'
              
              if health[:mongo].downcase == 'down'
                health[:poc_count] = 'Unknown'
              else
                health[:poc_count] = ::Poc.count()
              end
              return health.to_json
            end

            #
            # GET the version of this gem
            get '/version' do
              @logger.debug('Getting service version')
              
              version = { 'version' => File.read(File.join(File.dirname(__FILE__),'..','..','..','..','..','VERSION')).strip }
              return version.to_json
            end

            # #
            # # GET database properties
            get '/db-props' do
              @logger.debug('Getting database connection properties')
              
              # Get the properties
              settings = ::Net::Lorynto::Poc::Service::Settings.instance()
              props    = ::Net::Lorynto::Poc::Dao::DbPropsParser.new(settings.properties['db_props_loc']).raw

              # Filter out the passwords if there are any
              props[:password]           = '**********' if props.has_key?(:password)
              props[:encrypted_password] = '**********' if props.has_key?(:encrypted_password)
              return props.to_json
            end

            #
            # GET for all POCs
            get '/pocs' do
              @logger.debug('Getting all POCs')
              
              content_type :json
              @logger.debug(params.inspect)
              
              if params.empty?
                pocs = ::Poc.all()
              else
                pocs = ::Poc.where(params)
              end
              
              return pocs.to_json
            end

            #
            # Post - Inserts a POC
            post '/poc' do
              @logger.debug("Executing PUT for endpoint #{params[:poc_id]}")

              # Parse the payload
              payload = JSON.parse(request.body.read, :symbolize_names => true)

              # Check to see if the stack already exists
              poc = ::Poc.create!(payload)

              @logger.debug(poc.inspect)
              @logger.debug(poc.class)

              return poc.to_json
            end

            # poc context
            namespace '/poc' do
              
              #
              # GET - Retrieve a specific POC
              get '/:poc_id' do
                @logger.debug('Getting POC #{params[:poc_id]}')

                content_type :json
                poc = ::Poc.find(params[:poc_id])

                @logger.debug(poc.methods)

                # 404 if nothing is found
                not_found if poc.nil?

                return poc.to_json
              end
              
              # 
              # PUT - Update a specific POC
              # This can be a full POC json object that you pass in.
              # If you exclude a field, it won't change the existing value of that field in the DB.
              put '/:poc_id' do
                @logger.debug("Executing PUT for endpoint #{params[:poc_id]}")

                # Parse the payload
                payload = JSON.parse(request.body.read, :symbolize_names => true)

                # Retrieve the POC and update it
                poc = ::Poc.find(params[:poc_id])
                poc.update_attributes!(payload)

                return poc.to_json
              end

              #
              # DELETE - Delete a specific POC
              delete '/:poc_id' do
                @logger.debug("Executing DELETE for endpoint #{params[:poc_id]}")

                # Retrieve the POC and update it
                poc = ::Poc.delete(params[:poc_id])

                return poc.to_json
              end
            end

          end
        end
      end
    end
  end
end
