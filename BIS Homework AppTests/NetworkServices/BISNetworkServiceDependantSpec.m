//
//  BISLoginServiceInitSpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 2/3/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISNetworkService.h"
#import "BISNetworkServiceDependant.h"
#import "BISSharedExampleConstants.h"

SharedExamplesBegin(NetworkServiceDependant)

sharedExamples(BISSharedExampleNetworkServiceDependant, ^(NSDictionary *data) {
   
    __block Class dependantClass = data[BISSharedExampleClassKey];
    __block id dependant;
    
    describe(@"on initWithNetworkService:", ^{
        it(@"should raise exception if nil passed as parameter", ^{
            expect(^{
                dependant = [[dependantClass alloc] initWithNetworkService:nil];
            }).to.raise(NSInternalInconsistencyException);
        });
        
        it(@"should return the instance of corresponding class", ^{
            dependant = [[dependantClass alloc] initWithNetworkService:[BISNetworkService new]];
            expect(dependant).to.beInstanceOf(dependantClass);
        });
    });
});

SharedExamplesEnd
