//
//  BISNetworkManagerFactory.h
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperationManager;

@interface BISNetworkManagerFactory : NSObject

+ (AFHTTPRequestOperationManager *)AFHTTPRequestOperationManagerForBISServer;

@end
