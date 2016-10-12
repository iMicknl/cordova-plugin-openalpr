'use strict';
/* global cordova */

var exec = require('cordova/exec');

var OpenALPR = {

	echo: function (message) {
		console.log('called echo');
		exec(null, null, "OpenALPR", "echo", [message]); //TODO Add succes & error handler
	},

	scan: function (filepath) {
		console.log('called scan');
		exec(
			function callback(data) {
				console.log(data);
			},
			function error(err) {
				console.error(err);
			},
			"OpenALPR", "scan", [filepath]);
	}

};

module.exports = OpenALPR;
