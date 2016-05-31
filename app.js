
// Dependencies
var config = {
    port: process.env.PORT || 3000
};

var express = require('express');
var mongoose = require('mongoose');

// Main entry point
initApp();

// Methods
function initApp () {
    var app = express();
    // Database connection
    var db = require('./config/db');
    configureExpress(app);
    startApp(app);
    module.exports = app;
}

function configureExpress (app) {
    app.disable('x-powered-by');
    app.use(express.compress());
    app.use(express.bodyParser());
}

function startApp (app) {
    app.listen(config.port, function (err) {
        if (err) {
            console.error('App didn\'t start:');
            console.error(err.stack);
            process.exit(1);
        }
        console.log('api started on port ' + config.port);
    });
}
