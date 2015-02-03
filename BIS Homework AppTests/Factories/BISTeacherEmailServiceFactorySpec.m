//
//  BISTeacherEmailServiceFactorySpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISTeacherEmailService.h"
#import "BISNetworkService.h"

@interface BISTeacherEmailService (FactoryTest)

@property (nonatomic, strong) BISNetworkService *networkService;

@end

SpecBegin(TeacherEmailServiceFactory)

describe(@"loginService factory method", ^{
    
    __block BISTeacherEmailService *teacherEmailService;
    __block id BISNetworkServiceMock;
    __block id networkService;
    
    beforeEach(^{
        networkService = OCMPartialMock([BISNetworkService new]);
        
        BISNetworkServiceMock = OCMClassMock([BISNetworkService class]);
        OCMStub([BISNetworkServiceMock networkService]).andReturn(networkService);
        
        teacherEmailService = [BISTeacherEmailService teacherEmailService];
    });
    
    afterEach(^{
        [BISNetworkServiceMock stopMocking];
    });
    
    it(@"should return instance of BISLoginService", ^{
        expect(teacherEmailService).to.beInstanceOf([BISTeacherEmailService class]);
    });
    
    it(@"should retrieve network service from BISNetworkService's factory method", ^{
        expect(teacherEmailService.networkService).to.beIdenticalTo(networkService);
    });
});

SpecEnd
