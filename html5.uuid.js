// html5.uuid.js 0.1.0
// (c) 2012 Guillaume DE LA RUE, Seventh Side Games.
// Html5.uuid may be freely distributed under the MIT license.
// For all details and documentation:
// https://github.com/html5place/html5.uuid.js
(function(exports) {

	// -> Get UUID from mobile device, or generate a random one in fallback
	var UUID = function(opts) {
		opts = opts || {} ;
		this.uuid = null ;
		this.model = opts.model || [12,4,4,4,8] ; 	// Generate an uuid like this :: 9F7791D8CE85-AAFE-4988-93B1-A7B6E99D 
		this.key = opts.key || 'html5.uuid'; 		// Key name used for localStorage
		return this;			
	}

	// -> Return in all cases a UUID
	// => Received from device
	// => Stored into localStorage
	// => If no uuid detected generate one
	UUID.prototype.get = function() {

		// Setted ? ok...
		if ( this.uuid ) {
			return this.uuid ;
		}

		// Local storage support ?
		this.localStorageSupport = ( window && window.localStorage ) ? true : false ;

		// Stored into local storage ? It's priority check
		if ( this.localStorageSupport && window.localStorage.getItem(this.key) ) {
			this.uuid = window.localStorage.getItem(this.key) ;
			return this.uuid ;
		}

		// Get uuid from device
		if ( window && window.navigator && window.navigator.uuid ) {
			this.uuid = window.navigator.uuid ;
			if ( this.localStorageSupport ) window.localStorage.setItem(this.key, this.uuid) ;
		}

		// Get uuid from local storage
		else if ( this.localStorageSupport && window.localStorage.getItem(this.key) ) {
			this.uuid = window.localStorage.getItem(this.key) ;
		}

		// Generate it and store in local storage
		else {
			this.uuid = this.generate() ;
			if ( this.localStorageSupport ) window.localStorage.setItem(this.key, this.uuid) ;
		}

		// Return finded one
		return this.uuid ;

	}

	// Generate random UUID
	UUID.prototype.generate = function() {
		var UniqueId = [], i, count, num  ;
		for ( i in this.model ) {
			count = parseInt(this.model[i]) ;
			UniqueId[i] = '' ;
			for ( num = 0 ; num < count ; num++ ) {
				UniqueId[i] += (Math.floor(Math.random()*16)).toString(16) ;
			}
		}
		return UniqueId.join('-');
	}

	// Export class
	exports.html5uuid = UUID ;

// DOM or node.js scope export
})(window||exports) ;