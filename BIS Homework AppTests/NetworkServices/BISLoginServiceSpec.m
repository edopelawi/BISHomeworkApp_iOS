//
//  BISLoginServiceSpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 1/31/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISLoginService.h"
#import "BISNetworkService.h"
#import "BISURLConstants.h"
#import "BISSharedExampleConstants.h"

SpecBegin(LoginService)

__block BISLoginService *loginService;
__block id networkService;

__block NSDictionary *parameters;
__block BISLoginServiceSuccessBlock successBlock;
__block BISLoginServiceFailureBlock failureBlock;
__block BOOL successBlockExecuted;
__block BOOL failureBlockExecuted;

__block NSString *networkPath;
__block NSDictionary *networkParameters;
__block BISNetworkServiceSuccessBlock networkSuccessBlock;
__block BISNetworkServiceFailureBlock networkFailureBlock;

beforeEach(^{
    
    networkService = OCMPartialMock([BISNetworkService new]);
    
    loginService = [[BISLoginService alloc] initWithNetworkService:networkService];
    
    parameters = @{@"name" : @"hello"};
    
    successBlock = ^{
        successBlockExecuted = YES;
    };
    
    failureBlock = ^(NSString *errorMessage){
        failureBlockExecuted = YES;
    };
    
    successBlockExecuted = NO;
    failureBlockExecuted = NO;
    
    OCMStub([networkService postToPath:[OCMArg any]
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
    NSDictionary *data = @{BISSharedExampleClassKey : [BISLoginService class]};
    itBehavesLike(BISSharedExampleNetworkServiceDependant, data);
});

describe(@"on sending login request", ^{
    
    beforeEach(^{
        [loginService loginWithParameters:parameters
                                  success:successBlock
                                  failure:failureBlock];
    });
    
    it(@"should call networkService's post method", ^{
        OCMVerify([networkService postToPath:[OCMArg any]
                                  parameters:[OCMArg any]
                                     success:[OCMArg any]
                                     failure:[OCMArg any]]);
    });
    
    it(@"should pass login path to network service", ^{

        expect(networkPath).to.equal(BISURLConstantLoginPath);
        
    });
    
    it(@"should pass login parameters to network service", ^{
        
        expect(parameters).to.equal(networkParameters);
        
    });
    
    context(@"when request succeed", ^{
        before(^{
            if (!networkSuccessBlock) return;
            networkSuccessBlock(@"response!");
        });
        
        it(@"should execute passed success block", ^{
            expect(successBlockExecuted).to.beTruthy();
        });
    });
    
    context(@"when request failed", ^{
        before(^{
            if (!networkFailureBlock) return;
            NSError *error = [NSError errorWithDomain:@"dummy" code:404 userInfo:@{}];
            networkFailureBlock(error);
        });
        
        it(@"should executed passed failure block", ^{
            expect(failureBlockExecuted).to.beTruthy();
        });
    });
});

SpecEnd