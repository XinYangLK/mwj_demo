//
//  KLStoreBannerCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/29.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreBannerCell.h"

@interface KLStoreBannerCell ()
@property (nonatomic, strong) SDCycleScrollView * carouselView;

@end

@implementation KLStoreBannerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.carouselView];

        [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)setImgArray:(NSArray *)imgArray {
    _imgArray = imgArray;
    
    self.carouselView.imageURLStringsGroup = imgArray;
    
}


//***  轮播图控件  **/
- (SDCycleScrollView *)carouselView {
    
    if (!_carouselView){
        _carouselView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:nil];
        _carouselView.tag = 20;
        _carouselView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _carouselView.autoScrollTimeInterval = 4;
        _carouselView.autoScroll = NO;
        _carouselView.currentPageDotColor = MainColor;
        _carouselView.pageDotColor =[UIColor whiteColor];
    }
    return _carouselView;
}

@end
