//
//  KLOrderTypeManagerFooterView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/15.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>


@class KLOrderTypeManagerFooterView;

@protocol KLOrderTypeManagerFooterViewDelegate <NSObject>

@optional //选实现

- (void)didGoPayBtnChick:(KLOrderTypeManagerFooterView *)footerView Section:(NSInteger)section;//去付款方法回调

@required //必实现

@end

NS_ASSUME_NONNULL_BEGIN

@interface KLOrderTypeManagerFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIButton * rightBtn;
@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UILabel  * desLab;
@property (nonatomic, strong) UIView   * line;

@property (nonatomic, strong) NSString *leftText;
@property (nonatomic, strong) NSString *rightText;

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak)   id<KLOrderTypeManagerFooterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
