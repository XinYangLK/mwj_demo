//
//  KLMallActivityCell.h
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLMallActivityBtn.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^ActiveBlock)(KLMallActivityBtn * sender);

@interface KLMallActivityCell : UITableViewCell

//***  推荐  **/
@property (nonatomic, strong) KLMallActivityBtn *recommendBtn;
//***  优惠特享  **/
@property (nonatomic, strong) KLMallActivityBtn *favourableBtn;
//***  定制  **/
@property (nonatomic, strong) KLMallActivityBtn *makeBtn;

@property (nonatomic,  copy ) ActiveBlock activeBlock;
@end

NS_ASSUME_NONNULL_END
