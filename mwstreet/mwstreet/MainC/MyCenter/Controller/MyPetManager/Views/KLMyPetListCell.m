//
//  KLMyPetListCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyPetListCell.h"

@implementation KLMyPetListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configerUI];
    }
    return self;
}


- (void)configerUI {
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.classifyLab];
    [self.contentView addSubview:self.ageLab];
    [self.contentView addSubview:self.eidtBtn];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(25);
        make.height.width.offset =AdaptedHeight(43);
        make.centerY.offset = 0;
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset =AdaptedHeight(25);
        make.top.offset =AdaptedHeight(15);
        make.height.offset =AdaptedHeight(15);
        make.right.offset =AdaptedWidth(-60);
    }];
    [self.classifyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.imgView);
        make.width.offset =AdaptedWidth(130);
        make.height.left.mas_equalTo(self.nameLab);
    }];
    
    [self.ageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset =AdaptedWidth(-50);
        make.bottom.mas_equalTo(self.imgView);
        make.height.mas_equalTo(self.nameLab);
        make.left.mas_equalTo(self.classifyLab.mas_right).offset =AdaptedWidth(10);
    }];
   
    

    [self.eidtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imgView);
        make.height.width.offset =AdaptedHeight(21);
        make.right.offset =AdaptedWidth(-20);
    }];
    
}


- (UIImageView *)imgView {
    if (!_imgView){
        _imgView = [[UIImageView alloc]init];
        [_imgView setLayerCornerRadius:AdaptedHeight(22)];
    }
    return _imgView;
}

- (UILabel *)nameLab {
    if (!_nameLab){
        _nameLab = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
    }
    return _nameLab;
}

- (UILabel *)classifyLab {
    if (!_classifyLab){
        _classifyLab = [UILabel createLabelTextColor:TitleColor font:kFont_12];
    }
    return _classifyLab;
}

- (UILabel *)ageLab {
    if (!_ageLab){
        _ageLab = [UILabel createLabelTextColor:TitleColor font:kFont_12];
    }
    return _ageLab;
}



- (UIButton *)eidtBtn {
    if (!_eidtBtn){
        _eidtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eidtBtn setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
        [_eidtBtn addTarget:self action:@selector(eidtBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eidtBtn;
}


//*** cell 编辑按钮响应  **/
- (void)eidtBtnChick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didEidtBtnActionChick:)]) {
        [self.delegate didEidtBtnActionChick:self];
    }
    
}

@end
