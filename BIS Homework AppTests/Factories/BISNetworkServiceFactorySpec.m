//
//  BISNetworkServiceFactorySpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISNetworkService.h"
#import "BISNetworkManagerFactory.h"

#import <AFNetworking.h>

@interface BISNetworkService (FactoryTest)

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end

SpecBegin(NetworkServiceFactory)

describe(@"networkService factory method", ^{
    
    __block BISNetworkService *networkService;
    __block id operationManager;
    __block id BISNetworkManagerFactoryMock;
    
    beforeEach(^{
        operationManager = OCMPartialMock([AFHTTPRequestOperationManager new]);
        
        BISNetworkManagerFactoryMock = OCMClassMock([BISNetworkManagerFactory class]);
        
        OCMStub([BISNetworkManagerFactoryMock AFHTTPRequestOperationManagerForBISServer]).andReturn(operationManager);
        
        networkService = [BISNetworkService networkService];
    });
    
    it(@"should return BISNetworkService object", ^{
        expect(networkService).to.beInstanceOf([BISNetworkService class]);
    });
    
    it(@"should use operation manager object from BISNetworkManagerFactory's AFHTTPRequestOperationManagerForBISServer method", ^{
        
        expect(networkService.operationManager).to.beIdenticalTo(operationManager);
    });
});

SpecEnd
