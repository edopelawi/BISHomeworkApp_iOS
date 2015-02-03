//
//  BISLoginServiceInitSpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISLoginService.h"
#import "BISNetworkService.h"

SpecBegin(LoginServiceInitialization)

__block BISLoginService *loginService;

it(@"should raise NSInternalInconsistencyException if initialized using init: method", ^{
    expect(^{
        loginService = [BISLoginService new];
    }).to.raise(NSInternalInconsistencyException);
});

describe(@"on initWithRequestOperationManager:", ^{
    it(@"should raise exception if nil passed as parameter", ^{
        expect(^{
            loginService = [[BISLoginService alloc] initWithNetworkService:nil];
        }).to.raise(NSInternalInconsistencyException);
    });
    
    it(@"should return BISloginService object", ^{
        loginService = [[BISLoginService alloc] initWithNetworkService:[BISNetworkService networkService]];
        expect(loginService).to.beInstanceOf(BISLoginService.class);
    });
});

SpecEnd
