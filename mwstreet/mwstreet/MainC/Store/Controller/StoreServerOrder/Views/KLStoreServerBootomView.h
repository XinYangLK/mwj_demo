//
//  KLStoreServerBootomView.h
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfirmBlock)(UIButton * sender);

@interface KLStoreServerBootomView : UIView

//***  分割线  **/
@property (nonatomic, strong) UIView *line;
//***  价格  **/
@property (nonatomic, strong) UILabel * titleLab;
//***  提交按钮  **/
@property (nonatomic, strong) UIButton *confirmBtn;
//***  提交回调  **/
@property (nonatomic,copy) ConfirmBlock confirmBlock;

@end

NS_ASSUME_NONNULL_END
