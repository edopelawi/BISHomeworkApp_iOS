//
//  BISTeacherEmailServiceSpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/2/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISTeacherEmailService.h"
#import "BISNetworkService.h"
#import "BISURLConstants.h"
#import "BISSharedExampleConstants.h"

SpecBegin(TeacherEmailService)

__block BISTeacherEmailService *emailService;
__block id networkService;

__block BISTeacherEmailServiceSuccessBlock successBlock;
__block BISTeacherEmailServiceFailureBlock failureBlock;
__block BOOL successBlockExecuted;
__block BOOL failureBlockExecuted;

__block NSString *networkPath;
__block NSDictionary *networkParameters;
__block BISNetworkServiceSuccessBlock networkSuccessBlock;
__block BISNetworkServiceFailureBlock networkFailureBlock;

beforeEach(^{
    networkService = OCMPartialMock([BISNetworkService new]);
    
    emailService = [[BISTeacherEmailService alloc] initWithNetworkService:networkService];
    
    successBlock = ^(NSArray *emails){
        successBlockExecuted = YES;
    };
    
    failureBlock = ^(NSString *message){
        failureBlockExecuted = YES;
    };
    
    successBlockExecuted = NO;
    failureBlockExecuted = NO;
    
    OCMStub([networkService getFromPath:[OCMArg any]
                             parameters:[OCMArg any]
                                success:[OCMArg any]
                                failure:[OCMArg any]]).andDo(^(NSInvocation *invocation){
        [invocation retainArguments];
        [invocation getArgument:&networkPath atIndex:2];
        [invocation getArgument:&networkParameters atIndex:3];
        [invocation getArgument:&networkSuccessBlock atIndex:4];
        [invocation getArgument:&networkFailureBlock atIndex:5];
    });
});

describe(@"BISNetworkServiceDependant behavior", ^{
    NSDictionary *data = @{BISSharedExampleClassKey : [BISTeacherEmailService class]};
    itBehavesLike(BISSharedExampleNetworkServiceDependant, data);
});

describe(@"on retrieving teacher emails", ^{
    
    beforeEach(^{
        [emailService retrieveTeacherEmailsWithSuccess:successBlock
                                               failure:failureBlock];
    });
    
    it(@"it should call network service's get method", ^{
        OCMVerify([networkService getFromPath:[OCMArg any]
                                   parameters:[OCMArg any]
                                      success:[OCMArg any]
                                      failure:[OCMArg any]]);
    });
    
    it(@"should pass teacher email's path to network service",^{
        expect(networkPath).to.equal(BISURLConstantTeacherEmailsPath);
    });
    
    it(@"should pass empty dictionary as parameter to network services", ^{
        expect(networkParameters).to.equal(@{});
    });
    
    context(@"when request succeeds", ^{
        before(^{
            if (!networkSuccessBlock) return;
            networkSuccessBlock(@"response");
        });
        
        it(@"should execute passed success block", ^{
            expect(successBlockExecuted).to.beTruthy();
        });
    });
    
    context(@"when request fails", ^{
        before(^{
            if (!networkFailureBlock) return;
            NSError *error = [NSError errorWithDomain:@"dummy" code:404 userInfo:@{}];
            networkFailureBlock(error);
        });
        
        it(@"should execute passed failure block", ^{
            expect(failureBlockExecuted).to.beTruthy();
        });
    });
});

SpecEnd