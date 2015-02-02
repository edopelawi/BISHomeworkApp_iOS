//
//  BISNetworkServiceSpec.m
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

__block NSString *path;
__block NSDictionary *parameters;
__block BISNetworkServiceSuccessBlock successBlock;
__block BISNetworkServiceFailureBlock failureBlock;
__block BOOL successBlockExecuted;
__block BOOL failureBlockExecuted;

__block NSString *managerPath;
__block NSDictionary *managerParameters;
__block void (^managerSuccessBlock) (AFHTTPRequestOperation *operation, id responseObject);
__block void (^managerFailureBlock) (AFHTTPRequestOperation *operation, NSError *error);

beforeEach(^{
    NSURL *baseURL = [[NSURL alloc] initWithString:@"http://example.com"];
    
    manager = OCMPartialMock([[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL]);
    id serializer = OCMPartialMock([AFHTTPRequestSerializer serializer]);
    OCMStub([manager requestSerializer]).andReturn(serializer);
    
    networkService = [[BISNetworkService alloc] initWithRequestOperationManager:manager];
    
    path = @"/dummy";
    parameters = @{@"param" : @"hello"};
    
    successBlock = ^(id response){
        successBlockExecuted = YES;
    };
    
    failureBlock = ^(NSError *error){
        failureBlockExecuted = YES;
    };
    
    successBlockExecuted = NO;
    failureBlockExecuted = NO;
    
    void (^managerStubBlock) (NSInvocation *invocation) = ^(NSInvocation *invocation){
        
        [invocation retainArguments];
        [invocation getArgument:&managerPath atIndex:2];
        [invocation getArgument:&managerParameters atIndex:3];
        [invocation getArgument:&managerSuccessBlock atIndex:4];
        [invocation getArgument:&managerFailureBlock atIndex:5];
        
    };
    
    OCMStub([manager POST:[OCMArg any]
               parameters:[OCMArg any]
                  success:[OCMArg any]
                  failure:[OCMArg any]]).andDo(managerStubBlock);
    
    OCMStub([manager POST:[OCMArg any]
               parameters:[OCMArg any]
                  success:[OCMArg any]
                  failure:[OCMArg any]]).andDo(managerStubBlock);
});

describe(@"on postToPath:parameters:success:failure:", ^{
    
    beforeEach(^{
        [networkService postToPath:path
                        parameters:parameters
                           success:successBlock
                           failure:failureBlock];
    });
    
    it(@"should call operation manager's POST:parameters:success:failure method", ^{
        OCMVerify([manager POST:[OCMArg any]
                     parameters:[OCMArg any]
                        success:[OCMArg any]
                        failure:[OCMArg any]]);
    });
    
    it(@"should pass the path to operation manager's method", ^{
        expect(managerPath).to.equal(path);
    });
    
    it(@"should pass the parameters dictionary to operation manager's method", ^{
        expect(managerParameters).to.equal(parameters);
    });
    
    context(@"when request succeeds", ^{
        before(^{
            if (!managerSuccessBlock) return;
            managerSuccessBlock([AFHTTPRequestOperation new],@"operation");
        });
        
        it(@"should execute the success block", ^{
            expect(successBlockExecuted).to.beTruthy();
        });
    });

});

describe(@"on getFromPath:parameters:success:failure:", ^{
    
    beforeEach(^{
        [networkService getFromPath:path
                         parameters:parameters
                            success:successBlock
                            failure:failureBlock];
    });
    
    it(@"should call operation manager's GET:parameters:success:failure method", ^{
        OCMVerify([manager GET:[OCMArg any]
                    parameters:[OCMArg any]
                       success:[OCMArg any]
                       failure:[OCMArg any]]);
    });
    
    it(@"should pass the path to operation manager's method", ^{
        expect(managerPath).to.equal(path);
    });
    
    it(@"should pass the parameters dictionary to operation manager's method", ^{
        expect(managerParameters).to.equal(parameters);
    });
    
    context(@"when request succeeds", ^{
        before(^{
            if (!managerSuccessBlock) return;
            managerSuccessBlock([AFHTTPRequestOperation new],@"operation");
        });
        
        it(@"should execute the success block", ^{
            expect(successBlockExecuted).to.beTruthy();
        });
    });
    
});


SpecEnd