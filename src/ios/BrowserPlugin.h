#import <Cordova/CDV.h>

@interface BrowserPlugin : CDVPlugin

- (void)open:(CDVInvokedUrlCommand*)command;
- (void)close:(CDVInvokedUrlCommand*)command;

@end
