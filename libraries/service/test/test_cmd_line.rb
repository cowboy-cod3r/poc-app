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
# #require 'issinc/we/product_env/impl/products'
# #require 'issinc/we/product_env/exceptions'
#
# # Module Includes
# include MiniTest::Assertions
#
# class TestPocServiceCli < MiniTest::Test
#
#   def setup
#     @poc_service_exec = File.join(File.dirname(__FILE__),'..','bin','poc-service')
#   end
#
#   def teardown
#     # noop
#   end
#
#   # The command help
#   def test_command_help()
#     # with -h
#     output = IO.popen("#{@poc_service_exec} -h")
#     assert_match(/COMMANDS/, output.read)
#
#     # without -h
#     output = IO.popen("#{@poc_service_exec}")
#     assert_match(/COMMANDS/, output.read)
#
#     # with --help
#     output = IO.popen("#{@poc_service_exec} --help")
#     assert_match(/COMMANDS/, output.read)
#
#     # with help
#     output = IO.popen("#{@poc_service_exec} help")
#     assert_match(/COMMANDS/, output.read)
#   end
#
#   #
#   # Verify version
#   def test_version()
#     version = File.read(File.join(File.dirname(__FILE__),'..','VERSION'))
#
#     # with -v
#     output = IO.popen("#{@poc_service_exec} -v")
#     assert_match(/#{version}/, output.read)
#
#     # without --version
#     output = IO.popen("#{@poc_service_exec} --version")
#     assert_match(/#{version}/, output.read)
#   end
#   # # Run Help
#   # def test_run_subcommand_help()
#   #   # with -h
#   #   output = IO.popen("#{@poc_service_exec} run -h")
#   #   assert_match(/run -/, output.read)
#   #
#   #   # with --help
#   #   output = IO.popen("#{@poc_service_exec} run --help")
#   #   assert_match(/run -/, output.read)
#   # end
#   #
#   # # Stop Help
#   # def test_stop_subcommand_help()
#   #   # with -h
#   #   output = IO.popen("#{@poc_service_exec} stop -h")
#   #   assert_match(/stop -/, output.read)
#   #
#   #   # with --help
#   #   output = IO.popen("#{@poc_service_exec} stop --help")
#   #   assert_match(/stop -/, output.read)
#   # end
#
#
#
#
# end
#
