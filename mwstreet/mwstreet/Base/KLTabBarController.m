//
//  KLTabBarController.m
//  mengWuStreet
//
//  Created by 科pro on 2018/12/14.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLTabBarController.h"
#import "KLNavigationController.h"    //***  导航控制器  **/

//***  C 端主界面  **/
#import "KLHomeViewController.h"      //***  首页  **/
#import "KLMallViewController.h"      //***  商城  **/
#import "KLStoreViewController.h"     //***  门店  **/
#import "KLShoppingViewController.h"  //***  购物车  **/
#import "KLMyCenterViewController.h"  //***  个人中心  **/

//***  B 端主界面  **/
#import "KLBHomeViewController.h"     //***  首页  **/
#import "KLBStoreViewController.h"    //***  门店  **/
#import "KLStockBillViewController.h" //***  进货单  **/
#import "KLMeViewController.h"        //***  我的  **/


@interface KLTabBarController ()

@end

@implementation KLTabBarController


+ (void)initialize {
    
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, -1);
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = AdaptedSYSFontSize(10);
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = AdaptedSYSFontSize(10);
    selectAtts[NSForegroundColorAttributeName] = MainColor;
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}

//***  C 端界面 tabbar 控制器  **/
+ (instancetype)ShareTabbarMerchantsTypeC:(MerchantsType)type {
    
    static KLTabBarController *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] initWithType:type];
    });
    return  shareInstance;
}

//***  B 端界面 tabbar 控制器  **/
+ (instancetype)ShareTabbarMerchantsTypeB:(MerchantsType)type {
    
    static KLTabBarController *shareInstance1 = nil;
    static dispatch_once_t onceToken1;
    dispatch_once(&onceToken1, ^{
        shareInstance1 = [[self alloc] initWithType:type];
    });
    return  shareInstance1;
}


//***  初始化控制器  type  B-C 端类型  **/
- (instancetype)initWithType:(MerchantsType)type{
   self = [super init];
    
    if (self) {
        
        switch (type) {
            case MerchantsTypeC:
                
                [self addChildViewControllerWithClassname:[KLHomeViewController description] imagename:@"home" title:@"首页"];
                
                [self addChildViewControllerWithClassname:[KLMallViewController description] imagename:@"mall" title:@"商城"];
                
                [self addChildViewControllerWithClassname:[KLStoreViewController description] imagename:@"store" title:@"门店"];
                
                [self addChildViewControllerWithClassname:[KLShoppingViewController description]imagename:@"shopcar" title:@"购物车"];
                
                [self addChildViewControllerWithClassname:[KLMyCenterViewController description] imagename:@"my" title:@"我的"];
                
                break;
                
            case MerchantsTypeB:
                
                [self addChildViewControllerWithClassname:[KLBHomeViewController description] imagename:@"shouyeeeee" title:@"首页"];
                
                  [self addChildViewControllerWithClassname:[KLBStoreViewController description] imagename:@"fenleiye" title:@"分类"];
                
                [self addChildViewControllerWithClassname:[KLStockBillViewController description] imagename:@"gouwudan" title:@"进货单"];
                
                [self addChildViewControllerWithClassname:[KLMeViewController description] imagename:@"wodeee" title:@"我的"];
                
                break;
            default:
                break;
        }
    }
    return self;
   
}
    


//***  添加子控制器  **/
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    KLNavigationController *nav = [[KLNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_select"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
