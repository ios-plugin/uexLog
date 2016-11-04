//
//  MySingleton.h
//  DEMO
//
//  Created by cc on 15/11/4.
//  Copyright © 2015年 hexc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UexLogMySingleton : NSObject
@property(nonatomic,strong)NSString * hostAddress;

+(UexLogMySingleton*)shareMySingLeton;

@end
