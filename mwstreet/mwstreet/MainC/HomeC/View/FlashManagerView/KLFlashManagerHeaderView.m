//
//  KLFlashManagerHeaderView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLFlashManagerHeaderView.h"

@interface KLFlashManagerHeaderView ()

//***  大标题  **/
@property (nonatomic, strong) UILabel *titleLab;
//***  小标题  **/
@property (nonatomic, strong) UILabel *textLab;

//***  底部分割线  **/
@property (nonatomic, strong) UIView      * line;

@end

@implementation KLFlashManagerHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        [self configerUI];
    }
    return self;
}
- (void)configerUI {
    [self.contentView addSubview:self.countdownView];
    [self.countdownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset =AdaptedWidth(-12);
        make.centerY.offset = 0;
        make.height.offset =AdaptedHeight(20);
        make.width.offset =AdaptedWidth(85);
    }];
    [self titleLab];
    [self textLab];
    [self line];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLab.text = title;
}
- (void)setText:(NSString *)text {
    self.textLab.text = text;
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:self.title
                                        textColor:TitleColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(10);
                                          make.height.offset =AdaptedHeight(15);
                                          make.centerY.offset = 0;
                                          make.width.offset =AdaptedWidth(170);
                                      }];
    }
    return _titleLab;
}

- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel zj_labelWithFontSize:12
                                           lines:1
                                            text:self.text
                                       textColor:TitleColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.height.centerY.mas_equalTo(self.titleLab);
                                         make.right.mas_equalTo(self.countdownView.mas_left).offset =AdaptedWidth(-5);
                                         make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(5);
                                     }];
        _textLab.textAlignment =NSTextAlignmentRight;
    }
    return _textLab;
}


//***  倒计时 View  **/
- (KLCountdownView *)countdownView {
    if (!_countdownView){
        _countdownView = [[KLCountdownView alloc]initWithFrame:CGRectZero size:AdaptedWidth(20)];
    }
    return _countdownView;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:TextColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.height.offset = 0.5;
                                     make.left.right.bottom.offset = 0;
                                 }];
    }
    return _line;
}


@end
