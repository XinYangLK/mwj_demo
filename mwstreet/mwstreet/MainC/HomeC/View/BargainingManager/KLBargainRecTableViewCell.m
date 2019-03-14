//
//  KLBargainRecTableViewCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBargainRecTableViewCell.h"

@interface KLBargainRecTableViewCell ()

//***  商品图片  **/
@property (nonatomic, strong) UIImageView * goodsImg;
//***  商品名称  **/
@property (nonatomic, strong) UILabel     * goodsTitle;
//***  商品价格  **/
@property (nonatomic, strong) UILabel     * goodsPrice;
//***  商品描述  **/
@property (nonatomic, strong) UILabel     * goodsDescribe;
//***  开团\砍价按钮  **/
@property (nonatomic, strong) UIButton    * operationBtn;

@end

@implementation KLBargainRecTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         [self configerUI];
    }
    return self;
}

- (void)setImgView:(NSString *)imgView {
    _imgView = imgView;
    self.goodsImg.image = [UIImage imageNamed:_imgView];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.goodsTitle.text = _title;
    CGSize size = [self.goodsTitle getLableRectWithMaxWidth:MainWidth -AdaptedWidth(187)];
    [self.goodsTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset   = AdaptedWidth(160);
        make.right.offset  = AdaptedWidth(-27);
        make.top.offset    = AdaptedHeight(20);
        make.height.offset = size.height;
    }];
}

- (void)setPrice:(NSString *)price {
    _price = price;
    self.goodsPrice.text =_price;
}

- (void)setGoodsDes:(NSString *)goodsDes{
    _goodsDes = goodsDes;
    self.goodsDescribe.text = _goodsDes;
}


- (void)setBtnTitle:(NSString *)btnTitle {
    _btnTitle = btnTitle;
    [self.operationBtn setTitle:_btnTitle forState:UIControlStateNormal];
}



#pragma mark - lazy UI
- (void)configerUI {
    [self goodsImg];
    [self goodsTitle];
    [self goodsPrice];
    [self operationBtn];
    [self goodsDescribe];
}


- (UIImageView *)goodsImg {
    if (!_goodsImg){
        _goodsImg = [UIImageView zj_imageViewWithImage:self.imgView
                                             SuperView:self.contentView
                                           contentMode:UIViewContentModeScaleAspectFit
                                                isClip:YES
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.offset = AdaptedWidth(19);
                                               make.centerY.offset =0;
                                               make.width.offset =AdaptedWidth(108);
                                               make.height.offset =AdaptedHeight(95);
                                           }];
    }
    return _goodsImg;
}

- (UILabel *)goodsTitle {
    if (!_goodsTitle){
        _goodsTitle = [UILabel zj_labelWithFontSize:14
                                              lines:2
                                               text:self.title
                                          textColor:RGBSigle(51)
                                          superView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.left.offset = AdaptedWidth(160);
                                            make.right.offset =AdaptedWidth(-27);
                                            make.top.offset =AdaptedHeight(20);
                                            make.height.offset =AdaptedHeight(15);
                                        }];
    }
    return _goodsTitle;
}

- (UILabel *)goodsPrice {
    if (!_goodsPrice){
        _goodsPrice = [UILabel zj_labelWithFont:AdaptedBOLDSYSFontSize(15)
                                          lines:1
                                           text:self.price
                                      textColor:RedColor
                                      superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.left.offset =AdaptedWidth(166);
                                        make.bottom.offset =AdaptedHeight(-54);
                                        make.height.offset =AdaptedHeight(15);
                                        make.width.offset =AdaptedWidth(98);
                                    }];
    }
    return _goodsPrice;
}

- (UILabel *)goodsDescribe {
    if (!_goodsDescribe){
        _goodsDescribe = [UILabel zj_labelWithFontSize:10
                                                 lines:1
                                                  text:self.goodsDes
                                             textColor:TextColor
                                             superView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.mas_equalTo(self.goodsPrice);
                                               make.height.offset =AdaptedWidth(15);
                                               make.top.mas_equalTo(self.goodsPrice.mas_bottom).offset =AdaptedHeight(16);
                                               make.right.mas_equalTo(self.operationBtn.mas_left).offset =AdaptedWidth(-8);
                                           }];
    }
    return _goodsDescribe;
}

- (UIButton *)operationBtn {
    if (!_operationBtn){
        _operationBtn = [UIButton zj_buttonWithTitle:self.btnTitle
                                          titleColor:[UIColor whiteColor]
                                            norImage:nil
                                       selectedImage:nil
                                           backColor:[UIColor clearColor]
                                            fontSize:12
                                              isBold:NO
                                        cornerRadius:AdaptedWidth(14)
                                             supView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.right.offset =AdaptedWidth(-10);
                                             make.height.offset =AdaptedHeight(28);
                                             make.width.offset = AdaptedWidth(88);
                                             make.bottom.offset =AdaptedHeight(-25);
                                         } touchUp:^(id sender) {
                                             
                                             KLLog(@"-----砍价9折购-----");
                                         }];
        [_operationBtn setBackgroundImage:[UIImage imageWithColor:RedColor] forState:UIControlStateNormal];
    }
    return _operationBtn;
    
}


@end
