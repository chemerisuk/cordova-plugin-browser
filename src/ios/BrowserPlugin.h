#import <Cordova/CDV.h>
#import <SafariServices/SafariServices.h>

@interface BrowserPlugin : CDVPlugin<SFSafariViewControllerDelegate>

- (void)init:(CDVInvokedUrlCommand*)command;
- (void)open:(CDVInvokedUrlCommand*)command;
- (void)close:(CDVInvokedUrlCommand*)command;
- (void)onLoad:(CDVInvokedUrlCommand*)command;
- (void)onClose:(CDVInvokedUrlCommand*)command;

@property (nonatomic, copy) NSString *loadCallbackId;
@property (nonatomic, copy) NSString *closeCallbackId;

@end
