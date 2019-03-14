//
//  KLCountFooterView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/31.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PPNumberButton/PPNumberButton.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChangeNumCellBlock)(CGFloat number);

@interface KLCountFooterView : UICollectionReusableView

/**  商品数量 text   */
@property(nonatomic, retain)  UILabel        * countLab;
/**  加减三方控件   */
@property (strong, nonatomic) PPNumberButton * numberButton;
/**  加减框数值回调      */
@property (nonatomic,copy)   ChangeNumCellBlock changeNumCellBlock;
/**  最大值(库存)   */
@property (nonatomic, assign) NSInteger maxValue;

@end

NS_ASSUME_NONNULL_END
