# #
# # Performs on the POC Service Command Line Tool
# #
# #
# # Testing is performed by minitest.  You can find assertions here:
# #   * http://www.ruby-doc.org/stdlib-1.9.3/libdoc/minitest/unit/rdoc/MiniTest/Assertions.html
#
# # Set Classpath
# $:.unshift(File.join(File.dirname(__FILE__),'..','lib'))
#
# # Added this to the file prevent an odd warning from minitest
# gem 'minitest'
#
# # Required Libraries (Any utilities as well as the files to test)
# require 'minitest/autorun'
# require 'net/lorynto/poc/service/settings'
#
# # Module Includes
# include MiniTest::Assertions
#
# class TestPocServiceSettings < MiniTest::Test
#
#   #
#   # Setup
#   def setup
#     @props = ::Net::Lorynto::Poc::Service::Settings.instance()
#   end
#
#   #
#   # Teardown
#   def teardown
#     # noop
#   end
#
#   #
#   # Add a property
#   def test_add_property()
#     prop_value = 'myvalue'
#     @props.add_property('test',prop_value)
#     assert_equal(@props.properties['test'],prop_value)
#   end
#
#   #
#   # Update a property
#   def test_update_property()
#     prop_value = 'myvalue'
#     @props.add_property('test',prop_value)
#     assert_equal(@props.properties['test'],prop_value)
#
#     @props.add_property('test','update')
#     assert_equal(@props.properties['test'],'update')
#   end
#
#   #
#   # Verify version
#   def test_delete_property()
#     prop_value = 'myvalue'
#     @props.add_property('test',prop_value)
#     @props.delete_property('test')
#     assert_equal(false,@props.properties.has_key?('test'))
#   end
#
# end
#
