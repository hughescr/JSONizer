//
//  JSONizer.h
//  JSONizer
//
//  Created by Craig Hughes
//

@import Foundation;

@interface JSONizer : NSObject

+ (NSString *) stringify:(id)object;
+ (NSString *) stringify:(id)object prettily:(BOOL)makePretty;

@end

@interface NSDictionary (JSONizer)
- (NSString *)toJSON;
- (NSString *)toPrettyJSON;
@end

@interface NSArray (JSONizer)
- (NSString *)toJSON;
- (NSString *)toPrettyJSON;
@end

@interface NSDate (JSONizer)
- (NSString *)toJSON;
- (NSString *)toPrettyJSON;
@end

@interface NSString (JSONizer)
- (NSString *)toJSON;
- (NSString *)toPrettyJSON;
@end

@interface NSNumber (JSONizer)
- (NSString *)toJSON;
- (NSString *)toPrettyJSON;
@end

@interface NSNull (JSONizer)
- (NSString *)toJSON;
- (NSString *)toPrettyJSON;
@end
