HTML5 + iOS :: UUID SUPPORT
===========================


DESCRIPTION
-----------

Provides a Universally Unique IDentifier (UUID) alternative for HTML5/iOS webApps.

If iOS libs are used, uuid will be stored and will be the same on each iCloud devices.
If only HTML5, a random uuid will be generated and stored in local storage.


HTML5 Implementation
-------------------

An uuid is generated and stored into localStorage.
If uuid libs are called from your iOS application like described below, 'window.navigator.uuid' will be used.

An example is provided into 'example.html'

In your HTML :

	<script type="text/javascript" src="html5.uuid.js"></script>

In your JS :
	
	var uuid = (new html5uuid()).get() ;

or 

	var uuid = new html5uuid({
		key: 'name of the key in local storage',		// default: 'html5.uuid'
		model: [12,4,4,4,8]								// default: [8,4,4,4,12]
	}) ;
	uuid.get() ;


iOS Implementation
------------------

For iOS, this lib generates an uuid specific for each application, stored into application settings

Since iOS 5, application settings are synced with iCloud, so uuid follow the player on each device he used.

* Drag and drop the 'ios.uuid' folder into your xCode project
* Put that in your viewController :

<code>
	#import "UUID.h"

	- (void)webViewDidStartLoad:(UIWebView *)webView
	{

		...

	    // Create a UDID, store it to defaults and set uuid to webView via JS
	    // will register window.navigator.uuid 
	    [[UUID sharedInstance] sendToWebview: webView] ;

	    // Or simply get uuid
	    UUID *uuid = [UUID sharedInstance] ;
   		NSLog(@"UUID Output :: %@", uuid->value ) ;

	    ..

	}
</code>
