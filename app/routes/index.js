'use strict';

var path = process.cwd();
var getRequestHandlers = require(path + '/app/controllers/requestHandlers.server.js');

module.exports = function (app, passport) {
	
	var handlers = getRequestHandlers(); 
	
	app.route('/')
		.get(function (req, res) {
			res.sendFile(path + '/public/index.html');
		});

	app.route('/search/:query')
		.get(handlers.search);

	app.route('/list')
		.get(handlers.list);
};
