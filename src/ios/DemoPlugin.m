/********* DemoPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <LinkKit/LinkKit.h>
//#import "DemoPlugin.h"

@interface DemoPlugin : CDVPlugin {
  // Member variables go here.

}
@property (readwrite) id<PLKHandler> linkHandler;
- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end

@implementation DemoPlugin

@synthesize linkHandler = _linkHandler;

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

//    if (echo != nil && [echo length] > 0) {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
//    } else {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//    }

//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    
    NSString* token = [command.arguments objectAtIndex:0];
    
    PLKLinkTokenConfiguration* linkConfiguration = [PLKLinkTokenConfiguration createWithToken:token
                                                                                    onSuccess:^(PLKLinkSuccess *success) {
        NSLog(@"public-token: %@ metadata: %@", success.publicToken, success.metadata);
    }];
    linkConfiguration.onExit = ^(PLKLinkExit * exit) {
        if (exit.error) {
            NSLog(@"exit with %@\n%@", exit.error, exit.metadata);
//            self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            NSLog(@"exit with %@", exit.metadata);
//            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    };
    NSLog(@"mayank");
    NSError *createError = nil;
    
//    dispatch_async(dispatch_get_main_queue(), ^{
        id<PLKHandler> handler = [PLKPlaid createWithLinkTokenConfiguration:linkConfiguration
                                                                      error:&createError];
        if (handler) {
            self.linkHandler = handler;
            [handler openWithContextViewController:[self topMostController]];
//            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
//            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else if (createError) {
            NSLog(@"Unable to create PLKHandler due to: %@", createError);
//            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        
//    }
}

- (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;

    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

    return topController;
}

@end
