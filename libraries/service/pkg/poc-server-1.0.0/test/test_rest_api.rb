#
# Performs Tests
#
#
# Testing is performed by minitest.  You can find assertions here:
#   * http://www.ruby-doc.org/stdlib-1.9.3/libdoc/minitest/unit/rdoc/MiniTest/Assertions.html

# Set Classpath
$:.unshift(File.join(File.dirname(__FILE__),'..','lib'))

# Added this to the file prevent an odd warning from minitest
gem 'minitest'

# Required Libraries (Any utilities as well as the files to test)
require 'minitest/autorun'
require 'rest-client'
require 'mongo'
require 'json'

# Module Includes
include MiniTest::Assertions

class TestProductEnvRestApi < MiniTest::Test
  include Mongo

  #
  # Setup the tests
  def setup
    
    # variables
    @log_level = 'debug'
    @pid       = File.join(File.dirname(__FILE__),'poc-service.pid')
    @log       = File.join(File.dirname(__FILE__),'poc-service.log')
    @exec      = File.join(File.dirname(__FILE__),'..','bin','poc-service')
    @base_url  = 'http://127.0.0.1:4242/poc-service'
    @db        = MongoClient.new('localhost', 27017).db('poc')
    @poc_coll  = @db.collection('pocs')

    # Start the service
    start_service
  end

  #
  # Teardown the tests
  def teardown
    
    # Stop the service
    stop_service

    # Delete the data from the collection (this does not drop the collection itself)
    @poc_coll.remove
  end

  #
  # Start the service
  def start_service
    cmd = "#{@exec} run --pid=#{@pid} --log=#{@log} --debug=#{@log_level}"
    `#{cmd}`

    # Give some time for the service to start
    sleep 2
  end

  #
  # Stop the service
  def stop_service
    cmd = "#{@exec} stop --pid=#{@pid} --debug=#{@log_level}"
    `#{cmd}`
  end

  #
  # Dummy JSON record 3
  def dummy_record_1
    poc = {}
    poc[:addresses]     = []
    poc[:emails]        = []
    poc[:first_name]    = 'John'
    poc[:last_name]     = 'Doe'
    poc[:middle_name]   = 'Smith'
    poc[:phone_numbers] = []
    poc.to_json
  end

  #
  # Dummy JSON record 3
  def dummy_record_2
    poc = {}
    poc[:addresses]     = []
    poc[:emails]        = []
    poc[:first_name]    = 'Jane'
    poc[:last_name]     = 'Moe'
    poc[:middle_name]   = 'Mary'
    poc[:phone_numbers] = []
    poc.to_json
  end

  #
  # Dummy JSON record 3
  def dummy_record_3
    poc = {}
    poc[:addresses]     = []
    poc[:emails]        = []
    poc[:first_name]    = 'Jack'
    poc[:last_name]     = 'Reed'
    poc[:middle_name]   = 'Ralph'
    poc[:phone_numbers] = []
    poc.to_json
  end


  #
  # Insert POC
  def test_insert_poc
    json = dummy_record_1
    resource = RestClient::Resource.new(@base_url + '/poc')
    resource.post(json, :content_type => 'application/json')
  end

  #
  # Update POC
  def test_update_poc()
    # Insert a record
    json = dummy_record_1
    resource = RestClient::Resource.new(@base_url + '/poc')
    response = JSON.parse(resource.post(json, :content_type => 'application/json'))

    # Update it
    name = 'Barry'
    response['first_name'] = name
    resource = RestClient::Resource.new(@base_url + "/poc/#{response['id']}")
    response = JSON.parse(resource.put(response.to_json, :content_type => 'application/json'))
    assert_equal(name, response['first_name'])
  end

  #
  # Delete POC
  def test_delete_poc()
    # Insert a record
    json = dummy_record_1
    resource = RestClient::Resource.new(@base_url + '/poc')
    response = JSON.parse(resource.post(json, :content_type => 'application/json'))

    # Delete it
    resource = RestClient::Resource.new(@base_url + "/poc/#{response['id']}")
  end

  #
  # Retrieve POC
  def test_retrieve_poc()
    # Insert a record
    json = dummy_record_1
    resource = RestClient::Resource.new(@base_url + '/poc')
    response = JSON.parse(resource.post(json, :content_type => 'application/json'))

    # Update it
    resource = RestClient::Resource.new(@base_url + "/poc/#{response['id']}")
    JSON.parse(resource.get())
  end
  
  #
  # Retrieve all POCs
  def test_retrieve_all_pocs()
    # Insert a record
    json = dummy_record_1
    resource = RestClient::Resource.new(@base_url + '/poc')
    response = JSON.parse(resource.post(json, :content_type => 'application/json'))

    # Insert a second record
    json = dummy_record_2
    response = JSON.parse(resource.post(json, :content_type => 'application/json'))

    # Insert a third record
    json = dummy_record_3
    response = JSON.parse(resource.post(json, :content_type => 'application/json'))

    # Update it
    resource = RestClient::Resource.new(@base_url + '/pocs')
    response = JSON.parse(resource.get())
  end
  
end