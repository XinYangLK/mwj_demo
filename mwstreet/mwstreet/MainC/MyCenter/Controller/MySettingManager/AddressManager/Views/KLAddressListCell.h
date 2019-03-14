//
//  KLAddressListCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/20.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLAddressListCell : UITableViewCell

//***  名称  **/
@property (nonatomic, strong) UILabel *nameLab;
//***  电话  **/
@property (nonatomic, strong) UILabel *phoneLab;
//***  默认状态  **/
@property (nonatomic, strong) UILabel *statusLab;
//***  详细地址  **/
@property (nonatomic, strong) UILabel *addressLab;
//***  箭头  **/
@property (nonatomic, strong) UIImageView *angleImg;
//***  分割线  **/
@property (nonatomic, strong) UIView *line;
//***  编辑按钮  **/
@property (nonatomic, strong) UIButton *editBtn;
//***  删除按钮  **/
@property (nonatomic, strong) UIButton *delectBtn;

@end

NS_ASSUME_NONNULL_END
