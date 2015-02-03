//
//  BISLoginView.h
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BISLoginViewLoginButtonTappedHandler) (NSString *username, NSString *password);

@interface BISLoginView : UIView

- (void)setLoginButtonTappedHandler:(BISLoginViewLoginButtonTappedHandler)block;

@end
