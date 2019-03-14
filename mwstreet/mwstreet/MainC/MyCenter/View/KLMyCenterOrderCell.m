//
//  KLMyCenterOrderCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/28.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLMyCenterOrderCell.h"
@interface KLMyCenterOrderCell ()

@property (nonatomic, strong) UILabel     * detailTextLab;
@property (nonatomic, strong) UIImageView * angleImg;
@end
@implementation KLMyCenterOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.angleImg];
        [self.contentView addSubview:self.detailTextLab];
        
        [self.angleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -15;
            make.centerY.offset =0;
            make.height.offset =AdaptedHeight(15);
            make.width.offset =AdaptedWidth(12);
        }];
        
        [self.detailTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.angleImg.mas_left).offset =AdaptedWidth(-8);
            make.centerY.height.mas_equalTo(self.angleImg);
            make.width.offset =AdaptedWidth(120);
        }];
    }
    return self;
}

- (UIImageView *)angleImg {
    if (!_angleImg){
        _angleImg = [[UIImageView alloc]init];
        _angleImg.contentMode = UIViewContentModeScaleAspectFit;
        _angleImg.image = [UIImage imageNamed:@"more"];
    }
    return _angleImg;
}
- (UILabel *)detailTextLab {
    if (!_detailTextLab){
        _detailTextLab = [UILabel createLabelTextColor:RGBSigle(192) font:kFont_12];
        _detailTextLab.textAlignment =NSTextAlignmentRight;
        _detailTextLab.text =@"查看全部订单";
    }
    return _detailTextLab;
}


@end
