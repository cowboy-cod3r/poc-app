/* GET Go to the Home page. */
module.exports.initialize = function(app){

  app.get('/', function(req, res) {
    //res.send('Hello World!');
    res.render('index', { title: 'Hey', message: 'Hello World' });
  });

  // other routes

};
