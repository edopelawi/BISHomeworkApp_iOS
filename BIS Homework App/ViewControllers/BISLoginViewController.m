//
//  BISLoginViewController.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 1/30/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISLoginViewController.h"
#import "BISLoginView.h"
#import "BISLoginViewModel.h"
#import "BISLoginService.h"

#import <SVProgressHUD.h>

@interface BISLoginViewController ()

@property (strong, nonatomic) BISLoginView *mainView;
@property (strong, nonatomic) BISLoginViewModel *viewModel;

@end

@implementation BISLoginViewController

- (void)loadView
{
    _mainView = [BISLoginView new];
    [self setView:_mainView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareViewModel];
}

- (void)prepareViewModel
{
    _viewModel = [[BISLoginViewModel alloc] initWithLoginView:_mainView
                                                 loginService:[BISLoginService loginService]];
    __weak __typeof(self) weakSelf = self;
    
    [_viewModel setWillLoginHandler:^{
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    }];
    
    [_viewModel setLoginSuccessHandler:^{
        [SVProgressHUD dismiss];
        [weakSelf navigateToMainMenu];
    }];
    
    [_viewModel setLoginFailureHandler:^(NSString *message) {
        [SVProgressHUD dismiss];
        [weakSelf showAlertWithMessage:message];
    }];
}

- (void)navigateToMainMenu
{
    // TODO : push main menu view controller here.
    NSLog(@"[^^^] Navigate to main menu!");
}

- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login failed"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}


@end
