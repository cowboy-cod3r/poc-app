#
# Performs Tests

# Set Classpath
$:.unshift(File.join(File.dirname(__FILE__),'..','lib'))

# Added this to the file prevent an odd warning from minitest
gem 'minitest'

# Required Libraries (Any utilities as well as the files to test)
require 'minitest/autorun'
require 'net/lorynto/poc/dao/db_props_parser'
require 'net/lorynto/poc/dao/exceptions'

# Module Includes
include MiniTest::Assertions

class TestPropsParser < MiniTest::Test

  #
  # Set it up
  def setup
  end

  #
  # Parse DB Properties
  def test_db_props_parser()
    props_loc = File.join(File.dirname(__FILE__),'..','config','db-props.yml')
    db_props = ::Net::Lorynto::Poc::Dao::DbPropsParser.new(props_loc)
    expected = {:host=>'localhost', :port=>27017, :database=>'poc'}
    assert_equal(expected, db_props.raw)
  end

  #
  # Parse DB Properties Blank File
  def test_db_props_blank()
    props_loc = File.join(File.dirname(__FILE__),'data','blank.yml')
    assert_raises(::Net::Lorynto::Poc::Dao::Exceptions::YmlPropertyMissing) do
      ::Net::Lorynto::Poc::Dao::DbPropsParser.new(props_loc)
    end
  end

  #
  # Parse DB Properties Empty File
  def test_db_props_empty()
    props_loc = File.join(File.dirname(__FILE__),'data','empty.yml')
    assert_raises(::Net::Lorynto::Poc::Dao::Exceptions::YmlPropertyMissing) do
      ::Net::Lorynto::Poc::Dao::DbPropsParser.new(props_loc)
    end
  end

  #
  # Parse DB Properties Missing Host
  def test_db_props_missing_host()
    props_loc = File.join(File.dirname(__FILE__),'data','missing_host.yml')
    assert_raises(::Net::Lorynto::Poc::Dao::Exceptions::YmlPropertyMissing) do
      ::Net::Lorynto::Poc::Dao::DbPropsParser.new(props_loc)
    end
  end

  #
  # Parse DB Properties Missing Port
  def test_db_props_missing_port()
    props_loc = File.join(File.dirname(__FILE__),'data','missing_port.yml')
    assert_raises(::Net::Lorynto::Poc::Dao::Exceptions::YmlPropertyMissing) do
      ::Net::Lorynto::Poc::Dao::DbPropsParser.new(props_loc)
    end
  end

  #
  # Parse DB Properties Missing Database
  def test_db_props_missing_database()
    props_loc = File.join(File.dirname(__FILE__),'data','missing_database.yml')
    assert_raises(::Net::Lorynto::Poc::Dao::Exceptions::YmlPropertyMissing) do
      ::Net::Lorynto::Poc::Dao::DbPropsParser.new(props_loc)
    end
  end

end