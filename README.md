# Have I Been Pwned - Pwned Passwords CFML (ColdFusion) API Wrapper
This repository includes a CFC called hibpPasswordApiService.cfc that makes use of the Have I Been Pwned Password list - [Pwned Passwords](https://haveibeenpwned.com/API/v2#SearchingPwnedPasswordsByRange) are more than half a billion passwords which have previously been exposed in data breaches.

## Usage

To use this wrapper, simply initialize it, as follows:

    // initialize the Pwned Passwords service
	apiService = new hibpPasswordAPIService();

You then call the service with the password you wish to check, as follows:

    // get the structure as a variable from the Pwned Passwords service    
	isFoundStruct = apiService.checkPassword( 'password' );

The checkPassword function returns a struct with the following keys:

    found: true if the password is found, false otherwise
    prevalence: the number of times this password shows up in the list

**NOTE**: A password that shows up even **once** in the list represents a threat. However, we return the prevalence of the password so you can guage if you want to allow usage of password with a prevalence below some threshold you determine. Passwords with a lower prevalence may be less likely to be used in brute force attacks, but they remain a threat nontheless.

## Compatibility

* Adobe ColdFusion 11+
* Lucee 4.5+

## Bugs and Feature Requests

If you find any bugs or have a feature you'd like to see implemented in this code, please use the issues area here on GitHub to log them.

## Contributing

This project is actively being maintained and monitored by Denard Springle. If you would like to contribute to this project please feel free to fork, modify and send a pull request!

## License

The use and distribution terms for this software are covered by the Apache Software License 2.0 (http://www.apache.org/licenses/LICENSE-2.0).
