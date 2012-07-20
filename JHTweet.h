//
//  JHTweetLength.h
//  Twitter Count Demo
//
//  Created by Josh Hudnall on 7/19/12.
//  Copyright (c) 2012 Josh Hudnall. All rights reserved.
//  http://joshhudnall.com
//
//  Licensed under the Apache 2.0 License
//  http://www.apache.org/licenses/LICENSE-2.0.html
//

#import <Foundation/Foundation.h>

@interface JHTweet : NSObject

+ (int)lengthOfTweet:(NSString *)tweet;
+ (NSString *)autolinkedTweet:(NSString *)tweet;

@end
