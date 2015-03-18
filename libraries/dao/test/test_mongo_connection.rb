#
# Performs Tests

# Set Classpath
$:.unshift(File.join(File.dirname(__FILE__),'..','lib'))

# Added this to the file prevent an odd warning from minitest
gem 'minitest'

# Required Libraries (Any utilities as well as the files to test)
require 'minitest/autorun'

# Module Includes
include MiniTest::Assertions

class TestMongoConnection < MiniTest::Test

  #
  # Set it up
  def setup
  end

  #
  # Parse DB Properties
  def test_db_connection()
    require 'net/lorynto/poc/dao/utilities'
    db_utils = ::Net::Lorynto::Poc::Dao::Utilities.new()
    db_utils.bootstrap()
  end

end