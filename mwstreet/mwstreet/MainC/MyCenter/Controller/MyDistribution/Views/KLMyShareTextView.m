//
//  KLMyShareTextView.m
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyShareTextView.h"
#import "UITextView+WY_Extension.h"

@implementation KLMyShareTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self textView];
    }
    return self;
}

- (UITextView *)textView {
    if (!_textView){
        _textView = [[UITextView alloc]initWithFrame:self.bounds];
        _textView.wy_placeholderStr = @"请编辑你要分享的内容";
        _textView.wy_placeholderColor = TextColor;
        _textView.font = kFont_14;
        _textView.textColor = RGBSigle(51);
        _textView.wy_maximumLimit = 300;
        _textView.wy_characterLengthPrompt = YES;
        _textView.wy_placeholderFont = kFont_14;
        klWeakSelf;
        [_textView wy_textDidChange:^(NSString *textStr) {
            weakSelf.textViewBlock ? weakSelf.textViewBlock(textStr) : nil;
        }];
        [self addSubview:_textView];
        
    }
    return _textView;
}




@end
