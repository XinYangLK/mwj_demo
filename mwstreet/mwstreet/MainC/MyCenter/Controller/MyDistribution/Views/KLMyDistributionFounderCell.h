//
//  KLMyDistributionFounderCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLMyDisInputView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TextInputBlock)(NSString * text, NSInteger tag);
typedef void(^SexChangeCellBlock)(UIButton * button);
typedef void(^ApplyBtnChick)(UIButton * button);

@interface KLMyDistributionFounderCell : UITableViewCell
//***  获取输入框文本  **/
@property (nonatomic,copy) TextInputBlock     textInputBlock;
//***  性别选择  **/
@property (nonatomic,copy) SexChangeCellBlock sexChangeCellBlock;
//***  立即申请  **/
@property (nonatomic,copy) ApplyBtnChick      applyBtnChick;
//***  审核状态  **/
@property (nonatomic, strong) NSString      * titleStr;



@end


@interface KLMyDistributionFouPriCell : UITableViewCell

@property (nonatomic, strong) UIImageView * imgV;
@property (nonatomic, strong) UILabel     * titleLab;
@property (nonatomic, strong) UILabel     * textLab;

@end





NS_ASSUME_NONNULL_END
