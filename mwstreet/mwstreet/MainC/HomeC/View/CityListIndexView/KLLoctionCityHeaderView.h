//
//  KLLoctionCityHeaderView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LocCtiyBlock)(UIButton * sender);

@interface KLLoctionCityHeaderView : UITableViewHeaderFooterView

@property (nonatomic,copy) LocCtiyBlock locCtiyBlock;
@end

NS_ASSUME_NONNULL_END
