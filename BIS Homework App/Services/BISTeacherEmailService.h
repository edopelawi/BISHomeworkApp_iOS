//
//  BISTeacherEmailService.h
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/2/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BISTeacherEmailServiceSuccessBlock) (NSArray *emails);
typedef void (^BISTeacherEmailServiceFailureBlock) (NSString *message);

@class BISNetworkService;

@interface BISTeacherEmailService : NSObject

- (instancetype)initWithNetworkService:(BISNetworkService *)networkService;

- (void)retrieveTeacherEmailsWithSuccess:(BISTeacherEmailServiceSuccessBlock)successBlock
                                 failure:(BISTeacherEmailServiceFailureBlock)failureBlock;

@end
