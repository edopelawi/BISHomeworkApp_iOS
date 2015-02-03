//
//  BISHomeworkServiceFactory.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISHomeworkService.h"
#import "BISNetworkService.h"

@interface BISHomeworkService (FactoryTest)

@property (nonatomic, strong) BISNetworkService *networkService;

@end

SpecBegin(HomeworkServiceFactory)

describe(@"loginService factory method", ^{
    
    __block BISHomeworkService *homeworkService;
    __block id BISNetworkServiceMock;
    __block id networkService;
    
    beforeEach(^{
        networkService = OCMPartialMock([BISNetworkService new]);
        
        BISNetworkServiceMock = OCMClassMock([BISNetworkService class]);
        OCMStub([BISNetworkServiceMock networkService]).andReturn(networkService);
        
        homeworkService = [BISHomeworkService homeworkService];
    });
    
    afterEach(^{
        [BISNetworkServiceMock stopMocking];
    });
    
    it(@"should return instance of BISLoginService", ^{
        expect(homeworkService).to.beInstanceOf([BISHomeworkService class]);
    });
    
    it(@"should retrieve network service from BISNetworkService's factory method", ^{
        expect(homeworkService.networkService).to.beIdenticalTo(networkService);
    });
});

SpecEnd