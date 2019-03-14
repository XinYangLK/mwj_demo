//
//  KLSpecAttributeCollectionCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/10.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLSpecAttributeCollectionCell.h"

@implementation KLSpecAttributeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self setLayerCornerRadius:5];
        [self.contentView addSubview:self.specLab];
    }
    return self;
}
-(void)layoutSubviews {
    
    [self.specLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


- (void)setPropsInfo:(NSDictionary *)propsInfo{
    _propsInfo = propsInfo;
    self.specLab.text = propsInfo[@"standardName"];
}

- (UILabel *)specLab {
    if (!_specLab){
        _specLab = [UILabel createLabelTextColor:TitleColor font:kFont_13];
        _specLab.textAlignment =NSTextAlignmentCenter;
    }
    return _specLab;
}


@end
