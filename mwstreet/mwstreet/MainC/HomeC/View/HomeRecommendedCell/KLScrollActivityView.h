//
//  KLScrollActivityView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/23.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLCountdownView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MoreBlock)(UIButton * button);
typedef void(^GoodsBlock)(UIButton * button,NSIndexPath *indexPath);

@interface KLScrollActivityView : UIView

//***  更多 ->按钮点击事件  **/
@property (nonatomic,copy) MoreBlock   moreBlock;
//***  滑动商品 ->按钮点击事件  **/
@property (nonatomic,copy) GoodsBlock  goodsBlock;

//倒计时
@property (nonatomic, strong) KLCountdownView * countdownView;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title text:(NSString *)text goodsArray:(NSArray *)goodsArray hidden:(BOOL)hidden indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
