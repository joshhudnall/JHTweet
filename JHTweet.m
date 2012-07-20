//
//  JHTweetLength.m
//  Twitter Count Demo
//
//  Created by Josh Hudnall on 7/19/12.
//  Copyright (c) 2012 Josh Hudnall. All rights reserved.
//  http://joshhudnall.com
//
//  Licensed under the Apache 2.0 License
//  http://www.apache.org/licenses/LICENSE-2.0.html
//

// TODO: There is a server call that can be made to get the actual max lengths, but for now this is fine
#define kHTTPLinkLength 20
#define kHTTPSLinkLength 21

#import "JHTweet.h"

@implementation JHTweet

static NSString *pattern = @"(?i)(\\s|:|\\()(((f|ht)tps?://)?(\\.?[a-zA-Z0-9][-a-zA-Z0-9]*)+(\\.[a-zA-Z]{2,})[-a-zA-Z0-9@:%_+~#.,!?&/\\|=]*)(-|\\+|/|\\$|\\?|!|,|\\b)";

+ (int)lengthOfTweet:(NSString *)tweet {
    int length = [tweet length];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];

    for (NSTextCheckingResult* result in [regex matchesInString:tweet 
                                                        options:0 
                                                          range:NSMakeRange(0, [tweet length])]) {
        NSRange resultRange = [result rangeAtIndex:2];   
        //NSString *matchString = [tweet substringWithRange:resultRange];
        
        length = length - resultRange.length + kHTTPLinkLength;
    }
    
    return length;
}

+ (NSString *)autolinkedTweet:(NSString *)tweet {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:tweet options:0 range:NSMakeRange(0, [tweet length]) withTemplate:@"$1<a href=\"$2\">$2</a>$7"];
    
    return result;
}

@end


/*
 NSError *error = NULL;
 NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?i)(\\s|:|\\()(((f|ht)tps?://)?(\\.?[a-zA-Z0-9][-a-zA-Z0-9]*)+(\\.[a-zA-Z]{2,})[-a-zA-Z0-9@:%_+~#.,!?&/\\|=]*)(-|\\+|/|\\$|\\?|!|,|\\b)" options:0 error:&error];
 NSString *result = [regex stringByReplacingMatchesInString:searchText options:0 range:NSMakeRange(0, [searchText length]) withTemplate:@"<a href="$2">$2</a>$7"];
*/


