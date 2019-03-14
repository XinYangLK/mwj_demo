//
//  KLPetClassifyCollectionCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/18.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPetClassifyCollectionCell.h"

@interface KLPetClassifyCollectionCell ()

@property (nonatomic, strong) UIImageView * imgV;
@property (nonatomic, strong) UILabel     * titleLab;
@end

@implementation KLPetClassifyCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    
    [self imgV];
    [self titleLab];
}

- (void)setImg:(NSString *)img {
    _img = img ;
    self.imgV.image =[UIImage imageNamed:img];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLab.text = title;
}





- (UIImageView *)imgV {
    if (!_imgV){
        _imgV = [UIImageView zj_imageViewWithImage:nil
                                         SuperView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.bottom.offset =AdaptedHeight(-36);
                                           make.top.offset = AdaptedHeight(40);
                                           make.left.offset = AdaptedWidth(10);
                                           make.right.offset = AdaptedWidth(-10);
                                       }];
        _imgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgV;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:16
                                        textColor:RGBSigle(0)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.height.offset =AdaptedHeight(20);
                                          make.bottom.offset =AdaptedHeight(-10);
                                          make.left.offset =AdaptedWidth(10);
                                          make.right.offset =AdaptedWidth(-10);
                                      }];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLab;
}



@end
