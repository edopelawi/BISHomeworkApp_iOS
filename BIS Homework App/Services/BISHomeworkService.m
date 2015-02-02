//
//  BISHomeworkService.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/2/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISHomeworkService.h"
#import "BISNetworkService.h"
#import "BISURLConstants.h"

@interface BISHomeworkService ()

@property (nonatomic, strong) BISNetworkService *networkService;

@end

@implementation BISHomeworkService

- (instancetype)initWithNetworkService:(BISNetworkService *)networkService
{
    self = [super init];
    
    if (self) {
        _networkService = networkService;
    }
    
    return self;
}

- (void)retrieveHomeworksWithSuccess:(BISHomeworkServiceSuccessBlock)successBlock
                             failure:(BISHomeworkServiceFailureBlock)failureBlock
{
    [_networkService getFromPath:BISURLConstantHomeworkPath
                      parameters:@{}
                         success:^(id response) {
                             if (successBlock) successBlock(response);
                         }
                         failure:^(NSError *error) {
                             NSString *message = [NSString stringWithFormat:@"Failed to retrieve homeworks. Error code :%@",@(error.code)];
                             if (failureBlock) failureBlock(message);
                         }];
}

@end
