//
//  JSONizerTests.m
//  JSONizerTests
//
//  Created by Craig Hughes
//

#import <XCTest/XCTest.h>

#import "JSONizer.h"

@interface JSONizerTests : XCTestCase

@end

@implementation JSONizerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNil
{
    XCTAssertEqualObjects([JSONizer stringify:nil],
                          @"",
                          @"Nil did not stringify correctly");
}

- (void)testNull
{
    XCTAssertEqualObjects([JSONizer stringify:[NSNull null]],
                          @"null",
                          @"Null did not stringify correctly");
}

- (void)testNullByExtension
{
    XCTAssertEqualObjects([NSNull null].toJSON,
                          @"null",
                          @"Null did not stringify correctly");
}

- (void)testString
{
    NSString *basicString = [JSONizer stringify:@"Hello World!"];
    XCTAssertEqualObjects(basicString, @"\"Hello World!\"", @"String did not stringify correctly");
}

- (void)testStringByExtension
{
    XCTAssertEqualObjects(@"Hello World!".toJSON,
                          @"\"Hello World!\"",
                          @"String did not stringify correctly");
}

- (void)testNumber
{
    XCTAssertEqualObjects( [JSONizer stringify:@1],
                          @"1",
                          @"Number did not stringify correctly");
}

- (void)testNumberByExtension
{
    XCTAssertEqualObjects((@1).toJSON,
                          @"1",
                          @"Number did not stringify correctly");
}

- (void)testDate
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"'\"'yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ'\"'"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];


    XCTAssertEqualObjects([JSONizer stringify:now],
                          [formatter stringFromDate:now],
                          @"Date did not match");
}

- (void)testDateByExtension
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"'\"'yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ'\"'"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    XCTAssertEqualObjects(now.toJSON,
                          [formatter stringFromDate:now],
                          @"Date did not match");
}

- (void)testKeyValue
{
    XCTAssertEqualObjects([JSONizer stringify:@{ @"key": @1 }],
                          @"{\"key\":1}",
                          @"Object did not stringify correctly");
}

- (void)testKeyValueByExtension
{
    XCTAssertEqualObjects(@{ @"key": @1 }.toJSON,
                          @"{\"key\":1}",
                          @"Object did not stringify correctly");
}

- (void)testArray
{
    XCTAssertEqualObjects([JSONizer stringify:(@[@1,@2,@3])],
                          @"[1,2,3]",
                          @"Array did not stringify correctly");
}

- (void)testArrayByExtension
{
    XCTAssertEqualObjects((@[@1,@2,@3]).toJSON,
                          @"[1,2,3]",
                          @"Array did not stringify correctly");
}

- (void)testKeyValueWithNull
{
    XCTAssertEqualObjects([JSONizer stringify:@{ @"key": [NSNull null] }],
                          @"{\"key\":null}",
                          @"Object did not stringify correctly");
}

- (void)testKeyValueWithNullByExtension
{
    XCTAssertEqualObjects((@{ @"key": [NSNull null] }).toJSON,
                          @"{\"key\":null}",
                          @"Object did not stringify correctly");
}

- (void)testObjectWithDateInIt
{
    NSDate *now = [NSDate date];
    NSDictionary *dict = @{ @"straight": now };
    NSArray *array = @[now, dict];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"'\"'yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ'\"'"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    NSString *expected = [NSString stringWithFormat:@"[%@,{\"straight\":%@}]", [formatter stringFromDate:now], [formatter stringFromDate:now]];

    XCTAssertEqualObjects([JSONizer stringify:array],
                          expected,
                          @"Nested objects did not stringify dates correctly");
}

- (void)testObjectWithDateInItByExtension
{
    NSDate *now = [NSDate date];
    NSDictionary *dict = @{ @"straight": now };
    NSArray *array = @[now, dict];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"'\"'yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ'\"'"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    NSString *expected = [NSString stringWithFormat:@"[%@,{\"straight\":%@}]", [formatter stringFromDate:now], [formatter stringFromDate:now]];

    XCTAssertEqualObjects(array.toJSON,
                          expected,
                          @"Nested objects did not stringify dates correctly");
}

@end
