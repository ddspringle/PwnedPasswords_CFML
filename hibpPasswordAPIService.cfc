/**
*
* @file hibpPasswordAPIService
* @author Denard Springle ( denard.springle@gmail.com )
* @description I provide an interface to the Have I Been Pwned Password Checking API at https://haveibeenpwned.com/API/v2#SearchingPwnedPasswordsByRange
*
*/

component displayName="hibpPasswordAPIService" accessors="true" {

	/**
	* @displayname 	init
	* @description 	I encrypt passed in values based on scope
	* @return		this
	*/
	public function init() {
		variables.baseHref = 'https://api.pwnedpasswords.com/';
		return this;
	}

	/**
	* @displayname 	checkPassword
	* @description 	I determine if a passed in password is in the hash list and the prevalence of that password in HIBP data if it is
	* @param		password {String} - I am the password to check
	* @param		algorithm {String} default: SHA-1 - I am the hash algorithm used by HIBP to hash password data (currently SHA-1)
	* @return		struct
	*/
	public struct function checkPassword( required string password, string algorithm = 'SHA-1' ) {

		// has the password to use for checking
		var hashedPassword = hash( arguments.password, arguments.algorithm );

		// set the endpoint to get a range of hashes
		var endpoint = 'range/' & left( hashedPassword, 5 );

		// get the range of hashes
		var result = doApiCall( endpoint );

		// set up a struct to hold the results
		var returnStruct = {
			'found' = false,
			'prevalence' = 0
		};

		// loop through the results from HIBP
		for( var ix = 1; ix lte listLen( result, chr(13) ); ix++ ) {

			// check if the passed password is in the hash list
			if( findNoCase( right( hashedPassword, len( hashedPassword ) - 5 ), listFirst( listGetAt( result, ix, chr(13) ), ':' ) ) ) {

				// it is, set found to true
				returnStruct.found = true;
				// and the prevalence of this password in the list
				returnStruct.prevalence = abs( listLast( listGetAt( result, ix, chr(13) ), ':' ) );
				// stop processing this for loop
				break;

			}

		}

		// return the results
		return returnStruct;

	}


	/**
	* @displayname 	doApiCall
	* @description 	I make the call to HIBP's api, broken out in case of future API expansion by HIBP
	* @param		endpoint {String} - I am the endpoint to hit
	* @param		method {String} default: GET - I am the HTTP method used for this request
	* @return		struct
	*/
	public function doApiCall( required string endpoint, string method = 'GET' ) {

		var httpService = new http();
		httpService.setUrl( variables.baseHref & arguments.endpoint );
		httpService.setMethod( arguments.method );

		return httpService.send().getPrefix().fileContent;
	}

}