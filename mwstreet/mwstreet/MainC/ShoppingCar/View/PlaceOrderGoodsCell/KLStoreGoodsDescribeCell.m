//
//  KLStoreGoodsDescribeCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/16.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreGoodsDescribeCell.h"
@interface KLStoreGoodsDescribeCell ()

@property (nonatomic, strong) UILabel * titleLab;

@end

@implementation KLStoreGoodsDescribeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configerUI];
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLab.text = _title;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textLab.text = _text;
    
    if (self.angleImg.hidden) {
        
        [self.textLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = AdaptedWidth(-10);
            make.centerY.offset = 0;
            make.height.offset =AdaptedHeight(15);
            make.width.offset =(MainWidth-AdaptedWidth(52))/2;
        }];
        
    }else{
        
        [self.textLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.angleImg.mas_left).offset = AdaptedWidth(-10);
            make.centerY.offset = 0;
            make.height.offset =AdaptedHeight(15);
            make.width.offset =(MainWidth-AdaptedWidth(52))/2;
        }];
    }
}



#pragma mark - lazy UI
- (void)configerUI {
    [self titleLab];
    [self textLab];
    [self angleImg];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(10);
                                          make.centerY.offset = 0;
                                          make.height.offset =AdaptedHeight(15);
                                          make.width.offset =(MainWidth-AdaptedWidth(20))/2;
                                      }];
    }
    return _titleLab;
}

- (UIImageView *)angleImg {
    if (!_angleImg){
        _angleImg = [UIImageView zj_imageViewWithImage:@"more"
                                              SuperView:self.contentView
                                            contentMode:UIViewContentModeScaleAspectFit
                                                 isClip:NO
                                            constraints:^(MASConstraintMaker *make) {
                                                make.right.offset = -15;
                                                make.centerY.offset =0;
                                                make.height.offset =AdaptedHeight(15);
                                                make.width.offset =AdaptedWidth(12);
                                            }];
    }
    return _angleImg;
}

- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel zj_labelWithFontSize:12
                                       textColor:TextColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.right.mas_equalTo(self.angleImg.mas_left).offset = AdaptedWidth(-10);
                                         make.centerY.offset = 0;
                                         make.height.offset =AdaptedHeight(15);
                                         make.width.offset =(MainWidth-AdaptedWidth(52))/2;
                                     }];
        _textLab.textAlignment = NSTextAlignmentRight;
    }
    return _textLab;
}


@end
