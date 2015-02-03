//
//  BISNetworkManagerFactory.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISNetworkManagerFactory.h"
#import "BISURLConstants.h"

#import <AFNetworking.h>

@implementation BISNetworkManagerFactory

+ (AFHTTPRequestOperationManager *)AFHTTPRequestOperationManagerForBISServer
{
    NSURL *baseURL = [NSURL URLWithString:BISURLConstantBase];
    AFHTTPRequestOperationManager *operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    operationManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    return operationManager;
}

@end
