//
//  BISLoginParameterSpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISLoginParameterSpec.h"
#import "BISLoginParameter.h"
#import <Mantle.h>

SpecBegin(LoginParameter)

__block BISLoginParameter *loginParameter;

beforeEach(^{
    loginParameter = [BISLoginParameter new];
});

describe(@"its username property", ^{
    __block NSObject *username;
    
    beforeEach(^{
        username = [loginParameter username];
    });
    
    it(@"should not be nil", ^{
        expect(username).toNot.beNil();
    });
    
    it(@"should be a NSString", ^{
        expect([username isKindOfClass:[NSString class]]).to.beTruthy();
    });
});

describe(@"its password property", ^{
    __block NSObject *password;
    
    beforeEach(^{
        password = [loginParameter password];
    });
    
    it(@"should not be nil", ^{
        expect(password).toNot.beNil();
    });
    
    it(@"should be a NSString", ^{
        expect([password isKindOfClass:[NSString class]]).to.beTruthy();
    });
});

describe(@"its Mantle model dictionary result", ^{
    __block NSDictionary *result;
    __block NSString *username;
    __block NSString *usernameKey;
    __block NSString *password;
    __block NSString *passwordKey;
    
    beforeEach(^{
        username = @"username";
        usernameKey = @"name";
        password = @"password";
        passwordKey = @"pass";
        
        loginParameter.username = username;
        loginParameter.password = password;
        
        result = [MTLJSONAdapter JSONDictionaryFromModel:loginParameter];
    });
    
    it(@"should store the username on the corresponding key", ^{
        NSString *extractedUsername = result[usernameKey];
        expect(extractedUsername).to.equal(username);
    });
    
    it(@"should store the password on the corresponding key", ^{
        NSString *extractedPassword = result[passwordKey];
        expect(extractedPassword).to.equal(password);
    });
    
});

SpecEnd
