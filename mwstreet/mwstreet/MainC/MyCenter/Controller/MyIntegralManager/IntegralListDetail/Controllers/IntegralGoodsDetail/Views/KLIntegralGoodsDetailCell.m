//
//  KLIntegralGoodsDetailCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLIntegralGoodsDetailCell.h"

@interface KLIntegralGoodsDetailCell ()

@property (nonatomic, strong) UIView *line;

@end

@implementation KLIntegralGoodsDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    [self titleLab];
    [self numLab];
    [self exchangeBtn];
    [self line];
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.top.offset = AdaptedHeight(19);
                                          make.height.offset =AdaptedHeight(15);
                                          make.width.offset =MainWidth -AdaptedWidth(30);
                                          make.centerX.offset = 0;
                                      }];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}


- (UILabel *)numLab {
    if (!_numLab){
        _numLab = [UILabel zj_labelWithFontSize:14
                                      textColor:RedColor
                                      superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.top.mas_equalTo(self.titleLab.mas_bottom).offset = AdaptedHeight(12);
                                        make.width.centerX.height.mas_equalTo(self.titleLab);
                                    }];
        _numLab.textAlignment = NSTextAlignmentCenter;
    }
    return _numLab;
}

- (UIButton *)exchangeBtn {
    if (!_exchangeBtn){
        @weakify(self)
        _exchangeBtn = [UIButton zj_buttonWithTitle:@"立即兑换"
                                         titleColor:RGBSigle(255)
                                           norImage:nil
                                      selectedImage:nil
                                          backColor:MainColor
                                           fontSize:14
                                             isBold:NO
                                       cornerRadius:AdaptedHeight(16)
                                            supView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.height.offset  = AdaptedWidth(32);
                                            make.width.offset   = AdaptedWidth(126);
                                            make.bottom.offset  = AdaptedHeight(-14);
                                            make.centerX.offset = 0;
                                        } touchUp:^(id sender) {
                                            @strongify(self)
                                            self.exchangeBtnChick ? self.exchangeBtnChick(sender) : nil;
                                        }];
    }
    return _exchangeBtn;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:SpacColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.right.bottom.offset = 0;
                                     make.height.offset = 5;
                                 }];
    }
    return _line;
}



@end



@implementation KLIntegralGoodsWebCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self webView];
    }
    return self;
}


//***  加载web  **/
- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectZero];
        _webView.scrollView.scrollEnabled = YES;
        [self.contentView addSubview:_webView];

    }
    return _webView;
}


@end
