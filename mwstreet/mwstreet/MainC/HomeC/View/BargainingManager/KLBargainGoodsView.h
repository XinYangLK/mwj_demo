//
//  KLBargainGoodsView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLBargainGoodsView : UIView

@property (nonatomic, strong) NSString    * goodsTitle;
@property (nonatomic, strong) NSString    * goodsPrice;
@property (nonatomic, strong) NSString    * describeStr;
@property (nonatomic, strong) NSString    * accoutName;

@property (nonatomic, strong) UIView      * backView;
@property (nonatomic, strong) UIImageView * accoutImg;
@property (nonatomic, strong) UIImageView * goodsImg;

@end

NS_ASSUME_NONNULL_END
