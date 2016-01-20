#import "interfaces.h"

%hook SBApplication

- (NSArray*)dynamicShortcutItems
{
    if([self.bundleIdentifier isEqualToString:@"com.apple.calculator"]) {
        NSDictionary *info = @{@"UIApplicationShortcutItemTitle": @"COPY_LAST_RESULT",
                               @"UIApplicationShortcutItemType": @"com.mootjeuh.calculator.shortcut.copyLastResult"};
        
        NSBundle *localizationsBundle = [NSBundle bundleWithPath:@"/Library/Application Support/CopyCalculator/Localizations.bundle"];
        
        NSString *(^block)(NSString*, NSString*) = ^(NSString *key, NSString *backup) {            
            return NSLocalizedStringFromTableInBundle(key, nil, localizationsBundle, nil);
        };
        
        SBSApplicationShortcutItem *item = [%c(SBSApplicationShortcutItem) staticShortcutItemWithDictionary:info localizationHandler:block];
        item.activationMode = SBSApplicationShortcutActivateBackground;
        
        return @[item];
    } else {
        return %orig;
    }
}

%end

%hook SBApplicationShortcutMenuItemView

- (id)initWithShortcutItem:(SBSApplicationShortcutItem*)item menuPosition:(int)arg2 orientation:(int)arg3 application:(id)arg4 assetManagerProvider:(id)arg5 monogrammerProvider:(id)arg6 options:(unsigned)arg7
{
	if([item.type isEqualToString:@"com.mootjeuh.calculator.shortcut.copyLastResult"]) {
		return %orig(item, arg2, arg3, arg4, arg5, arg6, 0);
	} else {
		return %orig;
	}
}

///Icon courtesy of Icons8.com
- (void)_setupViewsWithIcon:(UIImage*)icon title:(NSString*)title subtitle:(NSString*)subtitle
{
    if([self.shortcutItem.type isEqualToString:@"com.mootjeuh.calculator.shortcut.copyLastResult"]) {
        UIImage *image = [%c(UIImage) imageNamed:@"/Library/Application Support/CopyCalculator/Resources.bundle/Copy Filled"];
        %orig(image, title, subtitle);
    } else {
        %orig;
    }
}

%end
