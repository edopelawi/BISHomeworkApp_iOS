//
//  BISNetworkService_LoginSpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 1/30/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISNetworkService.h"
#import <AFNetworking.h>

SpecBegin(NetworkService)

__block BISNetworkService *networkService;
__block id manager;
__block id serializer;


beforeEach(^{
    NSURL *baseURL = [[NSURL alloc] initWithString:@"http://example.com"];
    
    manager = OCMPartialMock([[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL]);
    serializer = OCMPartialMock([AFHTTPRequestSerializer serializer]);
    OCMStub([manager requestSerializer]).andReturn(serializer);
    
    networkService = [[BISNetworkService alloc] initWithRequestOperationManager:manager];
});

SpecEnd