//
//  BISLoginViewController.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 1/30/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISLoginViewController.h"
#import "BISLoginView.h"

@interface BISLoginViewController ()

@property (strong, nonatomic) BISLoginView *mainView;

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
}

@end
