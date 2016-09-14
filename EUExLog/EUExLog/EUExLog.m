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
#define LOG_PORT 30050

@implementation EUExLog

GCDAsyncUdpSocket *sockObj;
//-(id)initWithBrwView:(EBrowserView *) eInBrwView{	
//	if (self = [super initWithBrwView:eInBrwView]) {	
//	}
//	return self;
//}
-(id)initWithWebViewEngine:(id<AppCanWebViewEngineObject>)engine{
    if (self = [super initWithWebViewEngine:engine]) {
        
    }
    return self;
}
-(void)dealloc{
	if(sockObj){
		
		sockObj = nil;
	}
	
}

- (void)clean {
    if (self.webViewEngine) {
        self.webViewEngine = nil;
    }
}

-(void)sendLog:(NSMutableArray *)inArguments{
	//NSString *inLog = [inArguments objectAtIndex:0];
    ACArgsUnpack(NSString *inLog) = inArguments;
    NSString *logServerIp = nil;
    if (self.webViewEngine.widget.logServerIp) {
        logServerIp = self.webViewEngine.widget.logServerIp;
    }else{
        logServerIp = [AppCanMainWidget() logServerIp];
    }
	
    if (!logServerIp) {
        logServerIp = [BUtility getMainWidgetConfigLogserverip];
    }
	if (logServerIp) {
		if (sockObj==nil) {
			sockObj = [[GCDAsyncUdpSocket alloc] init];
		}
        if (sockObj) {
            [sockObj sendData:[inLog dataUsingEncoding:NSUTF8StringEncoding] toHost:logServerIp port:LOG_PORT withTimeout:-1 tag:0];
        }
	}
}
@end
