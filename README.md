HTML5 + iOS :: UUID SUPPORT
===========================

DESCRIPTION
-----------

Provides a Universal Unique Device Identifier (UUID) alternative for HTML5/iOS webApps.

HTML5 Implementation
-------------------

An uuid is generated and stored into localStorage.
If uuid libs are called from your iOS application like described below, 'window.navigator.uuid' will be used.

An example is provided into 'example.html'

In your HTML :

	<script type="text/javascript" src="js/libs/html5.uuid.js/html5.uuid.js"></script>

In your JS :
	
	var uuid = (new html5uuid()).get() ;


iOS Implementation
------------------

For iOS, this lib generates an uuid specific for each application, stored into application settings
=> Since iOS 5, application settings are synced with iCloud, so uuid follow the player on each device he used.

* Drag and drop the 'ios.uuid' folder into your xCode project
* Put that in your viewController :
	
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
