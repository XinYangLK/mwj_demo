//
//  KLMyCollectListCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/14.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLMyCollectListCell : UITableViewCell


@property (nonatomic, strong) NSString *goodsTitle;
@property (nonatomic, strong) NSString *goodsPrice;
@property (nonatomic, strong) NSString *goodsImg;
@property (nonatomic, strong) NSString *goodSpac;
//***  找相似按钮  **/
@property (nonatomic, strong) UIButton    * findBtn;
@end

NS_ASSUME_NONNULL_END
