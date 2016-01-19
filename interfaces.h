//
//  interfaces.h
//  
//
//  Created by Mohamed Marbouh on 2016-01-17.
//
//

#ifndef interfaces_h
#define interfaces_h

#import <UIKit/UIKit.h>

@interface SBApplication : NSObject

- (NSString*)bundleIdentifier;

@end

typedef enum : NSUInteger {
	SBSApplicationShortcutActivateForeground,
	SBSApplicationShortcutActivateBackground,
} SBSApplicationShortcutActivation;

@interface SBSApplicationShortcutItem : NSObject

@property(nonatomic) SBSApplicationShortcutActivation activationMode;
@property(nonatomic, copy) NSString *type;

+ (instancetype)staticShortcutItemWithDictionary:(NSDictionary*)arg1 localizationHandler:(NSString* (^)(NSString*, NSString*))arg2;

@end

@interface SBApplicationShortcutMenuItemView : UIView

@property(retain, nonatomic) SBSApplicationShortcutItem *shortcutItem;

@end

///Calculator.CalculatorModel
@interface _TtC10Calculator15CalculatorModel : NSObject

- (NSString*)displayValue;

@end

///Calculator.CalculatorController
@interface _TtC10Calculator20CalculatorController : UIViewController

- (_TtC10Calculator15CalculatorModel*)model;

@end

///Calculator.AppDelegate
@interface _TtC10Calculator11AppDelegate : UIResponder

- (_TtC10Calculator20CalculatorController*)controller;

@end

#endif /* interfaces_h */
