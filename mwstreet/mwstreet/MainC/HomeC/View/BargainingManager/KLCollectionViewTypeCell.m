//
//  KLCollectionViewTypeCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/14.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLCollectionViewTypeCell.h"

@interface KLCollectionViewTypeCell ()
//***  商品图片  **/
@property (nonatomic, strong) UIImageView * imgView;
//***  商品名称  **/
@property (nonatomic, strong) UILabel     * titleLab;
//***  商品价格  **/
@property (nonatomic, strong) UILabel     * priceLab;
//***  商品原始价格  **/
@property (nonatomic, strong) UILabel     * oldPriceLab;
//***  删除线  **/
@property (nonatomic, strong) UIView      * line;
//***  描述  **/
@property (nonatomic, strong) UILabel     * desLab;
//***  开团\砍价按钮  **/
@property (nonatomic, strong) UIButton    * operationBtn;

@end

@implementation KLCollectionViewTypeCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self.contentView setLayerCornerRadius:5 borderWidth:1 borderColor:LineColor];

        [self configerUI];
    }
    return self;
}


- (void)setGoodsTitle:(NSString *)goodsTitle {
    _goodsTitle = goodsTitle;
    self.titleLab.text = _goodsTitle;
    CGFloat width =(MainWidth -AdaptedWidth(30))/2 - AdaptedWidth(10);
    CGSize size = [self.titleLab getLableRectWithMaxWidth:width];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(5);
        make.top.mas_equalTo(self.imgView.mas_bottom).offset =AdaptedHeight(16);
        make.right.offset =AdaptedWidth(-5);
        make.height.offset = size.height;
    }];
}
- (void)setGoodsPrice:(NSString *)goodsPrice {
    _goodsPrice = goodsPrice;
    self.priceLab.text = _goodsPrice;
}
- (void)setGoodsOldPrice:(NSString *)goodsOldPrice{
    _goodsOldPrice = goodsOldPrice;
    self.oldPriceLab.text =_goodsOldPrice;
    CGFloat width =[UILabel getWidthWithTitle:_goodsOldPrice font:self.oldPriceLab.font];
    [self.oldPriceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLab.mas_right).offset =AdaptedWidth(8);
        make.width.offset = width;
        make.centerY.mas_equalTo(self.priceLab);
        make.height.offset = AdaptedHeight(15);
    }];
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.oldPriceLab);
        make.height.offset = 1;
        make.width.offset  = width + AdaptedWidth(5);
    }];
}
- (void)setGoodsDes:(NSString *)goodsDes {
    _goodsDes = goodsDes;
    self.desLab.text = _goodsDes;
}
- (void)setGoodsImg:(NSString *)goodsImg {
    _goodsImg = goodsImg;
    self.imgView.image =[UIImage imageNamed:_goodsImg];
}
- (void)setGoodsBtnTitle:(NSString *)goodsBtnTitle {
    _goodsBtnTitle = goodsBtnTitle;
    [self.operationBtn setTitle:goodsBtnTitle forState:UIControlStateNormal];
}



#pragma mark - lazy -- UI
- (void)configerUI {
    
    [self imgView];
    [self titleLab];
    [self priceLab];
    [self oldPriceLab];
    [self line];
    [self operationBtn];
    [self desLab];

}

- (UIImageView *)imgView {
    if (!_imgView){
        _imgView = [UIImageView zj_imageViewWithImage:self.goodsImg
                                            SuperView:self.contentView
                                          contentMode:UIViewContentModeScaleAspectFit
                                               isClip:NO
                                          constraints:^(MASConstraintMaker *make) {
                                              make.right.offset =AdaptedWidth(-20);
                                              make.top.offset =AdaptedHeight(16);
                                              make.height.offset =AdaptedHeight(105);
                                              make.left.offset =AdaptedWidth(20);
                                          }];
    }
    return _imgView;
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:2
                                             text:self.goodsTitle
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(5);
                                          make.top.mas_equalTo(self.imgView.mas_bottom).offset =AdaptedHeight(16);
                                          make.right.offset =AdaptedWidth(-5);
                                          make.height.offset =AdaptedHeight(15);
                                      }];
    }
    return _titleLab;
}

- (UILabel *)priceLab {
    if (!_priceLab){
        CGFloat width =(MainWidth -AdaptedWidth(30))/2 - AdaptedWidth(18);
        _priceLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RedColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset   = AdaptedWidth(5);
                                          make.height.offset = AdaptedHeight(15);
                                          make.width.offset  = width/2;
                                          make.bottom.offset = AdaptedHeight(-49);
                                      }];
    }
    return _priceLab;
}


- (UILabel *)oldPriceLab {
    if (!_oldPriceLab){
        _oldPriceLab = [UILabel zj_labelWithFontSize:10
                                           textColor:TextColor
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.left.mas_equalTo(self.priceLab.mas_right).offset =AdaptedWidth(8);
                                             make.right.offset =AdaptedWidth(-5);
                                             make.centerY.mas_equalTo(self.priceLab);
                                             make.height.offset = AdaptedHeight(15);
                                         }];
    }
    return _oldPriceLab;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.centerY.centerX.mas_equalTo(self.oldPriceLab);
                                     make.height.offset =1;
                                     make.width.offset = AdaptedWidth(50);
                                 }];
    }
    return _line;
}

- (UILabel *)desLab {
    if (!_desLab){
        _desLab = [UILabel zj_labelWithFontSize:10
                                      textColor:TextColor
                                      superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.left.offset =AdaptedWidth(5);
                                        make.bottom.offset = AdaptedHeight(-16);
                                        make.right.mas_equalTo(self.operationBtn.mas_left).offset =AdaptedWidth(-5);
                                    }];
    }
    return _desLab;
}

- (UIButton *)operationBtn {
    if (!_operationBtn){
        _operationBtn = [UIButton zj_buttonWithTitle:self.goodsBtnTitle
                                          titleColor:[UIColor whiteColor]
                                            norImage:nil
                                       selectedImage:nil
                                           backColor:[UIColor clearColor]
                                            fontSize:12
                                              isBold:NO
                                        cornerRadius:AdaptedWidth(14)
                                             supView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.right.offset =AdaptedWidth(-5);
                                             make.height.offset =AdaptedHeight(28);
                                             make.width.offset = AdaptedWidth(78);
                                             make.bottom.offset =AdaptedHeight(-10);
                                         } touchUp:^(id sender) {
                                             
                                             KLLog(@"-----砍价9折购-----");
                                         }];
        [_operationBtn setBackgroundImage:[UIImage imageWithColor:RedColor] forState:UIControlStateNormal];
    }
    return _operationBtn;
    
}




@end
