//
//  KLMenuCollectionCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMenuCollectionCell.h"

@implementation KLMenuCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.selectBtn];
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}


- (UIButton *)selectBtn {
    if (!_selectBtn){
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.userInteractionEnabled = NO;
        _selectBtn.titleLabel.font = kFont_13;
        [_selectBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [_selectBtn setTitleColor:MainColor forState:UIControlStateSelected];
    }
    return _selectBtn;
}

-(void)UpdateCellWithState:(BOOL)select{
    self.selectBtn.selected = select;
    
    _isSelected = select;
}


@end
