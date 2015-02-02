//
//  BISHomeworkServiceSpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/2/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISNetworkService.h"
#import "BISHomeworkService.h"
#import "BISURLConstants.h"

SpecBegin(HomeworkService)

__block BISHomeworkService *homeworkService;
__block id networkService;

__block BISHomeworkServiceSuccessBlock successBlock;
__block BISHomeworkServiceFailureBlock failureBlock;
__block BOOL successBlockExecuted;
__block BOOL failureBlockExecuted;

__block NSString *networkPath;
__block NSDictionary *networkParameters;
__block BISNetworkServiceSuccessBlock networkSuccessBlock;
__block BISNetworkServiceFailureBlock networkFailureBlock;

beforeEach(^{
    id operationManager = OCMPartialMock([AFHTTPRequestOperationManager new]);
    networkService = OCMPartialMock([[BISNetworkService alloc] initWithRequestOperationManager:operationManager]);
    
    homeworkService = [[BISHomeworkService alloc] initWithNetworkService:networkService];
    
    successBlock = ^(NSArray *homeworks){
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

describe(@"on retrieving list of homework", ^{
    
    beforeEach(^{
        [homeworkService retrieveHomeworksWithSuccess:successBlock
                                              failure:failureBlock];
    });
    
    it(@"should call networkService's get method", ^{
        OCMVerify([networkService getFromPath:[OCMArg any]
                                   parameters:[OCMArg any]
                                      success:[OCMArg any]
                                      failure:[OCMArg any]]);
    });
    
    it(@"should pass homework path to network service", ^{
        expect(networkPath).to.equal(BISURLConstantHomeworkPath);
    });
    
    it(@"should pass an empty dictionary as parameter to network service", ^{
        expect(networkParameters).to.equal(@{});
    });
    
    context(@"when request succeed", ^{
        before(^{
            if (!networkSuccessBlock) return;
            networkSuccessBlock([AFHTTPRequestOperation new],@"response");
        });
        
        it(@"should execute the passed success block", ^{
            expect(successBlockExecuted).to.beTruthy();
        });
    });
    
    context(@"when request failed", ^{
        before(^{
            if (!networkFailureBlock) return;
            NSError *error = [NSError errorWithDomain:@"dummy" code:404 userInfo:@{}];
            networkFailureBlock([AFHTTPRequestOperation new],error);
        });
        
        it(@"should execute the passed failure block", ^{
            expect(failureBlockExecuted).to.beTruthy();
        });
    });
    
});

SpecEnd
