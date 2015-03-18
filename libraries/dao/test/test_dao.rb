#
# Performs Tests

# Set Classpath
$:.unshift(File.join(File.dirname(__FILE__),'..','lib'))

# Added this to the file prevent an odd warning from minitest
gem 'minitest'

# Required Libraries (Any utilities as well as the files to test)
require 'minitest/autorun'
require 'net/lorynto/poc/model/poc'
require 'mongo'

# Module Includes
include MiniTest::Assertions
include Mongo

class TestPropsParser < MiniTest::Test

  #
  # Set it up
  def setup
    @db       = ::MongoClient.new('localhost', 27017).db('poc')
    @poc_coll = @db.collection('pocs')
  end

  def teardown()
    @poc_coll.remove
  end

  #
  # Verify invalid args for modifying a user
  def test_add_basic_poc()


    # Record
    orig_poc_record = {
      :first_name    => 'Sean',
      :middle_name   => 'Matthew',
      :last_name     => 'Humbarger',
      :addresses     => [],
      :emails        => [],
      :phone_numbers => []
    }

    # add record
    poc = ::Poc.create!(orig_poc_record)

    # Count the records
    query = ::Poc.all()
    assert_equal(1, query.count)

    # Verify the data
    db_record = ::Poc.find(poc.id.to_s)
    assert_equal(orig_poc_record[:first_name], db_record.first_name)
    assert_equal(orig_poc_record[:middle_name], db_record.middle_name)
    assert_equal(orig_poc_record[:last_name], db_record.last_name)
  end

  #
  # Verify invalid args for modifying a user
  def test_delete_poc()
    # Record
    orig_poc_record = {
        'first_name'    => 'Sean',
        'middle_name'   => 'Matthew',
        'last_name'     => 'Humbarger',
        'addresses'     => [],
        'emails'        => [],
        'phone_numbers' => []
    }

    # Add it
    poc = ::Poc.create!(orig_poc_record)

    # Count the records
    assert_equal(1, ::Poc.count)

    # Delete it
    ::Poc.delete(poc.id.to_s)

    # Count the records
    assert_equal(0, ::Poc.count)
  end

  #
  # Verify invalid args for modifying a user
  def test_modify_poc()
    # Record
    orig_poc_record = {
        'first_name'    => 'Sean',
        'middle_name'   => 'Matthew',
        'last_name'     => 'Humbarger',
        'addresses'     => [],
        'emails'        => [],
        'phone_numbers' => []
    }

    # Add it
    poc = ::Poc.create!(orig_poc_record)

    # Change the first name of the record
    poc.first_name = 'Liam'
    poc.save!

    updated_record = ::Poc.find(poc.id.to_s)
    assert_equal('Liam', updated_record.first_name)
  end

  #
  # Verify adding and removing of email addresses
  def test_email_to_existing_poc()
    # Record
    orig_poc_record = {
        'first_name'    => 'Sean',
        'middle_name'   => 'Matthew',
        'last_name'     => 'Humbarger',
        'addresses'     => [],
        'emails'        => [],
        'phone_numbers' => []
    }

    # Create the POC Record
    poc = ::Poc.create!(orig_poc_record)

    # Add two email addresses
    poc.emails << ::Email.new({ 'type' => 'Home', 'email'=>'john.doe@blah.com'})
    poc.emails << ::Email.new({ 'type' => 'Work', 'email'=>'john.doe1@blah.com'})
    poc.save!
    updated_record = ::Poc.find(poc.id.to_s)
    assert_equal(2, updated_record.emails.count)

    # Remove one email
    email_id = poc.emails[0].id
    poc.emails.delete_if {|e| e.id == email_id}
    poc.save!

    # Assert 1 record
    updated_record = ::Poc.find(poc.id.to_s)
    assert_equal(1, updated_record.emails.count)
  end

end