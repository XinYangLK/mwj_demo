//
//  KLBaseViewController.h
//  mengWuStreet
//
//  Created by 科pro on 2018/12/14.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  BaseViewControllerDataSource<NSObject>
@optional
//设置导航标题
-(NSMutableAttributedString*)setTitle;
//设置导航左边按钮
-(UIButton*)set_leftButton;
//设置导航右边按钮
-(UIButton*)set_rightButton;
//设置导航背景颜色
-(UIColor*)set_colorBackground;
//设置导航高度
-(CGFloat)set_navigationHeight;
//-(UIView*)set_bottomView;
//设置导航背景图片
-(UIImage*)navBackgroundImage;
//导航底边缘线是否隐藏
-(BOOL)hideNavigationBottomLine;
//设置导航左边按钮图片
-(UIImage*)set_leftBarButtonItemWithImage;
//设置导航右边按钮图片
-(UIImage*)set_rightBarButtonItemWithImage;
@end

@protocol BaseViewControllerDelegate <NSObject>


@optional
-(void)left_button_event:(UIButton*)sender;
-(void)right_button_event:(UIButton*)sender;
-(void)title_click_event:(UIView*)sender;

@end

@interface KLBaseViewController : UIViewController<BaseViewControllerDataSource,BaseViewControllerDelegate>

@property (nonatomic, strong) UIColor * navTitleColor;

-(void)set_Title:(NSMutableAttributedString *)title;

-(void)setNavigationBack:(UIImage*)image;
//设置导航标题
- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle;
@end

NS_ASSUME_NONNULL_END
