//
//  BISLoginParameter.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISLoginParameter.h"

@implementation BISLoginParameter

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"username" : @"name",
             @"password" : @"pass"
             };
}

- (NSString *)username
{
    if (!_username) _username = @"";
    return _username;
}

- (NSString *)password
{
    if (!_password) _password = @"";
    return _password;
}

@end
