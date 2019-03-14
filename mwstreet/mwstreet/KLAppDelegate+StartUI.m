//
//  KLAppDelegate+StartUI.m
//  mwstreet
//
//  Created by 科pro on 2019/2/1.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLAppDelegate+StartUI.h"
#import "KLGuideDisplayView.h"

#import <IQKeyboardManager/IQKeyboardManager.h>

#import <EasyShowView/EasyTextGlobalConfig.h>
#import <EasyShowView/EasyLoadingGlobalConfig.h>
#import <EasyShowView/EasyAlertGlobalConfig.h>
#import <EasyShowView/EasyEmptyGlobalConfig.h>

static NSString *const EVRR_LAUNCHED = @"everLaunched";
static NSString *const FIRST_LAUNCHED = @"firstLaunch";

@implementation KLAppDelegate (StartUI)

#pragma mark - 引导页
- (void)introductoryPages{
    
    if (![kUSER_DEFAULT boolForKey:EVRR_LAUNCHED]) {
        [kUSER_DEFAULT setBool:YES forKey:EVRR_LAUNCHED];
        [kUSER_DEFAULT setBool:YES forKey:FIRST_LAUNCHED];
    }else{
        [kUSER_DEFAULT setBool:NO forKey:FIRST_LAUNCHED];
    }
    
    if ([kUSER_DEFAULT boolForKey:FIRST_LAUNCHED]) {
        
        // 这里判断是否第一次
        KLGuideDisplayView *hvc = [[KLGuideDisplayView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
        [self.window.rootViewController.view addSubview:hvc];
        
        [UIView animateWithDuration:0.25 animations:^{
            hvc.frame = CGRectMake(0, 0, MainWidth, MainHeight);
        }];
    }
}


#pragma mark - 吐司提示三方初始化
- (void)lodingAtTheTopOfTheClues{
    
    /**显示文字**/
    EasyTextGlobalConfig *config = [EasyTextGlobalConfig shared];
    config.bgColor       = [UIColor whiteColor];
    config.titleColor    = [UIColor blackColor];
    config.bgColor       = WhiteAlphaColor(0.5) ;
    config.shadowColor   = [UIColor clearColor] ;
    config.animationType = TextAnimationTypeFade;
    config.statusType    = TextStatusTypeBottom ;
    
    
    /**显示加载框**/
    EasyLoadingGlobalConfig *LoadingConfig = [EasyLoadingGlobalConfig shared];
    LoadingConfig.LoadingType = LoadingAnimationTypeFade ;
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:8];
    for (int i = 0; i < 9; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"icon_hud_%d",i+1]];
        [tempArr addObject:img] ;
    }
    LoadingConfig.playImagesArray   = tempArr ;
    LoadingConfig.LoadingType       = LoadingShowTypePlayImages;
    LoadingConfig.superReceiveEvent = NO;
    LoadingConfig.showOnWindow      = YES;

    
    /**显示空白页面**/
    EasyEmptyGlobalConfig  *emptyConfig = [EasyEmptyGlobalConfig shared];
    emptyConfig.bgColor = [UIColor groupTableViewBackgroundColor];
    
    
    /**显示alert**/
    EasyAlertGlobalConfig *alertConfig = [EasyAlertGlobalConfig shared];
    alertConfig.titleColor = [UIColor blackColor];
    
    
}

#pragma mark - 键盘监听三方初始化设置
- (void)IQKeyboardManager {
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;    
    
}



@end
