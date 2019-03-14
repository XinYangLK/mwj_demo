//
//  KLGoodsDetailEvaHeaderCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLGoodsDetailEvaHeaderCell.h"

@implementation KLGoodsDetailEvaHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.angleImg];
    [self.contentView addSubview:self.evaRatioLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.width.offset =MainWidth/2;
        make.height.offset =AdaptedHeight(15);
        make.centerY.offset =0;
    }];
    
    [self.angleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -15;
        make.centerY.offset =0;
        make.height.offset =AdaptedHeight(15);
        make.width.offset =AdaptedWidth(12);
    }];
    
    [self.evaRatioLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.angleImg.mas_left).offset =AdaptedWidth(-10);
        make.width.offset =MainWidth/2-AdaptedWidth(30);
        make.height.centerY.mas_equalTo(self.titleLab);
    }];
    
    
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
    }
    return _titleLab;
}

- (UIImageView *)angleImg {
    if (!_angleImg){
        _angleImg = [[UIImageView alloc]init];
        _angleImg.contentMode = UIViewContentModeScaleAspectFit;
        _angleImg.image = [UIImage imageNamed:@"more"];
    }
    return _angleImg;
}

- (UILabel *)evaRatioLab {
    if (!_evaRatioLab){
        _evaRatioLab = [[UILabel alloc]init];
        _evaRatioLab.font =kFont_14;
        _evaRatioLab.textColor =TitleColor;
        _evaRatioLab.textAlignment =NSTextAlignmentRight;
    }
    return _evaRatioLab;
}




@end
