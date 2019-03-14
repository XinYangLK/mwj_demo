//
//  KLHeaderScaleView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/18.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KLHeaderScaleViewDelegate <NSObject>

@optional //选实现
- (void)didHeaderBtnChick:(NSInteger)tag;//表头方法回调

@required //必实现

@end


@interface KLHeaderScaleView : UIView

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic,weak) id<KLHeaderScaleViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame title:(NSString *__nullable)title telPhone:(NSString *__nullable)phone;


@end

NS_ASSUME_NONNULL_END
