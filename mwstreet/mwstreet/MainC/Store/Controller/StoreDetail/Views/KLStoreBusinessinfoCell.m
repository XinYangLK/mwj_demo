//
//  KLStoreBusinessinfoCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/30.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreBusinessinfoCell.h"

@interface KLStoreBusinessinfoCell ()

@property (nonatomic, strong) UIImageView * imgV;
@property (nonatomic, strong) UILabel * msgLab;

@end

@implementation KLStoreBusinessinfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self imgV];
        [self msgLab];
    }
    return self;
}
- (void)setMsgStr:(NSString *)msgStr {
    _msgStr = msgStr;
    self.msgLab.text = [NSString getBlankString:_msgStr];
    CGSize size =[self.msgLab getLableRectWithMaxWidth:MainWidth -AdaptedWidth(45)];
    [self.msgLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgV.mas_right).offset =AdaptedWidth(5);
        make.top.offset = AdaptedHeight(5);
        make.bottom.offset = AdaptedHeight(-20);
        make.width.offset =  size.width;
    }];
}

- (UIImageView *)imgV {
    if (!_imgV){
        _imgV = [UIImageView zj_imageViewWithImage:@"yy"
                                         SuperView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.left.offset =AdaptedWidth(10);
                                           make.height.width.offset = AdaptedWidth(20);
                                           make.top.offset =0;
                                       }];
    }
    return _imgV;
}

- (UILabel *)msgLab {
    if (!_msgLab){
        _msgLab = [UILabel zj_labelWithFontSize:11
                                          lines:0
                                           text:nil
                                      textColor:TextColor
                                      superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.left.mas_equalTo(self.imgV.mas_right).offset =AdaptedWidth(5);
                                        make.right.offset =AdaptedWidth(-10);
                                        make.bottom.offset =AdaptedHeight(-20);
                                        make.top.offset =AdaptedHeight(5);
                                    }];
    }
    return _msgLab;
}

@end
