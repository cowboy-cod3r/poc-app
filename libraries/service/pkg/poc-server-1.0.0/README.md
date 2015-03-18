## poc-service

* Author:  <sean.humbarger@gmail.com>

### OVERVIEW
This ruby gem is the service component that exposes a REST interface for inserting, updating, deleting, and
querying POC information.

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

### DEBUGGING
To turn on debugging:

          export LOG_LEVEL=debug

### TESTING
To test this gem:

          rake test

### COMMAND LINE


### REST API DOCUMENTATION

Please see the rest-api.md file
