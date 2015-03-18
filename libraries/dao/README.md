## poc-dao

* Author:  <sean.humbarger@gmail.com>

### OVERVIEW
This ruby gem is the dao component that exposes for the POC applications.

1. **Rake** - Build Tool
2. **Hoe** - Helper tool for rake to assist with common tasks when building with rubygems.
3. **Minitest** - Testing Framework
4. **Yard** - Documentation Framework
5. **mongo_mapper** - Data Framework for communicating with MongoDB.  Solve the impedence mismatch problem.

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

### TESTING
To test this gem:

        rake test

### CONFIGURATION
By default, the connection to mongo will be made to the `localhost` over port `27017`.  To override the default
connection parameters, set the `POC_DAO_PROPS` environment variable to the location of your custom YAML file that
contains new configuraiton parameters.  You can find the default YAML file in the `config` directory.

### DOCUMENTATION
To build documentation for this rubygem:

        yardoc

### USAGE
The following describes some basic uses for the classes in this DAO.

        # Required Libraries
        require 'poc-dao'

        # Add Poc
        poc_record = {
          :first_name    => 'John,
          :middle_name   => 'Matthew',
          :last_name     => 'Doe',
          :addresses     => [],
          :emails        => [],
          :phone_numbers => []
        }
        poc = ::Poc.create!(record)

        # Add email
        poc.emails << ::Email({:type => 'Work', :email => 'john.doe@blah.com'})
        poc.save!

        # Modify Poc
        poc.first_name = 'Sam'
        poc.save!

        # Delete Poc
        ::Poc.delete(poc.id.to_s)

        # Query for all records
        query = ::Poc.all()

        # Count records
        count = ::Poc.count()

        # Find by Id
        query = ::Poc.find(poc.id.to_s)

        # Ping the database
        db_utils = ::Net::Lorynto::Poc::Dao::Utilities.new()
        db_utils.db_ping()



