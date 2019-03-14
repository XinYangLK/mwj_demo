//
//  KLSearchHeaderView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Block)(UIButton * sender);

@interface KLSearchHeaderView : UIView

@property (nonatomic, strong) UILabel  * titleLab;
@property (nonatomic, strong) UIButton * delectBtn;
@property (nonatomic, copy)   Block      delectAllBlock;

@end

NS_ASSUME_NONNULL_END
