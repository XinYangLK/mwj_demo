//
//  KLMallActivityCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLMallActivityCell.h"

@implementation KLMallActivityCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}
#pragma mark ------ 构建 UI
- (void)configerUI{
    [self.contentView addSubview:self.recommendBtn];
    [self.contentView addSubview:self.favourableBtn];
    [self.contentView addSubview:self.makeBtn];
    
    [self.recommendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.width.offset =AdaptedWidth(174);
        make.top.offset =AdaptedHeight(8);
        make.height.offset =AdaptedHeight(208);
    }];
    
    [self.favourableBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.recommendBtn.mas_right).offset =AdaptedWidth(10);
        make.right.offset =AdaptedWidth(-10);
        make.top.mas_equalTo(self.recommendBtn);
        make.height.offset = AdaptedHeight(98);
    }];
    
    [self.makeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.favourableBtn);
        make.bottom.mas_equalTo(self.recommendBtn);
        make.top.mas_equalTo(self.favourableBtn.mas_bottom).offset =AdaptedHeight(10);
    }];
    
}



- (KLMallActivityBtn *)recommendBtn {
    if (!_recommendBtn){
        _recommendBtn = [[KLMallActivityBtn alloc]initActivityType:ActivityVerticalType];
        _recommendBtn.backgroundColor =RGB(219,238,255);
        _recommendBtn.tag = 1000;
        [_recommendBtn addTarget:self action:@selector(didActiveChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recommendBtn;
}
- (KLMallActivityBtn *)favourableBtn {
    if (!_favourableBtn){
        _favourableBtn = [[KLMallActivityBtn alloc]initActivityType:ActivityHorizontalType];
        _favourableBtn.backgroundColor =RGB(255,221,237);
        _favourableBtn.imgV.image =[UIImage imageNamed:@"jianbian_h"];
        _favourableBtn.tag = 1001;
        [_favourableBtn addTarget:self action:@selector(didActiveChick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _favourableBtn;
}
- (KLMallActivityBtn *)makeBtn {
    if (!_makeBtn){
        _makeBtn = [[KLMallActivityBtn alloc]initActivityType:ActivityHorizontalType];
        _makeBtn.backgroundColor =RGB(255,238,225);
        _makeBtn.imgV.image =[UIImage imageNamed:@"jianbian_l"];
        _makeBtn.tag = 1002;
        [_makeBtn addTarget:self action:@selector(didActiveChick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _makeBtn;
}

#pragma mark - 活动按钮点击响应<1000-1002>宠友推荐，特享优惠，有宠定制
- (void)didActiveChick:(KLMallActivityBtn *)sender {
    
    self.activeBlock ? self.activeBlock(sender) : nil;
}


@end
