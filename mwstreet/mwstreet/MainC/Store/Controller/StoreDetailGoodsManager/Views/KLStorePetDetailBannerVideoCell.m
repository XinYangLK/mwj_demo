//
//  KLStorePetDetailBannerVideoCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/19.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStorePetDetailBannerVideoCell.h"

#import <ZFPlayer/UIImageView+ZFCache.h>

@interface KLStorePetDetailBannerVideoCell ()

@property (nonatomic, weak) id<ZFTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath * indexPath;     //点击当前cell
@property (nonatomic, strong) UIImageView *coverImageView; //视频占位图
@end

@implementation KLStorePetDetailBannerVideoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self video];
    }
    return self;
}

- (TSVideoPlayback *)video {
    if (!_video){
        _video =[[TSVideoPlayback alloc] initWithFrame:CGRectMake(0, 0, MainWidth, AdaptedHeight(282))];
        @weakify(self)        
        _video.playerBlock = ^(UIButton *sender) { //播放d按钮点击事件
            @strongify(self)
            if ([self.delegate respondsToSelector:@selector(zf_playTheVideoAtIndexPath:)]) {
                [self.delegate zf_playTheVideoAtIndexPath:self.indexPath];
            }
        };
        _video.plaerPauseBlock = ^(BOOL pause) { //轮播图滑动是否滑出视频事件
            @strongify(self)
            self.plaerCellPauseBlock ? self.plaerCellPauseBlock(pause) : nil;
        };
        [self.contentView addSubview:_video];
    }
    return _video;
}

- (void)setDelegate:(id<ZFTableViewCellDelegate>)delegate withIndexPath:(NSIndexPath *)indexPath {
    self.delegate = delegate;
    self.indexPath = indexPath;
}


@end



#pragma mark - 宠物名称，价格
@implementation KLPetNamePriceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    [self titleLab];
    [self priceLab];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:16
                                        textColor:RGBSigle(0)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(12);
                                          make.width.offset =MainWidth/2-AdaptedWidth(20);
                                          make.centerY.offset = 0;
                                          make.height.offset = AdaptedHeight(15);
                                      }];
    }
    return _titleLab;
}

- (UILabel *)priceLab {
    if (!_priceLab){
        _priceLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RedColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.right.offset =AdaptedWidth(-12);
                                          make.width.centerY.height.mas_equalTo(self.titleLab);
                                      }];
    }
    return _priceLab;
}


@end



#pragma mark - 宠物信息

@implementation KLPetDetailMsgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    [self titleLab];
    [self textLab];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:TextColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(12);
                                          make.width.offset = AdaptedWidth(50);
                                          make.centerY.offset = 0;
                                          make.height.offset = AdaptedHeight(15);
                                      }];
    }
    return _titleLab;
}

- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel zj_labelWithFontSize:14
                                       textColor:TextColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(8);
                                         make.right.offset = AdaptedWidth(-12);
                                         make.centerY.offset = 0;
                                         make.height.offset = AdaptedHeight(15);
                                     }];
        _textLab.numberOfLines = 0;
    }
    return _textLab;
}



@end



#pragma mark - 店铺进入

@implementation KLPetStoreCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    
    [self storeImg];
    [self titleLab];
    [self starView];
    [self scoreLab];
    [self distanceLab];
    [self pushBtn];
    
}

- (UIImageView *)storeImg {
    if (!_storeImg){
        _storeImg = [UIImageView zj_imageViewWithImage:nil
                                             SuperView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.offset =AdaptedWidth(12);
                                               make.centerY.offset = 0;
                                               make.width.offset =AdaptedWidth(90);
                                               make.height.offset =AdaptedHeight(58);
                                           }];
    }
    return _storeImg;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.storeImg.mas_right).offset =AdaptedWidth(24);
                                          make.right.offset =AdaptedWidth(-60);
                                          make.height.offset =AdaptedHeight(15);
                                          make.top.mas_equalTo(self.storeImg);
                                      }];
    }
    return _titleLab;
}

- (SYStarRatingView *)starView {
    if (!_starView){
        CGFloat x = AdaptedWidth(126);
        CGFloat y = AdaptedHeight(36);
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

- (UILabel *)scoreLab {
    if (!_scoreLab){
        _scoreLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:@"5.0"
                                        textColor:RGBSigle(89)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.starView.mas_right).offset =AdaptedWidth(8);
                                          make.centerY.height.mas_equalTo(self.starView);
                                          make.width.offset =AdaptedWidth(30);
                                      }];
    }
    return _scoreLab;
}

- (UIButton *)pushBtn {
    if (!_pushBtn){
        klWeakSelf;
        _pushBtn = [UIButton zj_buttonWithTitle:@"进入店铺"
                                     titleColor:RGBSigle(255)
                                       norImage:nil
                                  selectedImage:nil
                                      backColor:MainColor
                                       fontSize:12
                                         isBold:NO
                                   cornerRadius:5
                                        supView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.right.offset =AdaptedWidth(-12);
                                        make.centerY.offset = 0;
                                        make.height.offset =AdaptedHeight(24);
                                        make.width.offset =AdaptedWidth(62);
                                    } touchUp:^(id sender) {
                                        
                                        weakSelf.pushStoreBlock ? weakSelf.pushStoreBlock(sender) : nil;
                                    }];
    }
    return _pushBtn;
}

- (UILabel *)distanceLab {
    if (!_distanceLab){
        _distanceLab = [UILabel zj_labelWithFontSize:10
                                           textColor:TextColor
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.bottom.mas_equalTo(self.storeImg);
                                             make.right.offset =AdaptedWidth(-80);
                                             make.height.offset =AdaptedHeight(13);
                                             make.left.mas_equalTo(self.titleLab);
                                         }];
    }
    return _distanceLab;
}

@end





#pragma mark - 猜你喜欢宠物列表

@interface KLPetLikeListCell ()

//***  商品图片  **/
@property (nonatomic, strong) UIImageView *imageV;
//***  商品名称  **/
@property (nonatomic, strong) UILabel * goodsNameLab;
//***  商品描述  **/
@property (nonatomic, strong) UILabel * goodsDesLab;
//***  商品价格  **/
@property (nonatomic, strong) UILabel * goodsPriceLab;
@end

@implementation KLPetLikeListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self confingerUI];
    }
    return self;
}

- (void)confingerUI {
    [self imageV];
    [self goodsNameLab];
    [self goodsDesLab];
    [self goodsPriceLab];
}


- (void)setGoodsImg:(NSString *)goodsImg {
    _goodsImg =goodsImg;
    self.imageV.image = [UIImage imageNamed:goodsImg];
}

- (void)setGoodsName:(NSString *)goodsName {
    _goodsName =goodsName;
    self.goodsNameLab.text =goodsName;
}

- (void)setGoodsDes:(NSString *)goodsDes {
    _goodsDes = goodsDes;
    _goodsDesLab.text =goodsDes;
}

- (void)setGoodsPrice:(NSString *)goodsPrice {
    _goodsPrice = goodsPrice;
    _goodsPriceLab.text =[NSString stringWithFormat:@"￥%@",goodsPrice];
}


-(UIImageView *)imageV {
    if (!_imageV){
        _imageV = [UIImageView zj_imageViewWithImage:nil
                                           SuperView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.left.offset   = AdaptedWidth(12);
                                             make.top.offset    = AdaptedHeight(12);
                                             make.bottom.offset = AdaptedHeight(-12);
                                             make.width.offset  = AdaptedWidth(120);
                                         }];
    }
    return _imageV;
}

- (UILabel *)goodsNameLab {
    if (!_goodsNameLab){
        _goodsNameLab = [UILabel zj_labelWithFontSize:14
                                                lines:1
                                                 text:nil
                                            textColor:RGBSigle(51)
                                            superView:self.contentView
                                          constraints:^(MASConstraintMaker *make) {
                                              make.left.mas_equalTo(self.imageV.mas_right).offset = AdaptedWidth(20);
                                              make.right.offset = AdaptedWidth(-12);
                                              make.height.offset =AdaptedHeight(15);
                                              make.top.mas_equalTo(self.imageV.mas_top).offset =AdaptedHeight(5);
                                          }];
    }
    return _goodsNameLab;
}

- (UILabel *)goodsDesLab {
    if (!_goodsDesLab){
        _goodsDesLab = [UILabel zj_labelWithFontSize:10
                                               lines:1
                                                text:nil
                                           textColor:TextColor
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             
                                             make.top.mas_equalTo(self.goodsNameLab.mas_bottom).offset = AdaptedHeight(10);
                                             make.height.left.right.mas_equalTo(self.goodsNameLab);
                                         }];
    }
    return _goodsDesLab;
}



- (UILabel *)goodsPriceLab {
    if (!_goodsPriceLab){
        _goodsPriceLab = [UILabel zj_labelWithFontSize:14
                                                 lines:1
                                                  text:nil
                                             textColor:RedColor
                                             superView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.bottom.mas_equalTo(self.imageV.mas_bottom).offset =AdaptedHeight(-5);
                                               make.height.left.right.mas_equalTo(self.goodsNameLab);
                                           }];
    }
    return _goodsPriceLab;
}




@end
