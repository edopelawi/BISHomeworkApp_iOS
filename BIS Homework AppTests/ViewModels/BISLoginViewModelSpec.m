//
//  BISLoginViewModelSpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISLoginViewModel.h"
#import "BISLoginView.h"
#import "BISLoginService.h"
#import "BISLoginParameter.h"

SpecBegin(LoginViewModel)

__block BISLoginViewModel *loginViewModel;
__block id loginView;
__block id loginService;

__block BISLoginViewLoginButtonTappedHandler loginViewButtonTappedBlock;
__block NSDictionary *loginServiceParameter;
__block BISLoginServiceSuccessBlock loginServiceSuccessBlock;
__block BISLoginServiceFailureBlock loginServiceFailureBlock;

beforeEach(^{
    loginView = OCMPartialMock([BISLoginView new]);
    loginService = OCMPartialMock([BISLoginService new]);
    
    OCMStub([loginService loginWithParameters:[OCMArg any]
                                      success:[OCMArg any]
                                      failure:[OCMArg any]]).andDo(^(NSInvocation *invocation){
        [invocation retainArguments];
        [invocation getArgument:&loginServiceParameter atIndex:2];
        [invocation getArgument:&loginServiceSuccessBlock atIndex:3];
        [invocation getArgument:&loginServiceFailureBlock atIndex:4];
    });
    
    OCMStub([loginView setLoginButtonTappedHandler:[OCMArg any]]).andDo(^(NSInvocation *invocation){
        [invocation retainArguments];
        [invocation getArgument:&loginViewButtonTappedBlock atIndex:2];
    });
    
    loginViewModel = [[BISLoginViewModel alloc] initWithLoginView:loginView
                                                     loginService:loginService];
    
});

describe(@"on initialization", ^{
    
    it(@"should raise exception if passed login view was nil", ^{
        expect(^{
            loginViewModel = [[BISLoginViewModel alloc] initWithLoginView:nil
                                                             loginService:loginService];
        }).to.raise(NSInternalInconsistencyException);
    });
    
    it(@"should raise exception if passed login service was nil", ^{
        expect(^{
            loginViewModel = [[BISLoginViewModel alloc] initWithLoginView:loginView
                                                             loginService:nil];
        }).to.raise(NSInternalInconsistencyException);
    });
    
    it(@"should raise exception if both login view and login service was nil", ^{
        expect(^{
            loginViewModel = [[BISLoginViewModel alloc] initWithLoginView:nil
                                                             loginService:nil];
        }).to.raise(NSInternalInconsistencyException);
    });
    
    it(@"should return instance of BISLoginViewModel", ^{
        expect(loginViewModel).to.beInstanceOf([BISLoginViewModel class]);
    });
    
    it(@"should set loginView's button tapped handler", ^{
        OCMVerify([loginView setLoginButtonTappedHandler:[OCMArg any]]);
    });
});

describe(@"on login button tapped", ^{
    

    __block BISLoginParameter *parameter;
    
    __block NSString *username;
    __block NSString *password;
    
    __block BISLoginParameter *passedParameter;
    
    beforeEach(^{
        
        username = @"username";
        password = @"password";
        
        parameter = [BISLoginParameter new];
        
        parameter.username = username;
        parameter.password = password;
        
        if (loginViewButtonTappedBlock) loginViewButtonTappedBlock(username, password);
    });
    
    it(@"should call login service's method", ^{
        OCMVerify([loginService loginWithParameters:[OCMArg any]
                                            success:[OCMArg any]
                                            failure:[OCMArg any]]);
    });
    
    it(@"should pass the corresponding login parameter", ^{
        
        passedParameter = [MTLJSONAdapter modelOfClass:[BISLoginParameter class]
                                    fromJSONDictionary:loginServiceParameter
                                                 error:nil];
    
        expect(passedParameter).to.equal(parameter);
    });
    
});

describe(@"on login request", ^{
    
    __block BOOL successBlockExecuted = NO;
    __block BOOL failureBlockExecuted = NO;
    __block NSString *errorMessage;
    
    __block void (^successBlock)() = ^{
        successBlockExecuted = YES;
    };
    
    __block void (^failureBlock)(NSString *message) = ^(NSString* message){
        failureBlockExecuted = YES;
        errorMessage = message;
    };
    
    beforeEach(^{
        
        successBlockExecuted = NO;
        failureBlockExecuted = NO;
        errorMessage = nil;
        
        [loginViewModel setLoginSuccessHandler:successBlock];
        [loginViewModel setLoginFailureHandler:failureBlock];
        
        if (loginViewButtonTappedBlock) loginViewButtonTappedBlock(@"username",@"password");
    });
    
    context(@"succeeds", ^{
        before(^{
            loginServiceSuccessBlock();
        });
        
        it(@"should execute the passed success block", ^{
            expect(successBlockExecuted).to.beTruthy();
        });
    });
    
    context(@"fails", ^{
        before(^{
            loginServiceFailureBlock(@"message");
        });
        
        it(@"should execute the passed failure block", ^{
            expect(failureBlockExecuted).to.beTruthy();
        });
        
        it(@"should pass the error message to the failure block", ^{
            expect(errorMessage).to.equal(@"message");
        });
    });
});

SpecEnd