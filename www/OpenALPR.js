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
		exec(null, null, "OpenALPR", "scan", [filepath]); //TODO Add succes & error handler
	},

	getString: function() {
		console.log('Called getString');
		exec(
			function callback(data) {
				console.log(data);
			},
			function errorHandler(err) {
				console.log('Error');
			},
			'OpenALPR',
			'getString',
			[]
		)
	}

};

module.exports = OpenALPR;
