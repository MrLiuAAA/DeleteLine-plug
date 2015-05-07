//
//  MyFP.h
//  MyFP
//
//  Created by 刘建扬 on 15/5/7.
//  Copyright (c) 2015年 刘建扬. All rights reserved.
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
@interface MyFP : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end