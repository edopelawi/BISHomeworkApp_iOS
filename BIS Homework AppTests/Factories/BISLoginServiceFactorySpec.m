//
//  BISLoginServiceFactorySpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISLoginService.h"
#import "BISNetworkService.h"

@interface BISLoginService (FactoryTest)

@property (nonatomic, strong) BISNetworkService *networkService;

@end

SpecBegin(LoginServiceFactory)

describe(@"loginService factory method", ^{
    
    __block BISLoginService *loginService;
    __block id networkService;
    __block id BISNetworkServiceMock;

    
    beforeEach(^{
        networkService = OCMPartialMock([BISNetworkService networkService]);
        
        BISNetworkServiceMock = OCMClassMock([BISNetworkService class]);
        OCMStub([BISNetworkServiceMock networkService]).andReturn(networkService);
        
        loginService = [BISLoginService loginService];
    });
    
    afterEach(^{
        [BISNetworkServiceMock stopMocking];
    });
    
    it(@"should return instance of BISLoginService", ^{
        expect(loginService).to.beInstanceOf([BISLoginService class]);
    });
    
    it(@"should retrieve network service from BISNetworkService's factory method", ^{
        expect(loginService.networkService).to.beIdenticalTo(networkService);
    });
});

SpecEnd
