//
//  KLAdvertisingBannerCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/21.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLAdvertisingBannerCell.h"

@implementation KLAdvertisingBannerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //横向广告图片轮播图
        [self.contentView addSubview:self.adCarouselView];
         //公告滚动图标
        [self.contentView addSubview:self.adImg];
         //公告滚动分割线
        [self.contentView addSubview:self.line];
        //公告滚动
        [self.contentView addSubview:self.adScrollView];
        
        
     
        [self.adImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.adCarouselView.mas_bottom).offset =AdaptedHeight(10);
            make.left.offset =AdaptedWidth(20);
            make.width.offset =AdaptedWidth(66);
            make.height.offset =AdaptedHeight(22);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.adImg.mas_right).offset =AdaptedWidth(15);
            make.width.offset =1;
            make.height.centerY.mas_equalTo(self.adImg);
        }];
        
        [self.adScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.line.mas_right).offset =AdaptedWidth(15);
            make.right.offset =AdaptedWidth(-15);
            make.centerY.height.mas_equalTo(self.adImg);
        }];
        

    }
    return self;
}

- (SDCycleScrollView *)adCarouselView{
    if (!_adCarouselView){
        _adCarouselView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(AdaptedWidth(10), 0, MainWidth-AdaptedWidth(20), AdaptedHeight(62))];
        _adCarouselView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _adCarouselView.autoScrollTimeInterval =4;
        _adCarouselView.tag = 21;
        _adCarouselView.backgroundColor =[UIColor clearColor];
        _adCarouselView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
//        _adCarouselView.currentPageDotImage =[UIImage imageNamed:@"page"];
//        _adCarouselView.pageDotImage =[UIImage imageNamed:@"unpage"];
        [_adCarouselView clipCornViewWith:UIRectCornerBottomLeft|UIRectCornerBottomRight withCornRad:CGSizeMake(8, 8)];
    }
    return _adCarouselView;
}


- (UIImageView *)adImg {
    if (!_adImg){
        _adImg = [[UIImageView alloc]init];
        _adImg.image =[UIImage imageNamed:@"Ad"];
    }
    return _adImg;
}

- (UIView *)line {
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor = RGB(242, 154, 118);
    }
    return _line;
}


- (SGAdvertScrollView *)adScrollView {
    if (!_adScrollView){
        _adScrollView = [[SGAdvertScrollView alloc]init];
        _adScrollView.titleColor = RGBSigle(51);
        _adScrollView.titleFont = kFont_14;
    }
    return _adScrollView;
}



@end
