//
//  KLDroupOrderListCell.h
//  mwstreet
//
//  Created by 科pro on 2019/3/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^JoinBlock)(UIButton * sender ,NSIndexPath * indexPath);
@interface KLDroupOrderListCell : UITableViewCell

//***  点击当前cell  **/
@property (nonatomic, strong) NSIndexPath * indexPath;

//***  拼单用户图像  **/
@property (nonatomic, strong) UIImageView * imageV;
//***  拼单用户电话  **/
@property (nonatomic, strong) UILabel * telLab;
//***  时间标题  **/
@property (nonatomic, strong) UILabel * titleLab;
//***  剩余时间  **/
@property (nonatomic, strong) UILabel * timeLab;
//***  加入拼团按钮  **/
@property (nonatomic, strong) UIButton * joinBtn;

@property (nonatomic,copy) JoinBlock joinBlock;
@end

NS_ASSUME_NONNULL_END
