//
//  KLStoreListCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/21.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLStoreListCell.h"

@implementation KLStoreListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size =[self.titleLab getLableRectWithMaxWidth:MainWidth-AdaptedWidth(182)];
    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(172);
        make.right.offset =AdaptedWidth(-10);
        make.height.offset = size.height+AdaptedHeight(10);
        make.top.offset =AdaptedHeight(8);
    }];
    
}


- (void)configUI{
    
    [self.contentView addSubview:self.goodsImg];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.distanceLab];
    [self.contentView addSubview:self.locImg];
    [self.contentView addSubview:self.addressLab];
    [self.contentView addSubview:self.botomLine];
    
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.top.offset =AdaptedHeight(12);
        make.bottom.offset =AdaptedHeight(-19);
        make.width.offset =AdaptedWidth(150);
    }];
   
    [self.distanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset =AdaptedWidth(-12);
        make.height.centerY.mas_equalTo(self.starView);
        make.width.offset =AdaptedWidth(60);
    }];
    
    [self.locImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.starView);
        make.bottom.mas_equalTo(self.goodsImg.mas_bottom).offset =AdaptedHeight(-4);
        make.width.offset =AdaptedWidth(12);
        make.height.offset =AdaptedHeight(14);

    }];
    
    [self.addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.locImg.mas_right).offset =AdaptedWidth(7);
        make.bottom.mas_equalTo(self.goodsImg);
        make.height.offset =AdaptedHeight(20);
        make.right.offset =AdaptedWidth(-12);
    }];
    
    [self.botomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset =0.0f;
        make.height.offset =AdaptedHeight(5);
    }];
   
    
}

- (UIImageView *)goodsImg {
    if (!_goodsImg){
        _goodsImg = [[UIImageView alloc]init];
        _goodsImg.backgroundColor = MainColor;
        [_goodsImg setLayerCornerRadius:5];
    }
    return _goodsImg;
}
- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
//        _titleLab.numberOfLines =2;
        _titleLab.lineSpace =4;
    }
    return _titleLab;
}

- (SYStarRatingView *)starView {
    if (!_starView){
        _starView = [[SYStarRatingView alloc]initWithFrame:CGRectMake(AdaptedWidth(172), AdaptedHeight(45), AdaptedWidth(75), AdaptedHeight(12))];
        _starView.foregroundImageName = @"xin_h";
        _starView.backgroundImageName = @"xin";
        CGFloat num = arc4random()%10;
        [_starView setScore:num/10 withAnimation:YES];
        _starView.isMove =NO;
        _starView.foregroundViewColor = MainColor;
    }
    return _starView;
}


- (UILabel *)distanceLab {
    if (!_distanceLab){
        _distanceLab = [UILabel createLabelTextColor:RGB(4,207,215) font:kFont_10];
        _distanceLab.textAlignment =NSTextAlignmentRight;
    }
    return _distanceLab;
}

- (UIImageView *)locImg {
    if (!_locImg){
        _locImg = [[UIImageView alloc]init];
        _locImg.image =[UIImage imageNamed:@"loc"];
        _locImg.contentMode =UIViewContentModeScaleAspectFit;
    }
    return _locImg;
}

- (UILabel *)addressLab {
    if (!_addressLab){
        _addressLab = [UILabel createLabelTextColor:TitleColor font:kFont_12];
    }
    return _addressLab;
}


- (UIView *)botomLine {
    if (!_botomLine){
        _botomLine = [[UIView alloc]init];
        _botomLine.backgroundColor =SpacColor;
    }
    return _botomLine;
}










@end
