//
//  KLGoodsDetailSecurityCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLGoodsDetailSecurityCell : UITableViewCell

@property (nonatomic, assign) NSInteger    markCount;

@property (nonatomic, strong) NSArray    * securityBtnArray;
//***  间隔条  **/
@property (nonatomic, strong) UILabel    * spacLab;

@end

NS_ASSUME_NONNULL_END
