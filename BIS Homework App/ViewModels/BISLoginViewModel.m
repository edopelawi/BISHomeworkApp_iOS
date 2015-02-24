//
//  BISLoginViewModel.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISLoginViewModel.h"
#import "BISLoginView.h"
#import "BISLoginService.h"
#import "BISLoginParameter.h"

@interface BISLoginViewModel ()

@property (strong, nonatomic) BISLoginView *loginView;
@property (strong, nonatomic) BISLoginService *loginService;

@property (strong, nonatomic) void (^willLoginHandler)();
@property (strong, nonatomic) void (^loginSuccessHandler)();
@property (strong, nonatomic) void (^loginFailureHandler)(NSString *message);

@end


@implementation BISLoginViewModel

- (instancetype)initWithLoginView:(BISLoginView*)loginView
                     loginService:(BISLoginService *)loginService
{
    NSParameterAssert(loginView);
    NSParameterAssert(loginService);
    
    self = [super init];
    
    if (self) {
        _loginView = loginView;
        _loginService = loginService;
        [self prepareLoginViewHandler];
    }
    
    return self;
}

- (void)prepareLoginViewHandler
{
    __weak __typeof(self) weakSelf = self;
    
    [_loginView setLoginButtonTappedHandler:^(NSString *username, NSString *password) {
        
        if (weakSelf.willLoginHandler) weakSelf.willLoginHandler();
        
        BISLoginParameter *parameter = [BISLoginParameter new];
        parameter.username = username;
        parameter.password = password;
        
        [weakSelf loginWithParameter:parameter];
    }];
}

- (void)loginWithParameter:(BISLoginParameter *)parameter
{
    NSDictionary *parameterDictionary = [MTLJSONAdapter JSONDictionaryFromModel:parameter];
    
    __weak __typeof(self) weakSelf = self;
    [_loginService loginWithParameters:parameterDictionary
                               success:^{
                                   if (weakSelf.loginSuccessHandler) weakSelf.loginSuccessHandler();
                               }
                               failure:^(NSString *errorMessage) {
                                   if (weakSelf.loginFailureHandler) weakSelf.loginFailureHandler(errorMessage);
                               }];
}

@end
