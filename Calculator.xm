#import "interfaces.h"

%hook _TtC10Calculator11AppDelegate

%new
- (void)application:(UIApplication*)application performActionForShortcutItem:(UIApplicationShortcutItem*)shortcutItem completionHandler:(void (^)(BOOL succeeded))completionHandler
{
    if([shortcutItem.type isEqualToString:@"com.mootjeuh.calculator.shortcut.copyLastResult"]) {
        [%c(UIPasteboard) generalPasteboard].string = self.controller.model.displayValue;
    }
    
    completionHandler(YES);
}

%end