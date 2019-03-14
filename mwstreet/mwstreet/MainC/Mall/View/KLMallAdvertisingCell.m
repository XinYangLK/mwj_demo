//
//  KLMallAdvertisingCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLMallAdvertisingCell.h"

@implementation KLMallAdvertisingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.AdImg];
        [self.AdImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (UIImageView *)AdImg {
    if (!_AdImg){
        _AdImg = [[UIImageView alloc]init];
    }
    return _AdImg;
}


@end
