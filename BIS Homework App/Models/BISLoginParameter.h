//
//  BISLoginParameter.h
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import <Mantle.h>

@interface BISLoginParameter : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@end
