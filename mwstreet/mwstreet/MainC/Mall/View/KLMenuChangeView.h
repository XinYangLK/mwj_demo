//
//  KLMenuChangeView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KLMenuChangeView;
@protocol KLMenuChangeViewDelegate <NSObject>

@optional //选实现
- (void)didChange:(KLMenuChangeView *)changeView actionBtnChick:(UIButton *)sender;//选择菜单按钮方法回调

@required //必实现

@end



@interface KLMenuChangeView : UIView

@property (nonatomic, strong) UIImageView *imgView; //选择背景框

@property (nonatomic, strong) NSArray * menuArray;
@property (nonatomic, strong) NSArray * btnArray;
@property (nonatomic,weak) id<KLMenuChangeViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
