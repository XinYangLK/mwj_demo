//
//  KLStoreClinicMsgCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/30.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreClinicMsgCell.h"

@interface KLStoreClinicMsgCell ()

@property (nonatomic, strong) UILabel * msgLab;

@end

@implementation KLStoreClinicMsgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.msgLab];
    }
    return self;
}

- (void)setMsgStr:(NSString *)msgStr {
    _msgStr = msgStr;
    self.msgLab.text = [NSString getBlankString:_msgStr];
    CGSize size =[self.msgLab getLableRectWithMaxWidth:MainWidth -AdaptedWidth(20)];
    [self.msgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.top.offset = AdaptedHeight(5);
        make.bottom.offset = AdaptedHeight(-20);
        make.width.offset =  size.width;
    }];
}



- (UILabel *)msgLab {
    if (!_msgLab){
        _msgLab = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_12];
        _msgLab.lineSpace = 12;
        _msgLab.numberOfLines =0;
    }
    return _msgLab;
}



@end
