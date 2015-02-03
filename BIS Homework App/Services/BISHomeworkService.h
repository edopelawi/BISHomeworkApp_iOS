//
//  BISHomeworkService.h
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/2/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BISNetworkServiceDependant.h"

typedef void (^BISHomeworkServiceSuccessBlock) (NSArray *homeworks);
typedef void (^BISHomeworkServiceFailureBlock) (NSString *message);

@class BISNetworkService;

@interface BISHomeworkService : NSObject <BISNetworkServiceDependant>

+ (BISHomeworkService *)homeworkService;

- (void)retrieveHomeworksWithSuccess:(BISHomeworkServiceSuccessBlock)successBlock
                             failure:(BISHomeworkServiceFailureBlock)failureBlock;

@end
