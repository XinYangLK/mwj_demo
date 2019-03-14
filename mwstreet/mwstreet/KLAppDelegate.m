//
//  AppDelegate.m
//  mwstreet
//
//  Created by 科pro on 2018/12/17.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLAppDelegate.h"
#import "KLAppDelegate+StartUI.h"

@interface KLAppDelegate ()

@end

@implementation KLAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    KLLog(@"----");
//  控制器加载1 C端
    KLTabBarController *tabBarC = [KLTabBarController ShareTabbarMerchantsTypeC:MerchantsTypeC];
    self.tabbarC = tabBarC;
    [self.window setRootViewController:tabBarC];
//  控制器加载2 B端
    KLTabBarController *tabBarB = [KLTabBarController ShareTabbarMerchantsTypeB:MerchantsTypeB];
    self.tabbarB = tabBarB;
    [self.window makeKeyAndVisible];
    
//***  引导页  **/
    [self introductoryPages];
//***  吐司提示初始化  **/
    [self lodingAtTheTopOfTheClues];
//***  键盘监听初始化   **/
    [self IQKeyboardManager];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
