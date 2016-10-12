'use strict';
/* global cordova */

var exec = require('cordova/exec');

var OpenALPR = {

    /**
     * Scan license plate with OpenALPR
     *
     * @param filepath Path to image
     * @returns array licenseplate matches
     */
	scan: function(filepath) {
		console.log('called scan for: ' + filepath);
		exec(
			function callback(data) {
				console.log(data);
				alert(data[0].number);
			},
			function error(err) {
				console.error(err);
			},
			'OpenALPR',
			'scan',
			[filepath]
		)
	}
};

module.exports = OpenALPR;
