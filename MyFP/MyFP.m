//
//  MyFP.m
//  MyFP
//
//  Created by 刘建扬 on 15/5/7.
//  Copyright (c) 2015年 刘建扬. All rights reserved.
//

#import "MyFP.h"
#import <Availability.h>
#import "JTTKeyboardEventSender.h"
static MyFP *sharedPlugin;

@interface MyFP()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic,strong) NSString *url;
@end

@implementation MyFP

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;

        NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
        if (menuItem) {
            [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
            
            NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"删除当前行（by liujy）" action:@selector(doMenuAction) keyEquivalent:@"D"];
            [actionMenuItem setKeyEquivalentModifierMask:NSShiftKeyMask];
            
            
            [actionMenuItem setTarget:self];
            [[menuItem submenu] addItem:actionMenuItem];
            
        }
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationLog:) name:nil object:nil];

    }
    return self;
}

///   监听xCode 的通知
//}

// Sample Action, for menu item:
-(void)doMenuAction
{

    JTTKeyboardEventSender *simKeyboard = [[JTTKeyboardEventSender alloc] init];
    [simKeyboard beginKeyBoradEvents];
    // Command + delete: delete current li
    
    
    ///  移动到改行末尾
    [simKeyboard sendKeyCode:kVK_ANSI_E withModifierCommand:NO alt:NO shift:NO control:YES];
    ///  删除改行
    [simKeyboard sendKeyCode:kVK_ANSI_A withModifierCommand:NO alt:NO shift:YES control:YES];
    ///  再删一行
    [simKeyboard sendKeyCode:kVK_Delete withModifierCommand:NO alt:NO shift:NO control:NO];
    
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
