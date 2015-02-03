//
//  BISNetworkManagerFactorySpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISNetworkManagerFactory.h"
#import "BISURLConstants.h"

#import <AFNetworking.h>

SpecBegin(NetworkManagerFactory)

describe(@"on building AFHTTPRequestOperationManager", ^{
    
    __block AFHTTPRequestOperationManager *operationManager;
    
    beforeEach(^{
        operationManager = [BISNetworkManagerFactory AFHTTPRequestOperationManagerForBISServer];
    });
    
    it(@"should return object of AFHTTPRequestOperationManager class ", ^{
        expect(operationManager.class).to.equal(AFHTTPRequestOperationManager.class);
    });
    
    it(@"should set BIS server address as base URL", ^{
        NSURL *baseURL = [NSURL URLWithString:BISURLConstantBase];
        expect(operationManager.baseURL).to.equal(baseURL);
    });
    
    it(@"should AFHTTPRequestSerializer as request serializer", ^{
        Class requestSerializerClass = operationManager.requestSerializer.class;
        expect(requestSerializerClass).to.equal([AFHTTPRequestSerializer class]);
    });
    
    it(@"should AFXMLParserResponseSerializer as response serializer", ^{
        Class responseSerializerClass = operationManager.responseSerializer.class;
        expect(responseSerializerClass).to.equal([AFXMLParserResponseSerializer class]);
    });
    
    it(@"should have text/xml as acceptable content type", ^{
        NSSet *acceptableContentTypes = operationManager.responseSerializer.acceptableContentTypes;
        
        expect(acceptableContentTypes).to.contain(@"text/xml");
    });
    
});

SpecEnd
