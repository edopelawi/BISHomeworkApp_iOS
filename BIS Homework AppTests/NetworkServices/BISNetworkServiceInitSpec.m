//
//  BISNetworkServiceInitSpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISNetworkService.h"
#import <AFNetworking.h>

SpecBegin(NetworkServiceInitialization)

__block BISNetworkService *networkService;

it(@"should raise NSInternalInconsistencyException if initialized using init: method", ^{
    expect(^{
        networkService = [BISNetworkService new];
    }).to.raise(NSInternalInconsistencyException);
});

describe(@"on initWithRequestOperationManager:", ^{
    
    it(@"should raise exception if nil passed as parameter", ^{
        expect(^{
            networkService = [[BISNetworkService alloc] initWithRequestOperationManager:nil];
        }).to.raise(NSInternalInconsistencyException);
    });
    
    it(@"should return BISNetworkService object", ^{
        networkService = [[BISNetworkService alloc] initWithRequestOperationManager:[AFHTTPRequestOperationManager new]];
        expect(networkService.class).to.equal(BISNetworkService.class);
    });
});

SpecEnd
