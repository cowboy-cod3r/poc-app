# Classpath
$:.unshift(File.join(File.dirname(__FILE__),'..','..','..','..'))

# Libraries
require 'poc-logger'
require 'net/lorynto/poc/model/poc'

class Net
  class Lorynto
    class Poc
      class Dao

        #
        # Class consisting of some handy utilities
        # @author Sean Humbarger
        class Utilities

          #
          # Constructor
          def initialize()
          end

          #
          # Used to implement various database configurations upon database startup
          #
          # @public
          public
          def bootstrap()
            ::Poc.generate_indexes()
          end

          #
          # Pings the database to see if it is up and running
          #
          # @public
          # @example
          #     require 'issinc/we/product_env/model/db_utils'
          #     include ::Utils::Db
          #     db_ping()
          #
          # @return [Trueclass] if the db responds
          # @return [Falsclass] if the db does not respond
          public
          def db_ping()
            begin
              logger = ::Net::Lorynto::Poc::Logger.instance()
              logger.debug('Checking Datasource')
              require 'mongo_mapper'
              require 'net/lorynto/poc/dao/connection'
              return $db_ping
            rescue Exception => e
              trace = "#{e.message}\n" \
                      "    #{e.backtrace.join("\n    ")}"
                logger.error(trace)
              return false
            end
          end

        end
      end
    end
  end
end