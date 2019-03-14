//
//  KLStoreDetailNavigationView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KLStoreDetailNavigationViewDelegate <NSObject>

@optional //选实现
- (void)popViewControllerBtnChick:(UIButton *)sender;//导航返回按钮方法回调
@required //必实现
@end


@interface KLStoreDetailNavigationView : UIView
@property (nonatomic, strong) UIButton * backBtn;  //返回按钮
@property (nonatomic, strong) UIView   * line;
@property (nonatomic, strong) UILabel  * titleLab;
@property (nonatomic,weak) id<KLStoreDetailNavigationViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
