//
//  KLGoodsDetailAddressOrSpecCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLGoodsDetailAddressOrSpecCell : UITableViewCell

@property (nonatomic, strong) NSString * specText;

//***  分割条  **/
@property (nonatomic, strong) UIView * speaLine;
//***  标题  **/
@property (nonatomic, strong) UILabel * titleLab;
//***  内容  **/
@property (nonatomic, strong) UILabel * textLab;
//***  箭头  **/
@property (nonatomic, strong) UIImageView *angleImg;

@end

NS_ASSUME_NONNULL_END
