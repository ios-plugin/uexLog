//
//  EUExLog.m
//  AppCan
//
//  Created by AppCan on 11-11-8.
//  Copyright 2011 AppCan. All rights reserved.
//

#import "EUExLog.h"
#import "EUtility.h"

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

-(void)sendLog:(NSMutableArray *)inArguments{
	NSString *inLog = [inArguments objectAtIndex:0];
	NSString *logServerIp = [EUtility LogServerIp:meBrwView];
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
