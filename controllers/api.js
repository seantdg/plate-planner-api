// API controller
var request = require('request');

// Modules
module.exports = defineController;

function defineController(app) {

    app.get("/*", function(req, res) {
        res.status(404).json({error:"Not Found"});
    });

}
