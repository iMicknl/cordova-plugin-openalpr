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
	}

};

module.exports = OpenALPR;
