//
//  EUExLog.m
//  AppCan
//
//  Created by AppCan on 11-11-8.
//  Copyright 2011 AppCan. All rights reserved.
//

#import "EUExLog.h"
#import "EUtility.h"
#import "BUtility.h"
#import "JSON.h"

#import "WWidget.h"
#import "EBrowserView.h"
#import "UexLogMySingleton.h"

#define LOG_PORT 30050

@implementation EUExLog

GCDAsyncUdpSocket *sockObj;

-(id)initWithBrwView:(EBrowserView *) eInBrwView{	
	if (self = [super initWithBrwView:eInBrwView]) {	
	}
	return self;
}

-(void)dealloc{
    
	if(sockObj){
        
		[sockObj release];
        
		sockObj = nil;
	}
    
	[super dealloc];
    
}

- (void)clean {
    
    if (meBrwView) {
        
        meBrwView = nil;
    }
}

-(void)sendLog:(NSMutableArray *)inArguments{
    
    UexLogMySingleton * UexLog = [UexLogMySingleton shareMySingLeton];
    
	NSString *inLog = [inArguments objectAtIndex:0];
    
	NSString *logServerIp = [EUtility LogServerIp:meBrwView];
    
    if (!logServerIp) {
        
        logServerIp = [BUtility getMainWidgetConfigLogserverip];
    }
    
    if (UexLog.hostAddress) {
        
        NSLog(@"setHost地址：+++%@",UexLog.hostAddress);
        [sockObj sendData:[inLog dataUsingEncoding:NSUTF8StringEncoding] toHost:self.hostAddress port:LOG_PORT withTimeout:-1 tag:0];
        
    } else if (logServerIp) {
        
		if (sockObj==nil) {
            
			sockObj = [[GCDAsyncUdpSocket alloc] init];
		}
        
        if (sockObj) {
            
            [sockObj sendData:[inLog dataUsingEncoding:NSUTF8StringEncoding] toHost:logServerIp port:LOG_PORT withTimeout:-1 tag:0];
            NSLog(@"++++++++%@",logServerIp);
        }
    
    }
}

-(void)setHost:(NSMutableArray*)array{
    
    UexLogMySingleton * UexLog = [UexLogMySingleton shareMySingLeton];

    NSString * hostString = [array objectAtIndex:0];
    
    NSDictionary * hostDict = [hostString JSONValue];
    
    WWidget *inCurWgt = self.meBrwView.mwWgt;
    
    if ([[hostDict objectForKey:@"appdebug"] isEqualToString:@"1"]) {
        
        inCurWgt.isDebug = YES;
        
    } else {
        
        inCurWgt.isDebug = NO;
    }
    
    UexLog.hostAddress = [hostDict objectForKey:@"logserverip"];
    
    NSUserDefaults * logUserDefaults = [NSUserDefaults standardUserDefaults];
    
    [logUserDefaults setObject: UexLog.hostAddress forKey:@"logserverip"];

}

-(void)getHost:(NSMutableArray*)array{
    
    NSUserDefaults * logUserDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString * getHostStr = [logUserDefaults objectForKey:@"logserverip"];
    
    NSString *jsStr = [NSString stringWithFormat:@"if(uexLog.cbGetHost!=null){uexLog.cbGetHost('%@');}", getHostStr];
    
    [self.meBrwView stringByEvaluatingJavaScriptFromString:jsStr];
    
}






@end
