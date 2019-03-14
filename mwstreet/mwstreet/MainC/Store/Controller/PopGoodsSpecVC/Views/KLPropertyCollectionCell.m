//
//  KLPropertyCollectionCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/31.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPropertyCollectionCell.h"

@implementation KLPropertyCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
//        self.contentView.backgroundColor = [UIColor whiteColor];
       
        [self setLayerCornerRadius:5 borderWidth:1 borderColor:LineColor];

        [self propertyLab];
    }
    return self;
}

- (UILabel *)propertyLab {
    if (!_propertyLab){
        _propertyLab = [UILabel zj_labelWithFontSize:12
                                               lines:0
                                                text:@"属性"
                                           textColor:TextColor
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.edges.mas_equalTo(self.contentView);
                                         }];
        _propertyLab.textAlignment = NSTextAlignmentCenter;
    }
    return _propertyLab;
}

@end
