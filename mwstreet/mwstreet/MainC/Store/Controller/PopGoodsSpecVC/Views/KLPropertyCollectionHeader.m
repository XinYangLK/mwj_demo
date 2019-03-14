//
//  KLPropertyCollectionHeader.m
//  mwstreet
//
//  Created by 科pro on 2019/1/31.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPropertyCollectionHeader.h"

@implementation KLPropertyCollectionHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor whiteColor];
        [self headerNameLab];
    }
    return self;
}
- (UILabel *)headerNameLab {
    if (!_headerNameLab){
        _headerNameLab = [UILabel zj_labelWithFontSize:14 lines:0 text:@"属性名称" textColor:RGBSigle(51) superView:self constraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(AdaptedWidth(10));
        }];
    }
    return _headerNameLab;
}

@end
