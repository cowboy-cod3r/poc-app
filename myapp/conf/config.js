//
// Config file for this application
//
// When you want to use this config file, just do this:
//
//         var config = require('/path/to/config.js')
//

// Setup initial config object
var config = {}
config.webapp = {};

// Basic Settings
config.webapp.port = 9980;
config.webapp.hostname = 'localhost';

// Export this module to make it avaialable
module.exports = config;
