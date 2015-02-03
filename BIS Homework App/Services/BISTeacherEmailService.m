//
//  BISTeacherEmailService.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/2/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISTeacherEmailService.h"
#import "BISNetworkService.h"
#import "BISURLConstants.h"

@interface BISTeacherEmailService ()

@property (nonatomic, strong) BISNetworkService *networkService;

@end

@implementation BISTeacherEmailService

- (instancetype)initWithNetworkService:(BISNetworkService *)networkService
{
    NSParameterAssert(networkService);
    
    self = [super init];
    
    if (self) {
        _networkService = networkService;
    }
    
    return self;
}

- (void)retrieveTeacherEmailsWithSuccess:(BISTeacherEmailServiceSuccessBlock)successBlock
                                 failure:(BISTeacherEmailServiceFailureBlock)failureBlock
{
    [_networkService getFromPath:BISURLConstantTeacherEmailsPath
                      parameters:@{}
                         success:^(id response) {
                             if (successBlock) successBlock(response);
                         }
                         failure:^(NSError *error) {
                             NSString *message = [NSString stringWithFormat:@"Failed to retrieve teacher emails. Error code :%@",@(error.code)];
                             if (failureBlock) failureBlock(message);
                         }];
}

@end
