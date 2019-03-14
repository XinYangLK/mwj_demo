//
//  KLAppDelegate+StartUI.h
//  mwstreet
//
//  Created by 科pro on 2019/2/1.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLAppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLAppDelegate (StartUI)

#pragma mark - 引导页
- (void)introductoryPages;

#pragma mark - 吐司提示三方初始化
- (void)lodingAtTheTopOfTheClues;

#pragma mark - 键盘监听三方初始化设置
- (void)IQKeyboardManager;
@end

NS_ASSUME_NONNULL_END
