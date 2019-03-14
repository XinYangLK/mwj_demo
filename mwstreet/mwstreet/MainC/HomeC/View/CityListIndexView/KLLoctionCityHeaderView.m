//
//  KLLoctionCityHeaderView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLLoctionCityHeaderView.h"

@interface KLLoctionCityHeaderView ()

@property (nonatomic, strong) UILabel  * locTitleLab;
@property (nonatomic, strong) UIButton * locCityBtn;
@property (nonatomic, strong) UILabel  * hotTitleLab;

@end

@implementation KLLoctionCityHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    [self locTitleLab];
    [self locCityBtn];
    [self hotTitleLab];
}

- (UILabel *)locTitleLab {
    if (!_locTitleLab){
        _locTitleLab = [UILabel zj_labelWithFontSize:15
                                               lines:1
                                                text:@"     当前城市"
                                           textColor:RGBSigle(51)
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.right.left.top.offset    = 0;
                                             make.height.offset = AdaptedHeight(40);
                                         }];
        _locTitleLab.backgroundColor = SpacColor;
    }
    return _locTitleLab;
}

- (UIButton *)locCityBtn {
    if (!_locCityBtn){
        klWeakSelf;
        _locCityBtn = [UIButton createBtnTitle:@"上海"
                                    titleColor:TitleColor
                                          font:kFont_14
                                     imageName:@"loc"
                                backgrounColor:[UIColor clearColor]
                           SSImagePositionType:SSImagePositionTypeLeft
                                       spacing:5
                                        action:^(UIButton * _Nonnull button) {
                                            weakSelf.locCtiyBlock(button);
                                        }];
        _locCityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_locCityBtn];
        [_locCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.locTitleLab.mas_bottom);
            make.height.right.mas_equalTo(self.locTitleLab);
            make.left.offset =AdaptedWidth(20);
        }];
    }
    return _locCityBtn;
}

- (UILabel *)hotTitleLab {
    
    if (!_hotTitleLab){
        _hotTitleLab = [UILabel zj_labelWithFontSize:15
                                               lines:1
                                                text:@"     热门城市"
                                           textColor:RGBSigle(51)
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.top.mas_equalTo(self.locCityBtn.mas_bottom);
                                             make.height.left.right.mas_equalTo(self.locTitleLab);
                                         }];
        _hotTitleLab.backgroundColor = SpacColor;
    }
    return _hotTitleLab;
    
}


@end
