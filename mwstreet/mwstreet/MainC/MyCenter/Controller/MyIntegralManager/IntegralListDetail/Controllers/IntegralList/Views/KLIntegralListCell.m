//
//  KLIntegralListCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLIntegralListCell.h"

@implementation KLIntegralListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    [self titleLab];
    [self timeLab];
    [self scoreLab];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:TitleColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset   = AdaptedHeight(18);
                                          make.top.offset    = AdaptedHeight(13);
                                          make.height.offset = AdaptedHeight(15);
                                          make.right.offset  = AdaptedWidth(-85);
                                      }];
    }
    return _titleLab;
}


- (UILabel *)timeLab {
    if (!_timeLab){
        _timeLab = [UILabel zj_labelWithFontSize:12
                                       textColor:TextColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.right.height.left.mas_equalTo(self.titleLab);
                                         make.bottom.offset = AdaptedHeight(-15);
                                     }];
    }
    return _timeLab;
}


- (UILabel *)scoreLab {
    if (!_scoreLab){
        _scoreLab = [UILabel zj_labelWithFontSize:15
                                        textColor:RedColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.right.offset =AdaptedWidth(-20);
                                          make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(5);
                                          make.height.offset =AdaptedHeight(20);
                                          make.centerY.offset = 0;
                                      }];
        _scoreLab.textAlignment =NSTextAlignmentRight;
    }
    return _scoreLab;
}


@end
