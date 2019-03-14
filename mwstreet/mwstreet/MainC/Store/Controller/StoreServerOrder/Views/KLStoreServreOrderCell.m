//
//  KLStoreServreOrderCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreServreOrderCell.h"

@implementation KLStoreServreOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
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
                                          make.left.offset    = AdaptedWidth(12);
                                          make.width.offset   = (MainWidth -AdaptedWidth(40))/2;
                                          make.centerY.offset = 0;
                                          make.height.offset  = AdaptedHeight(15);
                                      }];
    }
    return _titleLab;
}




- (UIImageView *)angleImg {
    if (!_angleImg){
        _angleImg = [[UIImageView alloc]init];
        _angleImg.contentMode = UIViewContentModeScaleAspectFit;
        _angleImg.image = [UIImage imageNamed:@"more"];
        [self.contentView addSubview:_angleImg];
        [_angleImg mas_makeConstraints:^(MASConstraintMaker *make) {
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
        _textLab = [UILabel zj_labelWithFontSize:14
                                       textColor:TitleColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(10);
                                         make.right.mas_equalTo(self.angleImg.mas_left).offset =AdaptedWidth(-8);
                                         make.height.centerY.mas_equalTo(self.titleLab);
                                     }];
        _textLab.textAlignment = NSTextAlignmentRight;
    }
    return _textLab;
}



@end
