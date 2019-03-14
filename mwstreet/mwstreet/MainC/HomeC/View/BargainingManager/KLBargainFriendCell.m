//
//  KLBargainFriendCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBargainFriendCell.h"

@interface KLBargainFriendCell()

@property (nonatomic, strong) UIImageView * friendImg;
@property (nonatomic, strong) UILabel     * accoutNameLab;
@property (nonatomic, strong) UILabel     * bargainLab;

@end

@implementation KLBargainFriendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSeparatorStyleNone;
        [self friendImg];
        [self accoutNameLab];
        [self bargainLab];
    }
    return self;
}

- (void)setImgName:(NSString *)imgName {
    _imgName = imgName;
    self.friendImg.image =[UIImage imageNamed:_imgName];
}
- (void)setAccName:(NSString *)accName {
    _accName =accName;
    self.accoutNameLab.text =[NSString getBlankString:_accName];
}
-(void)setBargain:(NSString *)bargain {
    _bargain = bargain;
    self.bargainLab.text =[NSString getBlankString:_bargain];
    self.bargainLab.attributedText =[NSMutableAttributedString getAttributedString:[NSString stringWithFormat:@"轻轻的点一下，砍掉 ￥%@",self.bargainLab.text] handleString:self.bargainLab.text handleStrFont:kFont_12 handleStrColor:RedColor];
}


- (UIImageView *)friendImg {
    if (!_friendImg){
        _friendImg = [UIImageView zj_imageViewWithImage:self.imgName
                                              SuperView:self.contentView
                                            constraints:^(MASConstraintMaker *make) {
                                                make.centerY.offset =0;
                                                make.left.offset =AdaptedWidth(10);
                                                make.height.width.offset =AdaptedWidth(25);
                                            }];
    }
    return _friendImg;
}

-(UILabel *)accoutNameLab {
    if (!_accoutNameLab){
        _accoutNameLab = [UILabel zj_labelWithFontSize:12
                                                 lines:1
                                                  text:self.accName
                                             textColor:RGBSigle(51)
                                             superView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.centerY.offset =0;
                                               make.width.offset =AdaptedWidth(100);
                                               make.height.offset =AdaptedHeight(15);
                                               make.left.mas_equalTo(self.friendImg.mas_right).offset =AdaptedWidth(5);
                                           }];
    }
    return _accoutNameLab;
}

- (UILabel *)bargainLab {
    if (!_bargainLab){
        _bargainLab = [UILabel zj_labelWithFontSize:12
                                              lines:1
                                               text:self.bargain
                                          textColor:RGBSigle(51)
                                          superView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.centerY.offset =0;
                                            make.right.offset =AdaptedWidth(-10);
                                            make.height.offset =AdaptedHeight(15);
                                            make.left.mas_equalTo(self.friendImg.mas_right).offset =AdaptedWidth(126);
                                        }];
    }
    return _bargainLab;
}


@end
