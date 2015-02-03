//
//  BISLoginServiceFactorySpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISLoginService.h"

SpecBegin(LoginServiceFactory)

describe(@"loginService factory method", ^{
    __block BISLoginService *loginService;
    
    beforeEach(^{
        loginService = [BISLoginService loginService];
    });
    
    it(@"should return instance of BISLoginService", ^{
        expect(loginService).to.beInstanceOf([BISLoginService class]);
    });
});

SpecEnd
