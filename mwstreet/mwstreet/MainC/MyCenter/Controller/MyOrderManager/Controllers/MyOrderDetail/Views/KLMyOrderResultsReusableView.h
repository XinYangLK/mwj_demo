//
//  KLMyOrderResultsReusableView.h
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BtnBlock)(UIButton * sender);
@interface KLMyOrderResultsReusableView : UICollectionReusableView

@property (nonatomic, strong) UIButton * statusBtn;
@property (nonatomic, strong) UIButton * backBtn;
@property (nonatomic, strong) UIButton * lookBtn;
@property (nonatomic, strong) UILabel  * titleLab;
@property (nonatomic, copy  ) BtnBlock btnBlock;

@end

NS_ASSUME_NONNULL_END
