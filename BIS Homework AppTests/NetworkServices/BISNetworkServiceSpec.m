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
__block NSError *failureResponse;

__block NSString *managerPath;
__block NSDictionary *managerParameters;
__block void (^managerSuccessBlock) (AFHTTPRequestOperation *operation, id responseObject);
__block void (^managerFailureBlock) (AFHTTPRequestOperation *operation, NSError *error);

beforeEach(^{
    manager = OCMPartialMock([AFHTTPRequestOperationManager new]);
    
    networkService = [[BISNetworkService alloc] initWithRequestOperationManager:manager];
    
    path = @"/dummy";
    parameters = @{@"param" : @"hello"};
    
    successBlock = ^(id response){
        successBlockExecuted = YES;
    };
    
    failureBlock = ^(NSError *error){
        failureBlockExecuted = YES;
        failureResponse = error;
    };
    
    successBlockExecuted = NO;
    failureBlockExecuted = NO;
    failureResponse = nil;
    
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
    
    OCMStub([manager GET:[OCMArg any]
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
    
    context(@"when request fails", ^{
        
        __block AFHTTPRequestOperation *operation;
        __block NSHTTPURLResponse *response;
        __block NSInteger statusCode;
       
        __block NSError *error;
        
        before(^{
           if (!managerFailureBlock) return;
           
           operation = OCMPartialMock([AFHTTPRequestOperation new]);
           response = OCMPartialMock([NSHTTPURLResponse new]);
           statusCode = 404;
           error = [[NSError alloc] initWithDomain:@"errorDomain"
                                              code:-1001
                                          userInfo:@{}];
            
           OCMStub(operation.response).andReturn(response);
           OCMStub(response.statusCode).andReturn(statusCode);
           
           managerFailureBlock(operation, error);
       });
        
       it(@"should execute the failure block", ^{
           expect(failureBlockExecuted).to.beTruthy();
       });
        
       it(@"should pass error's domain to the failure response's domain", ^{
           expect(failureResponse.domain).to.equal(error.domain);
       });
        
       it(@"should pass AFHTTPRequestOperation's response status code to the failure response's code", ^{
           expect(failureResponse.code).to.equal(statusCode);
       });        
        
       it(@"should pass error's userInfo to the failure response's userInfo", ^{
           expect(failureResponse.userInfo).to.equal(error.userInfo);
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
   
    context(@"when request fails", ^{
        
        __block AFHTTPRequestOperation *operation;
        __block NSHTTPURLResponse *response;
        __block NSInteger statusCode;
        
        __block NSError *error;
        
        before(^{
            if (!managerFailureBlock) return;
            
            operation = OCMPartialMock([AFHTTPRequestOperation new]);
            response = OCMPartialMock([NSHTTPURLResponse new]);
            statusCode = 404;
            error = [[NSError alloc] initWithDomain:@"errorDomain"
                                               code:-1001
                                           userInfo:@{}];
            
            OCMStub(operation.response).andReturn(response);
            OCMStub(response.statusCode).andReturn(statusCode);
            
            managerFailureBlock(operation, error);
        });
        
        it(@"should pass error's domain to the failure response's domain", ^{
            expect(failureResponse.domain).to.equal(error.domain);
        });
        
        it(@"should pass AFHTTPRequestOperation's response status code to the failure response's code", ^{
            expect(failureResponse.code).to.equal(statusCode);
        });
        
        it(@"should pass error's userInfo to the failure response's userInfo", ^{
            expect(failureResponse.userInfo).to.equal(error.userInfo);
        });
    });
    
});


SpecEnd