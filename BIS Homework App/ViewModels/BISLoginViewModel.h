//
//  BISLoginViewModel.h
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BISLoginView;
@class BISLoginService;

@interface BISLoginViewModel : NSObject

- (instancetype)initWithLoginView:(BISLoginView*)loginView
                     loginService:(BISLoginService *)loginService;

- (void)setLoginSuccessHandler:(void(^)())block;
- (void)setLoginFailureHandler:(void(^)(NSString *message))block;

@end
