JSONify
=======

This is a simple library that uses the JavaScriptCore framework in iOS7+ to produce JSON from Objective-C objects.

It works on these:

   Objective-C type  |   JavaScript type
 --------------------|---------------------
        NSNull       |        null
       NSString      |       string
       NSNumber      |   number, boolean
        NSDate       |     Date object
     NSDictionary    |   Object object
       NSArray       |    Array object

If you pass it some other kind of Objective-C object, it might just silently do the wrong thing, or break, or do something even worse.  So don't.

There are also class extensions provided for all those Objective-C classes listed above.  You can get .toJSON or .toPrettyJSON from any of thos classes and it'll give you a nice NSString.

TODO
----

Someday soon, maybe we'll go the opposite direction too, via JSON.parse() to re-create NSObjects from JSON strings.

Apple NSDate -> Javascript Date bug
-----------------------------------

There is a bug in Apple's implementation of converting NSDate objects into Javascript Date objects using JavaScriptCore.  The bug is described [here](http://stackoverflow.com/questions/21324601/javascriptcore-framework-objective-c-api-introduced-with-ios-7-gives-a-bad-nsdat).  This library will check if that bug exists (in case apple decides some day to fix it), and if the bug is present, it will automatically patch up all your NSDates so that they're correct Dates on the JS side, so they stringify correctly in JSON. **NOTE THIS BUG DOES APPEAR TO NOW BE FIXED ON RECENT OSX VERSIONS**

Javascript Date -> String Conversion Issue
------------------------------------------

Another fun thing is that Javascript's Date object only seems to tract completed milliseconds, whereas NSDate has higher than millisecond resolution; this means that if you use an NSDateFormatter to convert the NSDate to a string, you'll get a different result than NSDate -> JS Date Object -> String, as the first of those two steps discards partial milliseconds by rounding down, rather than by rounding to the nearest millisecond.  So in order to get the same result as NSDateFormatter, this library will pre-round any NSDates passed in to the nearest millisecond, instead of rounding down like the Javascript VM normally does.

Performance
-----------

Dunno.  I should try comparing against JSONKit or something.
