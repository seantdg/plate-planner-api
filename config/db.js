// Connecting to mongoDB
// Best practice is to establish connection
// once application is started and close connection
// once Node app terminates

var mongoose = require( 'mongoose' );
var cfg = require('./config.json');

//mongodb://localhost/geekthumbs
var dburl = cfg.db.dburl +'/'+ cfg.db.dbname;

// Create the database connection
// TODO handle the error if not possible to connect - give some human readable shit back
mongoose.connect(dburl);