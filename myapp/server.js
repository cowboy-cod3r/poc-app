//
// This is the file that bootstraps the application
//


// Libraries
// TODO: What are other libraries we can use that are useful
var express = require('express')
var path = require('path')
var config = require('./conf/config.js')
var routes = require('./routes/routes.js')

// Initialize  Express Server
var app = express()

//
app.use('/', express.static(path.join(__dirname, 'public')))
app.use('/', express.static(path.join(__dirname, 'bower_components','bootstrap','dist')))
app.use('/', express.static(path.join(__dirname, 'bower_components','bootstrap','less')))
app.use('/', express.static(path.join(__dirname, 'bower_components','jquery','dist')))
app.use('/', express.static(path.join(__dirname, 'bower_components','bootswatch')))
app.use('/', express.static(path.join(__dirname, 'bower_components','holderjs')))

// Make the routes available
routes.initialize(app)

// Declare the templating engine you want to use
app.set('views', './views')
app.set('view engine', 'jade')

// Start up the expressjs server
var server = app.listen(config.webapp.port, function () {

  // Some local vars for this callback
  var host = server.address().address
  var port = config.webapp.port

  // Output
  console.log('example app listening at http://%s:%s', host, port)
})
