//
//  MySingleton.m
//  DEMO
//
//  Created by cc on 15/11/4.
//  Copyright © 2015年 hexc. All rights reserved.
//

#import "UexLogMySingleton.h"

@implementation UexLogMySingleton

@synthesize hostAddress ;

+ (UexLogMySingleton *)shareMySingLeton
{
    static UexLogMySingleton *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
        
        
    });
    return sharedAccountManagerInstance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
      
    }
    
    return self;
    
}

@end
