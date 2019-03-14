//
//  KLMyShareTextView.h
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WY_Extension.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TextViewBlock)(NSString * text);

@interface KLMyShareTextView : UIView

@property (nonatomic,copy) TextViewBlock textViewBlock;
@property (nonatomic, strong) UITextView *textView;

@end

NS_ASSUME_NONNULL_END
