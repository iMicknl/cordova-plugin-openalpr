'use strict';
/* global cordova */

var exec = require('cordova/exec');

var OpenALPR = {

    /**
     * Scan license plate with OpenALPR
     *
     * @param filepath Path to image
     * @param success callback function on success
     * @param error callback function on failure.
     * @returns array licenseplate matches
     */
	scan: function(filepath, success, error) {
		console.log('called scan for: ' + filepath);
		exec(
			success,
			error,
			'OpenALPR',
			'scan',
			[filepath]
		)
	}
};

module.exports = OpenALPR;
