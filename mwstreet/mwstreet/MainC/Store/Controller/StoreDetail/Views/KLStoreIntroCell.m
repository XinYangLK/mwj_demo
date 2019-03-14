//
//  KLStoreIntroCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/29.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreIntroCell.h"
#import "LXTagsView.h"
@interface KLStoreIntroCell()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *textLab;
@property (nonatomic, strong) SYStarRatingView *starView;
@property (nonatomic, strong) UILabel *scoreLab;
@property (nonatomic ,strong) LXTagsView *tagsView;
@property (nonatomic, strong) UIView * line;


@end

@implementation KLStoreIntroCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self titleLab];
        [self textLab];
        [self starView];
        [self scoreLab];
        [self tagsView];
        [self line];
    }
    return self;
}
-(void)setItems:(NSArray *)items{
    _items = items;
    self.tagsView.dataA = items;
    
    [_tagsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.mas_equalTo(self.textLab.mas_bottom).offset = AdaptedHeight(23);
    }];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:16
                                            lines:1
                                             text:@"派多格宠物生活馆"
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(14);
                                          make.height.offset =AdaptedHeight(18);
                                          make.top.offset =AdaptedHeight(12);
                                          make.right.offset =AdaptedWidth(-130);
                                      }];
    }
    return _titleLab;
}

- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel zj_labelWithFontSize:12
                                            lines:1
                                             text:@"上海市    宠物医院"
                                        textColor:TitleColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(14);
                                          make.height.offset =AdaptedHeight(15);
                                          make.top.mas_equalTo(self.titleLab.mas_bottom).offset =AdaptedHeight(17);
                                          make.right.offset =AdaptedWidth(-30);
                                      }];
    }
    return _textLab;
}



- (UILabel *)scoreLab {
    if (!_scoreLab){
        _scoreLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:@"5.0"
                                        textColor:RGBSigle(89)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.right.offset =AdaptedWidth(-12);
                                          make.centerY.height.mas_equalTo(self.titleLab);
                                          make.width.offset =AdaptedWidth(30);
                                      }];
    }
    return _scoreLab;
}


- (SYStarRatingView *)starView {
    if (!_starView){
        CGFloat x = MainWidth - AdaptedWidth(130);
        CGFloat y = AdaptedHeight(16);
        CGFloat w = AdaptedWidth(78);
        CGFloat h = AdaptedHeight(12);
        _starView = [[SYStarRatingView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        _starView.foregroundImageName = @"xin_h";
        _starView.backgroundImageName = @"xin";
        CGFloat num = arc4random()%10;
        [_starView setScore:num/10 withAnimation:YES];
        _starView.isMove =NO;
        _starView.foregroundViewColor = MainColor;
        [self.contentView addSubview:_starView];
    }
    return _starView;
}


- (LXTagsView *)tagsView {
    if (!_tagsView){
         _tagsView =[[LXTagsView alloc]init];
        [self.contentView addSubview:_tagsView];
        [_tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.offset = AdaptedHeight(80);
            make.bottom.offset = 0;
        }];
    }
    return _tagsView;
}


- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.offset =AdaptedWidth(15);
                                     make.right.bottom.offset =0;
                                     make.height.offset = 0.5;
                                 }];
    }
    return _line;
}

@end
