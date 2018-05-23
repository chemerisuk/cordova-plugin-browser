#import "BrowserPlugin.h"

@implementation BrowserPlugin {
    SFSafariViewController *_safariViewController;
}

- (void)init:(CDVInvokedUrlCommand *)command {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)open:(CDVInvokedUrlCommand *)command {
    if (_safariViewController) {
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                    messageAsString:@"only single browser is allowed"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        return;
    }

    NSString *urlString = command.arguments[0];
    NSDictionary* options = command.arguments[1];
    if (urlString == nil) {
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                    messageAsString:@"url can't be empty"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    } else {
        NSURL *url = [NSURL URLWithString:urlString];
        id readerMode = options[@"readerMode"];
        id animated = options[@"animated"];
        BOOL readerModeFlag = readerMode ? [readerMode boolValue] : NO;
        BOOL animatedFlag = animated ? [animated boolValue] : NO;

        _safariViewController = [[SFSafariViewController alloc] initWithURL:url entersReaderIfAvailable:readerModeFlag];
        _safariViewController.delegate = self;

        [self.viewController presentViewController:_safariViewController animated:animatedFlag completion:nil];

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

- (void)onLoad:(CDVInvokedUrlCommand *)command {
    self.loadCallbackId = command.callbackId;
}

- (void)onClose:(CDVInvokedUrlCommand *)command {
    self.closeCallbackId = command.callbackId;
}

# pragma mark - SFSafariViewControllerDelegate

- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    if (self.loadCallbackId) {
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:self.loadCallbackId];
    }
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    if (self.closeCallbackId) {
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:self.closeCallbackId];
    }
}

@end
