//
//  BISNetworkService.h
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 1/30/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperationManager;

@interface BISNetworkService : NSObject

- (instancetype)initWithRequestOperationManager:(AFHTTPRequestOperationManager *)manager;

@end
