//
//  KLBGoodsAttributeCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/27.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLBGoodsAttributeCell : UITableViewCell
//***  属性名称  **/
@property (nonatomic, strong) UILabel * titleLab;
//***  属性内容  **/
@property (nonatomic, strong) UILabel * textLab;
//***  属性内容Str  **/
@property (nonatomic, strong) NSString * textMsg;
@end

NS_ASSUME_NONNULL_END
