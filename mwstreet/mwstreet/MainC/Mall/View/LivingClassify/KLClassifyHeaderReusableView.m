//
//  KLClassifyHeaderReusableView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLClassifyHeaderReusableView.h"

@implementation KLClassifyHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.lineView];

        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset =AdaptedWidth(15);
            make.centerY.right.offset = 0;
            make.height.offset = AdaptedHeight(15);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.titleLab);
            make.height.offset = 0.5;
            make.bottom.offset =0;
        }];
    }
    return self;
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
    }
    return _titleLab;
}
- (UIView *)lineView {
    if (!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor =LineColor;
    }
    return _lineView;
}

@end


@implementation KLClassifyFooterReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self lookAllBtn];
        [self addSubview:self.lineView];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset = 0.5;
            make.left.right.bottom.offset =0;
        }];
    }
    return self;
}

- (void)setSection:(NSInteger)section {
    _section = section;
    if (_section == 1) {
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.offset = 0.5;
            make.left.right.offset =0;
            make.bottom.offset = -TabbarSafeBottomMargin;
        }];
        [self.lookAllBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset = 0;
            make.centerY.offset = (kDevice_Is_iPhoneX) ? -AdaptedHeight(15) : 0;
            make.height.offset  = AdaptedHeight(30);
            make.width.offset   = AdaptedWidth(120);
        }];
    }else {
        
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.offset = 0.5;
            make.left.right.bottom.offset =0;
        }];
        [self.lookAllBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.offset = 0;
            make.height.offset = AdaptedHeight(30);
            make.width.offset  = AdaptedWidth(120);
        }];
    }
}





- (UIButton *)lookAllBtn {
    if (!_lookAllBtn){
        klWeakSelf;
        _lookAllBtn = [UIButton zj_buttonWithTitle:nil titleColor:TextColor norImage:nil selectedImage:nil backColor:[UIColor clearColor] fontSize:14 isBold:NO cornerRadius:0 supView:self constraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.offset =0;
            make.height.offset =AdaptedHeight(30);
            make.width.offset =AdaptedWidth(120);
        } touchUp:^(id sender) {
            weakSelf.lookAllBlock(sender,weakSelf.section);
        }];
    }
    return _lookAllBtn;
}


- (UIView *)lineView {
    if (!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor =LineColor;
    }
    return _lineView;
}

@end
