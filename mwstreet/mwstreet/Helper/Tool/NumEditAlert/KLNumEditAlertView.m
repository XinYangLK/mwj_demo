//
//  KLNumEditAlertView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/24.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLNumEditAlertView.h"

@interface KLNumEditAlertView ()
//***  alert View  **/
@property (nonatomic, strong) UIView     * backgroundView;
//***  标题  **/
@property (nonatomic, strong) UILabel     * titleLab;
//***  + 按钮  **/
@property (nonatomic, strong) UIButton    * minusBtn;
//***  - 按钮  **/
@property (nonatomic, strong) UIButton    * plusBtn;
//***  数量输入框  **/
@property (nonatomic, strong) UITextField * textField;
//***  取消  **/
@property (nonatomic, strong) UIButton    * cancelBtn;
//***  确定  **/
@property (nonatomic, strong) UIButton    * submitBtn;

@property (nonatomic, strong) NSString    * number;
@end


@implementation KLNumEditAlertView

- (instancetype)initWithFrame:(CGRect)frame count:(nonnull NSString *)count{
    self =[super initWithFrame:frame];
    if (self) {
        self.number = count;
        self.frame=[UIScreen mainScreen].bounds;
        self.backgroundColor =RGBA(0, 0, 0, 0.3);
        [self.textField becomeFirstResponder];
        [self addSubview:self.backgroundView];
        [self titleLab];
        [self textField];
        [self minusBtn];
        [self plusBtn];
        [self cancelBtn];
        [self submitBtn];
    }
    return self;
}

- (UIView *)backgroundView {
    if (!_backgroundView){
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(AdaptedWidth(35),(MainHeight-AdaptedHeight(270))/2, MainWidth-AdaptedWidth(70),AdaptedHeight(170))];
        _backgroundView.backgroundColor =[UIColor whiteColor];
        [_backgroundView setLayerCornerRadius:8];
    }
    return _backgroundView;
}



- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:17
                                            lines:1
                                             text:@"编辑购买数量"
                                        textColor:RGBSigle(51)
                                        superView:self.backgroundView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.top.offset = AdaptedHeight(25);
                                          make.left.offset = AdaptedWidth(15);
                                          make.right.offset = AdaptedWidth(-15);
                                          make.height.offset = AdaptedHeight(15);
                                      }];
        _titleLab.textAlignment =NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UITextField *)textField {
    if (!_textField){
        _textField = [UITextField zj_textFieldWithHolder:@""
                                                    text:self.number
                                               superView:self.backgroundView
                                             constraints:^(MASConstraintMaker *make) {
                                                 make.centerX.offset =0;
                                                 make.width.offset =AdaptedWidth(75);
                                                 make.height.offset =AdaptedHeight(35);
                                                 make.top.mas_equalTo(self.titleLab.mas_bottom).offset =AdaptedHeight(30);
                                             }];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.textAlignment = NSTextAlignmentCenter;
        [_textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}


- (UIButton *)minusBtn {
    if (!_minusBtn){
        klWeakSelf;
        _minusBtn = [UIButton zj_buttonWithTitle:@"－"
                                      titleColor:TitleColor
                                       backColor:[UIColor whiteColor]
                                        fontSize:17
                                          isBold:YES
                                    cornerRadius:0
                                         supView:self.backgroundView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.height.top.mas_equalTo(self.textField);
                                         make.right.mas_equalTo(self.textField.mas_left).offset(AdaptedWidth(2));
                                         make.width.offset =AdaptedWidth(55);
                                     } touchUp:^(id sender) {
                                         NSInteger count = [weakSelf.textField.text integerValue];
                                         count--;
                                         if (count<=0){
                                             count = 1;
                                             return;
                                         }
                                         [weakSelf clickLeftOrRightCount:count];
                                     }];
        [_minusBtn setLayerCornerRadius:0 borderWidth:0.5 borderColor:LineColor];
    }
    return _minusBtn;
}
- (UIButton *)plusBtn {
    if (!_plusBtn){
        klWeakSelf;
        _plusBtn = [UIButton zj_buttonWithTitle:@"＋"
                                      titleColor:TitleColor
                                       backColor:[UIColor whiteColor]
                                        fontSize:14
                                          isBold:YES
                                    cornerRadius:0
                                         supView:self.backgroundView
                                     constraints:^(MASConstraintMaker *make) {
                                         
                                         make.left.mas_equalTo(self.textField.mas_right).offset(-AdaptedWidth(2));
                                         make.height.width.top.mas_equalTo(self.minusBtn);
                                         
                                     } touchUp:^(id sender) {
                                         
                                         NSInteger count = [weakSelf.textField.text integerValue];
                                         count++;
                                         [weakSelf clickLeftOrRightCount:count];
                                         
                                     }];
        [_plusBtn setLayerCornerRadius:0 borderWidth:0.5 borderColor:LineColor];
    }
    return _plusBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn){
        klWeakSelf;
        _cancelBtn = [UIButton zj_buttonWithTitle:@"取消"
                                       titleColor:TitleColor
                                        backColor:[UIColor clearColor]
                                         fontSize:14
                                           isBold:YES
                                     cornerRadius:0
                                          supView:self.backgroundView
                                      constraints:^(MASConstraintMaker *make) {
                                          
                                          make.top.mas_equalTo(self.textField.mas_bottom).offset =AdaptedHeight(25);
                                          make.left.offset =0;
                                          make.height.offset =AdaptedHeight(40);
                                          make.width.offset = (MainWidth-AdaptedWidth(70))/2;
                                          
                                      } touchUp:^(id sender) {
                                          
                                          [weakSelf fadeOut];
                                          
                                      }];
    }
    return _cancelBtn;
}

- (UIButton *)submitBtn {
    if (!_submitBtn){
        klWeakSelf;
        _submitBtn = [UIButton zj_buttonWithTitle:@"确定"
                                       titleColor:[UIColor whiteColor]
                                        backColor:MainColor
                                         fontSize:14
                                           isBold:YES
                                     cornerRadius:0
                                          supView:self.backgroundView
                                      constraints:^(MASConstraintMaker *make) {
                                          
                                          make.right.offset =0;
                                          make.width.top.height.mas_equalTo(self.cancelBtn);
                                          
                                      } touchUp:^(id sender) {
                                    
                                          if ([weakSelf.number integerValue] <= 0) {
                                              self.number = @"1";
                                              self.textField.text = self.number;
                                          }
                                          weakSelf.numBlock(weakSelf.number);
                                          [weakSelf fadeOut];

                                      }];
    }
    return _submitBtn;
}

//***  加减操作  **/
- (void)clickLeftOrRightCount:(NSInteger)count {
    self.number = [NSString stringWithFormat:@"%zd",count];
    self.textField.text = self.number;
}

//***  输入框操作  **/
- (void)textFieldEditChanged:(UITextField *)textField{
    
    self.number = textField.text;
    
}

//***  alert 加载  **/
- (void)showAnimated:(BOOL)animated{

    [[UIApplication sharedApplication].delegate.window addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}

#pragma mark - Private Methods
- (void)fadeIn{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.backgroundView.layer addAnimation:animation forKey:nil];
}

- (void)fadeOut{
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        if (finished){
            [self removeFromSuperview];
        }
    }];
}


@end
