//
//  KLMyCollectListCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/14.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyCollectListCell.h"

@interface KLMyCollectListCell ()
//***  商品图片  **/
@property (nonatomic, strong) UIImageView * imgView;
//***  商品名称  **/
@property (nonatomic, strong) UILabel     * titleLab;
//***  商品价格  **/
@property (nonatomic, strong) UILabel     * priceLab;
//***  商品规格  **/
@property (nonatomic, strong) UILabel     * goodSpacLab;

@end

@implementation KLMyCollectListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self confingrUI];
    }
    return self;
}



- (void)setGoodsTitle:(NSString *)goodsTitle {
    _goodsTitle = goodsTitle;
    self.titleLab.text = goodsTitle;
    CGSize size = [self.titleLab getLableRectWithMaxWidth:MainWidth -AdaptedWidth(142)];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(127);
        make.right.offset =AdaptedWidth(-15);
        make.top.offset =AdaptedHeight(18);
        make.height.offset = size.height;
    }];
}
- (void)setGoodsImg:(NSString *)goodsImg{
    _goodsImg = goodsImg;
    self.imgView.image = [UIImage imageNamed:goodsImg];
}
- (void)setGoodsPrice:(NSString *)goodsPrice {
    _goodsPrice = goodsPrice;
    self.priceLab.text = goodsPrice;
}

- (void)setGoodSpac:(NSString *)goodSpac {
    _goodSpac = goodSpac;
    self.goodSpacLab.text = goodSpac;
}


#pragma mark - lazy UI
- (void)confingrUI {
    [self imgView];
    [self titleLab];
    [self goodSpacLab];
    [self priceLab];
    [self findBtn];
}



//***  商品图片  **/
- (UIImageView *)imgView {
    if (!_imgView){
        _imgView = [UIImageView zj_imageViewWithImage:nil SuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.offset =AdaptedWidth(10);
            make.top.offset =AdaptedHeight(10);
            make.width.offset =AdaptedWidth(83);
            make.height.offset =AdaptedHeight(82);
        }];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}
//***  商品名称  **/
-(UILabel *)titleLab {
    if (!_titleLab){
        NSString * title = [NSString getBlankString:self.goodsTitle];
        _titleLab = [UILabel zj_labelWithFontSize:12
                                            lines:2
                                             text:title
                                        textColor:TitleColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.imgView.mas_right).offset =AdaptedWidth(34);
                                          make.right.offset =AdaptedWidth(-15);
                                          make.top.mas_equalTo(self.imgView);
                                          make.height.offset =AdaptedHeight(15);
                                      }];
    }
    return _titleLab;
}

- (UILabel *)goodSpacLab {
    if (!_goodSpacLab){
        _goodSpacLab = [UILabel zj_labelWithFontSize:10
                                        textColor:TextColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.right.mas_equalTo(self.titleLab);
                                          make.height.offset = AdaptedHeight(15);
                                          make.top.mas_equalTo(self.titleLab.mas_bottom).offset =AdaptedHeight(5);
                                      }];
    }
    return _goodSpacLab;
}


//***  商品价格  **/
- (UILabel *)priceLab {
    if (!_priceLab){
        _priceLab = [UILabel zj_labelWithFontSize:15 textColor:RedColor superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab);
            make.width.offset =AdaptedWidth(90);
            make.height.offset =AdaptedHeight(15);
            make.bottom.offset =AdaptedHeight(-18);
        }];
    }
    return _priceLab;
}
//***  找相似按钮  **/
- (UIButton *)findBtn {
    if (!_findBtn){
        _findBtn = [UIButton zj_buttonWithTitle:@"找相似"
                                     titleColor:TextColor
                                       norImage:nil
                                  selectedImage:nil
                                      backColor:[UIColor clearColor]
                                       fontSize:12
                                         isBold:NO
                                    borderWidth:0.5
                                    borderColor:RGBSigle(153)
                                   cornerRadius:AdaptedHeight(10.5)
                                        supView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.right.offset =AdaptedWidth(-29);
                                        make.height.offset =AdaptedHeight(21);
                                        make.width.offset = AdaptedWidth(70);
                                        make.centerY.mas_equalTo(self.priceLab);
                                    } touchUp:^(id sender) {
                                        
                                        KLLog(@"----------");
                                    }];
    }
    return _findBtn;
}


@end
