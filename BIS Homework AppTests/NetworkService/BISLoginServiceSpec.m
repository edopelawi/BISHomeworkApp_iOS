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

SpecBegin(LoginService)

__block BISLoginService *loginService;
__block id networkService;
__block id operationManager;

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
    
    NSURL *baseURL = [NSURL URLWithString:@"http://example.com"];
    operationManager = OCMPartialMock([[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL]);
    
    networkService = OCMPartialMock([[BISNetworkService alloc]initWithRequestOperationManager:operationManager]);
    
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

describe(@"on sending login request", ^{
    
    beforeEach(^{
        
        [loginService loginWithParameters:parameters
                                  success:successBlock
                                  failure:failureBlock];
    });
    
    it(@"should pass login path to network service", ^{
        
        expect([BISLoginPath isEqualToString:networkPath]).to.beTruthy();
        
    });
    
    it(@"should pass login parameters to network service", ^{
        
        expect([parameters isEqualToDictionary:networkParameters]).to.beTruthy();
    });
    
    context(@"when request succeed", ^{
        before(^{
            networkSuccessBlock([AFHTTPRequestOperation new], @"response!");
        });
        
        it(@"should execute passed success block", ^{
            expect(successBlockExecuted).to.beTruthy();
        });
    });
    
    context(@"when request failed", ^{
        before(^{
            NSError *error = [NSError errorWithDomain:@"dummy" code:404 userInfo:@{}];
            networkFailureBlock([AFHTTPRequestOperation new],error);
        });
        
        it(@"should executed passed failure block", ^{
            expect(failureBlockExecuted).to.beTruthy();
        });
    });
});

SpecEnd