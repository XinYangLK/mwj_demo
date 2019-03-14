//
//  KLShoppingCarBottomView.h
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLShoppingCarBottomView : UIView
@property (nonatomic, strong) UIView      * line;
//***  选择按钮  **/
@property (nonatomic, strong) UIButton    * selectImgBtn;
//***  总价格  **/
@property (nonatomic, strong) UILabel     * totalPriceLab;
//***  结算操作 、删除操作  **/
@property (nonatomic, strong) UIButton    * actionBtn;


@end

NS_ASSUME_NONNULL_END
