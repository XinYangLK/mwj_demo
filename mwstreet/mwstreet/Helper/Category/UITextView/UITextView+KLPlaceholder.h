//
//  UITextView+KLPlaceholder.h
//  mwstreet
//
//  Created by 科pro on 2019/2/20.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (KLPlaceholder)
/**
 textView placeholder text
 */
@property (nonatomic ,copy)NSString *placeholder;
/**
 textView placeholder textColor
 */
@property (nonatomic ,strong)NSDictionary *placeholderAttributes;
/**
 the max inputLenth
 */
@property (nonatomic ,assign)NSInteger maxInputLength;


@end

NS_ASSUME_NONNULL_END
