//
//  KLMyCenterFunctionCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/28.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLMyCenterFunctionCell.h"

@interface KLMyCenterFunctionCell ()

@property (nonatomic, strong) UIImageView *angleImg;
@end

@implementation KLMyCenterFunctionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.angleImg];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset =0.0f;
            make.height.offset = 0.5f;
        }];
        
        [self.angleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -15;
            make.centerY.offset =0;
            make.height.offset =AdaptedHeight(15);
            make.width.offset =AdaptedWidth(12);
        }];
    }
    return self;
}

- (UILabel *)line {
    if (!_line){
        _line = [[UILabel alloc]init];
        _line.backgroundColor =COLOR(@"f0f0f0");
    }
    return _line;
}

- (UIImageView *)angleImg {
    if (!_angleImg){
        _angleImg = [[UIImageView alloc]init];
        _angleImg.contentMode = UIViewContentModeScaleAspectFit;
        _angleImg.image = [UIImage imageNamed:@"more"];
    }
    return _angleImg;
}

@end
