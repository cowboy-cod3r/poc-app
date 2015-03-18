#
# Performs Tests against the logger class
#
# == ASSERTIONS
# Testing is performed by minitest.  You can find assertions here:
#   * http://www.ruby-doc.org/stdlib-1.9.3/libdoc/minitest/unit/rdoc/MiniTest/Assertions.html

# Set Classpath
$:.unshift(File.join(File.dirname(__FILE__),"..","lib"))

# Added this to the file prevent an odd warning from minitest
gem 'minitest'

# Required Libraries (Any utilities as well as the files to test)
require 'minitest/autorun'
require 'net/lorynto/poc/logger'


# Module Includes
include MiniTest::Assertions

class TestPocLogger < MiniTest::Test

  #
  # Set it up
  def setup
    ENV['LOG_LEVEL'] = 'debug'
    @logger = ::Net::Lorynto::Poc::Logger.instance()
  end

  #
  # Tear it down
  def teardown
  end

  #
  # No assertions, just make run it and see if it errors
  def test_logger()
    @logger.debug("Debug Message...")
    @logger.info("Info Message...")
    @logger.warn("Warn Message...")
    @logger.error("Error Message...")
    @logger.fatal("Fatal Message...")
  end

end