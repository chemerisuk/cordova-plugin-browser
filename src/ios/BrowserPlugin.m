#import "BrowserPlugin.h"
#import <SafariServices/SafariServices.h>

@implementation BrowserPlugin {
    SFSafariViewController *_safariViewController;
}

- (void)open:(CDVInvokedUrlCommand *)command {
    NSString *urlString = command.arguments[0];
    if (urlString == nil) {
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                    messageAsString:@"url can't be empty"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    } else {
        NSURL *url = [NSURL URLWithString:urlString];
        _safariViewController = [[SFSafariViewController alloc] initWithURL:url];
        [self.viewController presentViewController:_safariViewController animated:YES completion:nil];

        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
}

- (void)close:(CDVInvokedUrlCommand *)command {
    if (_safariViewController) {
        [_safariViewController dismissViewControllerAnimated:YES completion:nil];
        _safariViewController = nil;
    }

    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
