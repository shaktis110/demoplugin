/********* DemoPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <UIKit/UIKit.h>
#import <LinkKit/LinkKit.h>

@protocol LinkOAuthHandling
@property (readonly) id<PLKHandler> linkHandler;
@end

@interface DemoPlugin : CDVPlugin<LinkOAuthHandling>

@property (readwrite) id<PLKHandler> linkHandler;

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end
