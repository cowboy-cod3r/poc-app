## poc-logger

* Author:  <sean.humbarger@gmail.com>

### OVERVIEW
The is the common logging gem for any rubygems that are written to support the **poc-app**.  There isn't really anything
special about this logger as it simply extends the ruby `Logger` class however, it is implemented as a singleton.

### TECHNOLOGIES USED

1. **Rake** - Build Tool
2. **Hoe** - Helper tool for rake to assist with common tasks when building with rubygems.
3. **Minitest** - Testing Framework
4. **Yard** - Documentation Framework

### PRE-INSTALL
You must have ruby installed as well as the bundler gem.  Once you have those two items installed, execute the following:

        rake check_extra_deps

### BUILD
To build this gem:

        rake package

### INSTALLATION
To install this gem:

        # Install from this git checkout
        rake install_gem

### CONFIGURATION
There are two main configurations for this logger.  By default, all logging is done to **STDOUT** and the default
log level is **ERROR**.  To change this, you can set two environment variables to modify these settings:

        export LOG_LEVEL=DEBUG
        export LOG_LOCATION=/path/to/log/file

Valid log levels for the LOG_LEVEL environment variables are as follows:

* DEBUG
* INFO
* WARN
* ERROR
* FATAL

### TESTING
To test this gem:

        rake test

### DOCUMENTATION
To build documentation for this rubygem:

        yardoc

### USAGE
Here is an example usage of this logger:

        require 'poc-logger'
        @logger = ::Net::Lorynto::Poc::Logger.instance()
        @logger.debug("Here is a debug message")
        @logger.info("Here is an info message")
        @logger.warn("Here is a warning message")
        @logger.error("Here is an error message")
        @logger.fatal("Here is a fatal message")
