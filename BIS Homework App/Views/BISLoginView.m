//
//  BISLoginView.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISLoginView.h"

#import <QuartzCore/QuartzCore.h>

@interface BISLoginView ()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;

@property (strong, nonatomic) IBOutlet UITextField *userNameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) BISLoginViewLoginButtonTappedHandler loginButtonTappedHandler;

@end

@implementation BISLoginView

- (instancetype)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)
                                          owner:self
                                        options:nil] firstObject];
    
    return self;
}

- (void)awakeFromNib
{
    [self setContentViewSize];
    [self setColors];
    [self setFonts];
    [self setBorders];
}

#pragma mark - Layouts -

- (void)setContentViewSize
{
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    _contentViewWidthConstraint.constant = CGRectGetWidth(screenBounds);
}

- (void)setColors
{
    _userNameField.backgroundColor = [UIColor clearColor];
    _passwordField.backgroundColor = [UIColor clearColor];
    
    _userNameField.textColor = [UIColor whiteColor];
    _passwordField.textColor = [UIColor whiteColor];
}

- (void)setFonts
{
    NSDictionary *attribute = @{
                                NSForegroundColorAttributeName : [UIColor whiteColor]
                                };
    
    NSAttributedString *usernamePlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:attribute];
    NSAttributedString *passwordPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:attribute];
    
    [_userNameField setAttributedPlaceholder:usernamePlaceholder];
    [_passwordField setAttributedPlaceholder:passwordPlaceholder];
}

- (void)setBorders
{
    _loginButton.layer.cornerRadius = 6;
}

#pragma mark - Action handlers -

- (IBAction)loginButtonTapped:(id)sender
{
    if (_loginButtonTappedHandler) _loginButtonTappedHandler(_userNameField.text, _passwordField.text);
}


@end
