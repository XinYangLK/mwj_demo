//
//  KLStoreServiceCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/29.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PayBtnBlock)(UIButton * sender);

@interface KLStoreServiceCell : UITableViewCell

@property (nonatomic,copy) PayBtnBlock  payBlock;

@end

NS_ASSUME_NONNULL_END
