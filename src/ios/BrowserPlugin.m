#import "BrowserPlugin.h"

@implementation BrowserPlugin {
    SFSafariViewController *_safariViewController;
}

- (void)handleOpenURLWithApplicationSourceAndAnnotation:(NSNotification*)notification {
    NSDictionary*  notificationData = [notification object];

    if ([notificationData isKindOfClass: NSDictionary.class]) {
        NSURL* url = notificationData[@"url"];
        NSString* sourceApplication = notificationData[@"sourceApplication"];

        if ([url isKindOfClass:NSURL.class] && [sourceApplication isKindOfClass:NSString.class]) {
            if ([sourceApplication isEqual:@"com.apple.SafariViewService"]) {
                if (_safariViewController) {
                    [_safariViewController dismissViewControllerAnimated:NO completion:nil];
                    [self safariViewControllerDidFinish:_safariViewController];
                }
            }
        }
    }
}

- (void)ready:(CDVInvokedUrlCommand *)command {
    CDVPluginResult *result;
    if ([SFSafariViewController class]) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                   messageAsString:@"SFSafariViewController is not available"];
    }
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
        BOOL readerModeFlag = readerMode ? [readerMode boolValue] : NO;

        _safariViewController = [[SFSafariViewController alloc] initWithURL:url entersReaderIfAvailable:readerModeFlag];
        _safariViewController.delegate = self;

        [self.viewController presentViewController:_safariViewController animated:YES completion:nil];

        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
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
    _safariViewController = nil;

    if (self.closeCallbackId) {
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:self.closeCallbackId];
    }
}

@end
