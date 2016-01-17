#import "interfaces.h"

%hook SBApplication

///TODO: iOS 9.0.2 currently doesn't handle long titles very well,
/// so if a localization should require to be on multiple lines it all gets messed up.
/// Try to find a way to fix this.
- (NSArray*)dynamicShortcutItems
{
    if([self.bundleIdentifier isEqualToString:@"com.apple.calculator"]) {
        NSDictionary *info = @{@"UIApplicationShortcutItemTitle": @"Copy Last Result",
                               @"UIApplicationShortcutItemType": @"com.mootjeuh.calculator.shortcut.copyLastResult"};
        
        SBSApplicationShortcutItem *item = [%c(SBSApplicationShortcutItem) staticShortcutItemWithDictionary:info localizationHandler:nil];
        item.activationMode = SBSApplicationShortcutActivateBackground;
        
        return @[item];
    } else {
        return %orig;
    }
}

%end

%hook SBApplicationShortcutMenuItemView

///Icon courtesy of Icons8.com
- (id)initWithShortcutItem:(SBSApplicationShortcutItem*)item menuPosition:(int)arg2 orientation:(int)arg3 application:(id)arg4 assetManagerProvider:(id)arg5 monogrammerProvider:(id)arg6 options:(unsigned)arg7
{
	if([item.type isEqualToString:@"com.mootjeuh.calculator.shortcut.copyLastResult"]) {
		SBApplicationShortcutMenuItemView *view = %orig(item, arg2, arg3, arg4, arg5, arg6, 0);
		UIImage *image = [%c(UIImage) imageNamed:@"/Library/Application Support/CopyCalculator/Resources.bundle/Copy Filled"];
		
		view.iconView = [[%c(UIImageView) alloc] initWithImage:image];
		
		[view _setupViewsWithIcon:image title:item.localizedTitle subtitle:item.localizedSubtitle];
		
		return view;
	} else {
		return %orig;
	}
}

%end