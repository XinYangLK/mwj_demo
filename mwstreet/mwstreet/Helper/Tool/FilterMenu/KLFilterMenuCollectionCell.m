//
//  KLFilterMenuCollectionCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLFilterMenuCollectionCell.h"

@implementation KLFilterMenuCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.selectIconBtn];
        [self.selectIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
    }
    return self;
}

- (UIButton *)selectIconBtn {
    if (!_selectIconBtn){
        _selectIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectIconBtn.userInteractionEnabled = NO;
        _selectIconBtn.backgroundColor = BackgroundColor;
        [_selectIconBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [_selectIconBtn setTitleColor:MainColor forState:UIControlStateSelected];
        [_selectIconBtn setLayerCornerRadius:5];
    }
    return _selectIconBtn;
}




-(void)UpdateCellWithState:(BOOL)select{
    self.selectIconBtn.selected = select;
    _isSelected = select;
    
    if (self.selectIconBtn.selected) {
        [_selectIconBtn setLayerCornerRadius:5 borderWidth:1 borderColor:MainColor];
        _selectIconBtn.backgroundColor =[UIColor whiteColor];
    }else{
        [_selectIconBtn setLayerCornerRadius:5 borderWidth:0 borderColor:[UIColor clearColor]];
        _selectIconBtn.backgroundColor = BackgroundColor;
    }
    
}



@end
