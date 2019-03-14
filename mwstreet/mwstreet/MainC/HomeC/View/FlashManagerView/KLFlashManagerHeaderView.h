//
//  KLFlashManagerHeaderView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLCountdownView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLFlashManagerHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
//***  倒计时view  **/
@property (nonatomic, strong) KLCountdownView  * countdownView;
@end

NS_ASSUME_NONNULL_END
