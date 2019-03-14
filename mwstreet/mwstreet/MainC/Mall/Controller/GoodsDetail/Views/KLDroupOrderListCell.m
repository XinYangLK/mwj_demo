//
//  KLDroupOrderListCell.m
//  mwstreet
//
//  Created by 科pro on 2019/3/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLDroupOrderListCell.h"

@implementation KLDroupOrderListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}
- (void)configUI {
    [self imageV];
    [self telLab];
    [self titleLab];
    [self timeLab];
    [self joinBtn];
}

- (UIImageView *)imageV {
    if (!_imageV){
        _imageV = [UIImageView zj_imageViewWithImage:@"zhanweitoux"
                                           SuperView:self.contentView constraints:^(MASConstraintMaker *make) {
                                               make.left.offset = AdaptedWidth(10);
                                               make.width.height.offset = AdaptedHeight(29);
                                               make.centerY.offset = 0;
                                           }];
        [_imageV setLayerCornerRadius:AdaptedHeight(14.5)];
    }
    return _imageV;
}

- (UILabel *)telLab {
    if (!_telLab){
        _telLab = [UILabel zj_labelWithFontSize:12
                                      textColor:TitleColor
                                      superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.left.mas_equalTo(self.imageV.mas_right).offset = AdaptedWidth(15);
                                        make.centerY.offset = 0;
                                        make.height.offset = AdaptedHeight(15);
                                        make.width.offset = AdaptedWidth(90);
                                    }];
    }
    return _telLab;
}

- (UIButton *)joinBtn {
    if (!_joinBtn){
        @weakify(self)
        _joinBtn = [UIButton zj_buttonWithTitle:@"去参团"
                                     titleColor:[UIColor whiteColor]
                                      backColor:MainColor
                                       fontSize:14
                                         isBold:NO
                                   cornerRadius:5
                                        supView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.right.offset   = AdaptedWidth(-12);
                                        make.centerY.offset = 0;
                                        make.height.offset  = AdaptedHeight(23);
                                        make.width.offset   = AdaptedWidth(54);
                                    } touchUp:^(id sender) {
                                        @strongify(self)
                                        self.joinBlock ? self.joinBlock(sender, self.indexPath) : nil;
                                    }];
    }
    return _joinBtn;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:12
                                        textColor:TitleColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.right.mas_equalTo(self.joinBtn.mas_left).offset =AdaptedWidth(-30);
                                          make.width.offset = AdaptedWidth(100);
                                          make.top.offset = AdaptedHeight(8);
                                          make.height.offset =AdaptedHeight(13);
                                      }];
    }
    return _titleLab;
}

- (UILabel *)timeLab {
    if (!_timeLab){
        _timeLab = [UILabel zj_labelWithFontSize:12
                                       textColor:TitleColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.height.left.right.mas_equalTo(self.titleLab);
                                         make.bottom.offset = AdaptedHeight(-8);
                                     }];
    }
    return _timeLab;
}

@end
