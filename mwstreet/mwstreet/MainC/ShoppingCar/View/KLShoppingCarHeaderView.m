//
//  KLShoppingCarHeaderView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLShoppingCarHeaderView.h"

@implementation KLShoppingCarHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =RGB(255,236,236);
        [self configerUI];
    }
    return self;
}
#pragma mark ------ 构建 UI
- (void)configerUI {
    
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.storeImg];
    [self.contentView addSubview:self.storeName];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(13);
        make.width.height.offset =AdaptedWidth(25);
        make.centerY.offset =0;
    }];
    [self.storeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectBtn.mas_right).offset =AdaptedWidth(10);
        make.centerY.mas_equalTo(self.selectBtn);
        make.width.height.offset =AdaptedHeight(15);
    }];
    [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeImg.mas_right).offset =AdaptedWidth(10);
        make.height.centerY.mas_equalTo(self.selectBtn);
        make.right.offset =AdaptedWidth(-15);
    }];
}

- (UIButton *)selectBtn {
    if (!_selectBtn){
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(selectedAll:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

- (UIImageView *)storeImg {
    if (!_storeImg){
        _storeImg = [[UIImageView alloc]init];
        _storeImg.image =[UIImage imageNamed:@"cheng"];
    }
    return _storeImg;
}

- (UILabel *)storeName {
    if (!_storeName){
        _storeName = [UILabel createLabelTextColor:TitleColor font:kFont_14];
        _storeName.text =@"萌物街商城";
    }
    return _storeName;
}


//***  button 按钮响应  **/
- (void)selectedAll:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    [self setSelectedBtnImg:sender.selected];
    
    if ([self.delegate respondsToSelector:@selector(hearderView:isSelected:section:)]) {
        [self.delegate hearderView:self isSelected:sender.selected section:self.section];
    }
}

- (void)setSelectedBtnImg:(BOOL)slected {
    if (slected) {
        [_selectBtn setImage:[UIImage imageNamed:@"dui"] forState:(UIControlStateNormal)];
    } else {
        [_selectBtn setImage:[UIImage imageNamed:@"yuan"] forState:(UIControlStateNormal)];
    }
}

@end
