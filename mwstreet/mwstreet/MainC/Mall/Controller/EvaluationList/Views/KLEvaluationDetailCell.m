//
//  KLEvaluationDetailCell.m
//  mwstreet
//
//  Created by 科pro on 2019/3/12.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLEvaluationDetailCell.h"

@implementation KLEvaluationDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self imgV];
    [self nameLab];
    [self desLab];
    [self starView];
    [self contentLab];
    [self starView];
}


- (void)setContentStr:(NSString *)contentStr {
    _contentStr = contentStr;
    self.contentLab.text = contentStr;
    CGSize size = [self.contentLab getLableRectWithMaxWidth:MainWidth-AdaptedWidth(24)];
    self.contentLab.mj_h = size.height;
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset  = AdaptedWidth(12);
        make.top.mas_equalTo(self.desLab.mas_bottom).offset = AdaptedHeight(11);
        make.bottom.offset = AdaptedHeight(-14);
        make.right.offset  = AdaptedWidth(-12);
    }];
}






- (UIImageView *)imgV {
    if (!_imgV){
        _imgV = [UIImageView zj_imageViewWithImage:@"touxiang"
                                         SuperView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.left.offset = AdaptedWidth(10);
                                           make.width.height.offset = AdaptedHeight(31);
                                           make.top.offset = AdaptedHeight(10);
                                       }];
    }
    return _imgV;
}

- (UILabel *)nameLab {
    if (!_nameLab){
        _nameLab = [UILabel zj_labelWithFontSize:14
                                           lines:1
                                            text:@"蝴蝶花"
                                       textColor:RGBSigle(51)
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.mas_equalTo(self.imgV.mas_right).offset = AdaptedWidth(21);
                                         make.height.offset = AdaptedHeight(15);
                                         make.centerY.mas_equalTo(self.imgV);
                                         make.right.offset  = AdaptedWidth(-110);
                                     }];
    }
    return _nameLab;
}

- (UILabel *)desLab {
    if (!_desLab){
        _desLab = [UILabel zj_labelWithFontSize:12
                                          lines:1
                                           text:@"2018-12-15     201人浏览    25人点赞 "
                                      textColor:TextColor
                                      superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.left.offset   = AdaptedWidth(12);
                                        make.right.offset  = AdaptedWidth(-12);
                                        make.height.offset = AdaptedHeight(15);
                                        make.top.mas_equalTo(self.imgV.mas_bottom).offset = AdaptedHeight(15);
                                    }];
    }
    return _desLab;
}

- (UILabel *)contentLab {
    if (!_contentLab){
        _contentLab = [UILabel zj_labelWithFontSize:12
                                              lines:0
                                               text:nil
                                          textColor:TitleColor
                                          superView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.left.offset  = AdaptedWidth(12);
                                            make.top.mas_equalTo(self.desLab.mas_bottom).offset = AdaptedHeight(11);
                                            make.bottom.offset = AdaptedHeight(-14);
                                            make.right.offset  = AdaptedWidth(-12);
                                        }];
        _contentLab.lineSpace = 5;
    }
    return _contentLab;
}


- (SYStarRatingView *)starView {
    if (!_starView){
        _starView = [[SYStarRatingView alloc]initWithFrame:CGRectMake(MainWidth-AdaptedWidth(85), AdaptedHeight(20), AdaptedWidth(75), AdaptedHeight(12))];
        _starView.foregroundImageName = @"xin_h";
        _starView.backgroundImageName = @"xin";
        _starView.isMove = NO;
        _starView.foregroundViewColor = MainColor;
        [self.contentView addSubview:_starView];
    }
    return _starView;
}


@end



@implementation KLEvaluationDetailBannerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.carouselView];
        [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 10, 10, 15));
        }];
    }
    return self;
}


//***  轮播图控件  **/
- (SDCycleScrollView *)carouselView {
    
    if (!_carouselView){
        _carouselView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:nil];
        _carouselView.tag = 20;
        _carouselView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _carouselView.autoScrollTimeInterval = 4;
        _carouselView.autoScroll = NO;
        _carouselView.currentPageDotColor = MainColor;
        _carouselView.pageDotColor =[UIColor whiteColor];
    }
    return _carouselView;
}


@end






@implementation KLEvaluationDetailGoodsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
       
        [self configUI];
    }
    return self;
}


- (void)configUI {

    [self goodsImgV];
    [self titleLab];
    [self priceLab];
}

- (void)setGoodName:(NSString *)goodName {
    _goodName = goodName;
    self.titleLab.text = goodName;
    CGSize size = [self.titleLab getLableRectWithMaxWidth:MainWidth-AdaptedWidth(129)];
    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset   = AdaptedWidth(117);
        make.right.offset  = AdaptedWidth(-12);
        make.height.offset = size.height;
        make.top.offset    = AdaptedHeight(24);
    }];
}


- (UIImageView *)goodsImgV {
    if (!_goodsImgV){
        _goodsImgV = [UIImageView zj_imageViewWithImage:@"pic_6"
                                              SuperView:self.contentView
                                            constraints:^(MASConstraintMaker *make) {
                                                make.centerY.offset = 0;
                                                make.height.width.offset =AdaptedHeight(85);
                                                make.left.offset =AdaptedHeight(12);
                                            }];
        _goodsImgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsImgV;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:2
                                             text:nil
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset   = AdaptedWidth(117);
                                          make.right.offset  = AdaptedWidth(-12);
                                          make.height.offset = AdaptedHeight(15);
                                          make.top.offset    = AdaptedHeight(20);
                                      }];
        _titleLab.lineSpace = 5;
    }
    return _titleLab;
}

- (UILabel *)priceLab {
    if (!_priceLab){
        _priceLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:nil
                                        textColor:RedColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.right.left.mas_equalTo(self.titleLab);
                                          make.bottom.offset = AdaptedHeight(-20);
                                          make.height.offset = AdaptedHeight(15);
                                      }];
    }
    return _priceLab;
}



@end




@interface KLEvaluationDetailListCell ()

@property (nonatomic, strong) UIView * line;

@end

@implementation KLEvaluationDetailListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self configUI];
    }
    return self;
}


- (void)configUI {
    [self imgV];
    [self nameLab];
    [self timeLab];
    [self contentLab];
    [self praiseBtn];
    [self line];
}

- (void)setContentStr:(NSString *)contentStr {
    
    _contentStr = contentStr;
    self.contentLab.text = contentStr;
    CGSize size = [self.contentLab getLableRectWithMaxWidth:MainWidth-AdaptedWidth(86)];
    self.contentLab.mj_h = size.height;
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(55);
        make.right.offset = AdaptedWidth(-31);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset =AdaptedHeight(14);
        make.bottom.offset = AdaptedHeight(-20);
    }];
}


- (UIImageView *)imgV {
    if (!_imgV){
        _imgV = [UIImageView zj_imageViewWithImage:@"touxiang"
                                         SuperView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.left.offset =AdaptedWidth(10);
                                           make.height.width.offset = AdaptedHeight(31);
                                           make.top.offset =AdaptedHeight(10);
                                       }];
    }
    return _imgV;
}

- (UILabel *)nameLab {
    if (!_nameLab){
        _nameLab = [UILabel zj_labelWithFontSize:14
                                           lines:1
                                            text:@"蝴蝶花"
                                       textColor:RGBSigle(51)
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.offset = AdaptedWidth(56);
                                         make.height.offset = AdaptedHeight(15);
                                         make.centerY.mas_equalTo(self.imgV);
                                         make.right.offset  = AdaptedWidth(-110);
                                     }];
    }
    return _nameLab;
}

- (UILabel *)timeLab {
    if (!_timeLab){
        _timeLab = [UILabel zj_labelWithFontSize:12
                                          lines:1
                                           text:@"2018-12-15"
                                      textColor:TextColor
                                      superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.left.offset   = AdaptedWidth(56);
                                        make.right.offset  = AdaptedWidth(-12);
                                        make.height.offset = AdaptedHeight(15);
                                        make.top.mas_equalTo(self.imgV.mas_bottom).offset = AdaptedHeight(15);
                                    }];
    }
    return _timeLab;
}

- (UIButton *)praiseBtn {
    if (!_praiseBtn){
        @weakify(self)
        _praiseBtn = [UIButton createBtnTitle:@""
                                   titleColor:TextColor
                                         font:kFont_12
                                    imageName:@"zan"
                               backgrounColor:[UIColor clearColor]
                          SSImagePositionType:SSImagePositionTypeLeft
                                      spacing:4
                                       action:^(UIButton * _Nonnull button) {
                                           @strongify(self)
                                           self.secondaryPraiseBlock ? self.secondaryPraiseBlock(button, self.indexPath) : nil;
                                       }];
        [self.contentView addSubview:_praiseBtn];
        [_praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset  = AdaptedWidth(-6);
            make.height.offset = AdaptedHeight(15);
            make.centerY.mas_equalTo(self.nameLab);
            make.width.offset  = AdaptedWidth(65);
        }];
    }
    return _praiseBtn;
}


- (UILabel *)contentLab {
    if (!_contentLab){
        _contentLab = [UILabel zj_labelWithFontSize:12
                                              lines:0
                                               text:nil
                                          textColor:TitleColor
                                          superView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.left.offset =AdaptedWidth(55);
                                            make.right.offset = AdaptedWidth(-31);
                                            make.top.mas_equalTo(self.timeLab.mas_bottom).offset =AdaptedHeight(14);
                                            make.bottom.offset = AdaptedHeight(-20);
                                        }];
        _contentLab.lineSpace = 5;
    }
    return _contentLab;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.right.bottom.offset = 0;
                                     make.height.offset = 0.5f;
                                     make.left.offset = 15.0f;
                                 }];
    }
    return _line;
}


@end
