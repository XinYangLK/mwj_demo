//
//  KLNumEditAlertView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/24.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NumberBlock)(NSString * number);

@interface KLNumEditAlertView : UIView

@property (nonatomic,copy) NumberBlock numBlock;

- (instancetype)initWithFrame:(CGRect)frame count:(NSString *)count;

- (void)showAnimated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
