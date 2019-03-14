//
//  AppDelegate.h
//  mwstreet
//
//  Created by 科pro on 2018/12/17.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLTabBarController.h"

@interface KLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) KLTabBarController *tabbarC;
@property (nonatomic, strong) KLTabBarController *tabbarB;

@end

