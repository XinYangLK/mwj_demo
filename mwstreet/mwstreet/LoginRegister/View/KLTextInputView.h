//
//  KLTextInputView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/17.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLTextInputConfigure;

NS_ASSUME_NONNULL_BEGIN

@interface KLTextInputView : UIView

//***  文本框  **/
@property (nonatomic, strong) UITextField * textField;

- (instancetype)initWithFrame:(CGRect)frame configure:(KLTextInputConfigure *)configure;

@end

NS_ASSUME_NONNULL_END
