'use strict';

var DEFAULT_COUNTRY = 'eu';
var DEFAULT_AMOUNT = 3;

var exec = require('cordova/exec');

var OpenALPR = {

    /**
     * Scan license plate with OpenALPR
     *
     * @param filepath Path to image
	 * @param country Country to be used, default is eu
     * @param success callback function on success
     * @param error callback function on failure.
     * @returns array licenseplate matches
     */
	scan: function(filepath, options, success, error) {
		exec(
			success,
			error,
			'OpenALPR',
			'scan',
			[filepath, validateOptions(options)]
		)
	}
};

/**
 * Function to validate and when neccessary correct the options object.
 * 
 * @param {*} options 
 * @return {*} options
 */
function validateOptions(options) {
	//Check if options is set and is an object.
	if(! options || ! typeof options === 'object') {
		return {
			country: DEFAULT_COUNTRY,
			amount: DEFAULT_AMOUNT
		}
	}

	//Check if country property is set.
	if (! options.hasOwnProperty('country')) {
		options.country = DEFAULT_COUNTRY;
	}

	//Check if amount property is set.
	if (! options.hasOwnProperty('amount')) {
		options.amount = DEFAULT_AMOUNT;
	}

	return options;
}

module.exports = OpenALPR;
