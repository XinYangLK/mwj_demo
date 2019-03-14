//
//  KLMyDistributionAssistantCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CellTextBlock)(NSString * text, NSInteger tag);
typedef void(^CellBtnBlock)(UIButton * sender);

@interface KLMyDistributionAssistantCell : UITableViewCell

@property (nonatomic,copy) CellBtnBlock  cellBtnBlock;
@property (nonatomic,copy) CellTextBlock cellTextBlock;
@end

NS_ASSUME_NONNULL_END
