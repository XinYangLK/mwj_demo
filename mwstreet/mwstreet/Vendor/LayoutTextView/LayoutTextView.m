//
//  TheMessageViewController.m
//  自定义聊天键盘
//
//  Created by 茹茹想 on 16/7/27.
//  Copyright © 2016年 RuXiang&YangTao. All rights reserved.
//

#import "LayoutTextView.h"

@interface LayoutTextView()<UITextViewDelegate>
{
    CGFloat maxHeight;
    CGFloat leftFloat;
    CGFloat textViewHFloat;

}
@property (assign, nonatomic) CGFloat superHight;
@property (assign, nonatomic) CGFloat textViewY;
@property (assign, nonatomic) CGFloat sendButtonOffset;
@property (assign, nonatomic) CGFloat keyBoardHight;
@property (assign, nonatomic) CGRect originalFrame;

@end

@implementation LayoutTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        maxHeight = AdaptedHeight(80);
        leftFloat = AdaptedWidth(5);
        textViewHFloat =AdaptedHeight(34);

        _originalFrame = frame;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShow:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
        self.backgroundColor = RGBSigle(235);
        
        UITextView *textView = [[UITextView alloc] init];
        textView.delegate    = self;
        textView.backgroundColor = [UIColor whiteColor];
        textView.font = kFont_15;
        textView.layer.cornerRadius  = AdaptedHeight(5);
        textView.layer.masksToBounds = YES;
        textView.layer.borderWidth   = 0.5;
        textView.layer.borderColor   = RGBSigle(204).CGColor;
        textView.layoutManager.allowsNonContiguousLayout = NO;
        textView.tintColor = MainColor;
        [self addSubview:textView];
        self.textView = textView;
        
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //字体大小
        sendBtn.titleLabel.font = kFont_15;
        [sendBtn setTitle:@"发表" forState:UIControlStateNormal];
        [sendBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [sendBtn addTarget:self action:@selector(sednBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sendBtn];
        self.sendBtn =  sendBtn;
        CGFloat textViewX = leftFloat;
        CGFloat textViewW = MainWidth- (2 * textViewX + AdaptedWidth(50));
        CGFloat textViewH = textViewHFloat;
        CGFloat textViewY = (self.frame.size.height - textViewH) * 0.5;
        _textView.frame = CGRectMake(textViewX, textViewY, textViewW - textViewX, textViewH);
        _textViewY = textViewY;
    }
    return self;
}

- (void)sednBtnAction{

    if (_sendBlock) {
        _sendBlock(_textView);
    }
    [_textView resignFirstResponder];
    _textView.text = _placeholder;
    _textView.textColor = [UIColor grayColor];
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _textView.text = _placeholder;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat sendBtnX = CGRectGetMaxX(_textView.frame) + leftFloat;

    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = sendBtnX;
        make.width.offset = AdaptedWidth(50);
        make.height.offset =  AdaptedHeight(40);
        make.centerY.offset = 0;
    }];
    
}
//改变键盘状态
- (void)clickedFaceBtn:(UIButton *)button{
    self.textView.inputView = nil;
    [self.textView reloadInputViews];
    button.tag = (button.tag+1)%2;
    [self.textView becomeFirstResponder];
}
#pragma mark - == UITextViewDelegate ==
- (void)textViewDidBeginEditing:(UITextView *)textView{

    _textView.textColor = [UIColor blackColor];

}
- (void)textViewDidChange:(UITextView *)textView{
    
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height<=frame.size.height) {

    }else{
        if (size.height>=maxHeight){
            size.height = maxHeight;
            textView.scrollEnabled = YES;   // 允许滚动
           
        }else{
            textView.scrollEnabled = NO;    // 不允许滚动
        }
    }
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    
    CGFloat superHeight = CGRectGetMaxY(textView.frame) + _textViewY;
    
    [UIView animateWithDuration:0.15 animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x, MainHeight - (self.keyBoardHight + superHeight), self.frame.size.width, superHeight)];
    }];
}

- (void)textViewDidChangeSelection:(UITextView *)textView{

    CGRect r = [textView caretRectForPosition:textView.selectedTextRange.end];
    CGFloat caretY =  MAX(r.origin.y - textView.frame.size.height + r.size.height + 8, 0);
    if (textView.contentOffset.y < caretY && r.origin.y != INFINITY) {
        textView.contentOffset = CGPointMake(0, caretY);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
   
    textView.scrollEnabled = NO;
    CGRect frame = textView.frame;
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, textViewHFloat);
    [textView layoutIfNeeded];
    [_textView resignFirstResponder];
    
}

#pragma mark - == 键盘弹出事件 ==
- (void)keyboardWasShow:(NSNotification*)notification{
    
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    _keyBoardHight = keyBoardFrame.size.height;
    
    [self translationWhenKeyboardDidShow:_keyBoardHight];
}

- (void)keyboardWillBeHidden:(NSNotification*)notification{
    
    [self translationWhenKeyBoardDidHidden];
}

- (void)translationWhenKeyboardDidShow:(CGFloat)keyBoardHight{
   
    CGFloat y = MainHeight - (keyBoardHight + self.frame.size.height);
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
    }];
    [self textViewDidChange:self.textView];
    
}

- (void)translationWhenKeyBoardDidHidden{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = self.originalFrame;
    }];
}
@end
