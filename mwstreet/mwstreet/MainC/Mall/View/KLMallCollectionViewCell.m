//
//  KLMallCollectionViewCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLMallCollectionViewCell.h"
@interface KLMallCollectionViewCell ()
//***  商品图片  **/
@property (nonatomic, strong) UIImageView * goodsImg;
//***  商品名称  **/
@property (nonatomic, strong) UILabel     * goodsLab;
//***  商品价格  **/
@property (nonatomic, strong) UILabel     * priceLab;


@end
@implementation KLMallCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self.contentView setLayerCornerRadius:5 borderWidth:1 borderColor:LineColor];
        [self configerUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size =[self.goodsLab getLableRectWithMaxWidth:self.contentView.bounds.size.width-AdaptedWidth(6)];
    [self.goodsLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImg.mas_bottom).offset =AdaptedHeight(15);
        make.left.offset =AdaptedWidth(3);
        make.right.offset =AdaptedWidth(-3);
        make.height.offset = size.height +AdaptedHeight(5);
    }];
    
    CGFloat w = ((MainWidth -AdaptedWidth(30))/2 -AdaptedWidth(35))/2;
    CGFloat pw = [UILabel getWidthWithTitle:self.oldPriceLab.text font:self.oldPriceLab.font];
    [self.oldPriceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (self.addCarBtn.hidden == YES) {
            make.right.offset =AdaptedWidth(-10);
        }else{
            make.right.mas_equalTo(self.addCarBtn.mas_left).offset =AdaptedWidth(-10);
        }
        make.centerY.mas_equalTo(self.priceLab);
        make.width.offset = pw > w ? pw : w;
        make.height.offset =AdaptedHeight(15);
    }];
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.oldPriceLab);
        make.height.offset =1;
        make.width.offset = pw + 5;
    }];
    
}

-(void)setGoodName:(NSString *)goodName{
    _goodName = goodName;
    self.goodsLab.text = _goodName;
}


- (void)configerUI {
    [self.contentView addSubview:self.goodsImg];
    [self.contentView addSubview:self.goodsLab];
    [self.contentView addSubview:self.priceLab];
    [self.contentView addSubview:self.addCarBtn];
    [self.contentView addSubview:self.oldPriceLab];
    [self.contentView addSubview:self.line];

    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.top.offset =AdaptedHeight(10);
        make.right.offset =AdaptedWidth(-10);
        make.height.offset =AdaptedHeight(152);
    }];
    [self.goodsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImg.mas_bottom).offset =AdaptedHeight(15);
        make.left.offset =AdaptedWidth(3);
        make.right.offset =AdaptedWidth(-3);
        make.height.offset =AdaptedHeight(15);
    }];
    
    CGFloat w = ((MainWidth -AdaptedWidth(30))/2 -AdaptedWidth(35))/2;
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset =AdaptedHeight(-16);
        make.left.offset =AdaptedWidth(5);
        make.width.offset = w;
        make.height.offset =AdaptedHeight(15);
    }];
    [self.addCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLab);
        make.height.width.offset =AdaptedHeight(17);
        make.right.offset =AdaptedWidth(-12);
    }];
    [self.oldPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.addCarBtn.hidden == YES) {
            make.right.offset =AdaptedWidth(-10);
        }else{
            make.right.mas_equalTo(self.addCarBtn.mas_left).offset =AdaptedWidth(-10);
        }
        make.centerY.mas_equalTo(self.priceLab);
        make.width.offset = w;
        make.height.offset =AdaptedHeight(15);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.oldPriceLab);
        make.height.offset =1;
        make.width.offset = w + 5;
    }];

}


- (UIImageView *)goodsImg {
    if (!_goodsImg){
        _goodsImg = [[UIImageView alloc]init];
        NSString * str =[NSString stringWithFormat:@"pic_%u",10 + arc4random()%7];
        _goodsImg.image =[UIImage imageNamed:str];
    }
    return _goodsImg;
}

- (UILabel *)goodsLab {
    if (!_goodsLab){
        _goodsLab = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
        _goodsLab.numberOfLines = 2;
    }
    return _goodsLab;
}

- (UILabel *)priceLab {
    if (!_priceLab){
        _priceLab = [UILabel createLabelTextColor:RedColor font:kFont_14];
        _priceLab.text =[NSString stringWithFormat:@"￥%u", arc4random()%1000];
    }
    return _priceLab;
}
- (UIButton *)addCarBtn {
    if (!_addCarBtn){
        _addCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCarBtn setImage:[UIImage imageNamed:@"gouwuche_h"] forState:UIControlStateNormal];
        [_addCarBtn addTarget:self action:@selector(addshoppingCarChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCarBtn;
}

- (UILabel *)oldPriceLab {
    if (!_oldPriceLab){
        _oldPriceLab = [UILabel createLabelTextColor:TextColor font:kFont_14];
        _oldPriceLab.text =[NSString stringWithFormat:@"￥%u", arc4random()%1000];
        _oldPriceLab.textAlignment =NSTextAlignmentCenter;
    }
    return _oldPriceLab;
}
- (UIView *)line {
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor =TextColor;
    }
    return _line;
}

//***  加入购物车回调  **/
- (void)addshoppingCarChick:(UIButton *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAddShoppingCarBtnChick:)]) {
        [self.delegate didAddShoppingCarBtnChick:self.indexPath];
    }
    
}

@end






@interface KLMallTableViewCell()
//***  商品图片  **/
@property (nonatomic, strong) UIImageView * goodsImg;
//***  商品名称  **/
@property (nonatomic, strong) UILabel     * goodsLab;
//***  商品价格  **/
@property (nonatomic, strong) UILabel     * priceLab;
//***  商品旧价格  **/
//@property (nonatomic, strong) UILabel     * oldPriceLab;
////***  加入购物车  **/
//@property (nonatomic, strong) UIButton   * addCarBtn;
//***  底部分割线  **/
@property (nonatomic, strong) UIView     * lineView;

@end

@implementation KLMallTableViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configerUI];
    }
    return self;
}



-(void)setGoodName:(NSString *)goodName{
    _goodName = goodName;
    self.goodsLab.text = _goodName;
    CGSize size =[self.goodsLab getLableRectWithMaxWidth:MainWidth-AdaptedWidth(154)];
    [self.goodsLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImg.mas_top);
        make.left.mas_equalTo(self.goodsImg.mas_right).offset =AdaptedWidth(30);
        make.right.offset  = AdaptedWidth(-12);
        make.height.offset = size.height + AdaptedHeight(5);
    }];
}

- (void)setOldPrice:(NSString *)oldPrice {
    _oldPrice = oldPrice;
    self.oldPriceLab.text = oldPrice;
    CGFloat w =   MainWidth - AdaptedWidth(212);
    CGFloat pw = [UILabel getWidthWithTitle:self.oldPriceLab.text font:self.oldPriceLab.font];
    [self.oldPriceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.height.mas_equalTo(self.priceLab);
        make.width.offset = pw > w ? pw : w;
        make.bottom.mas_equalTo(self.goodsImg.mas_bottom);
    }];
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.mas_equalTo(self.oldPriceLab);
        make.height.offset =1;
        make.width.offset = pw + 5;
    }];
}


- (void)configerUI {
    
    [self goodsImg];
    [self goodsLab];
    [self priceLab];
    [self addCarBtn];
    [self oldPriceLab];
    [self line];
    [self lineView];
}


- (UIImageView *)goodsImg {
    if (!_goodsImg){
        NSString * str =[NSString stringWithFormat:@"pic_%u",10 + arc4random()%7];

        _goodsImg = [UIImageView zj_imageViewWithImage:str
                                             SuperView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.offset =AdaptedWidth(12);
                                               make.top.offset =AdaptedHeight(20);
                                               make.bottom.offset =AdaptedHeight(-20);
                                               make.width.offset =AdaptedWidth(110);
                                           }];
    }
    return _goodsImg;
}

- (UILabel *)goodsLab {
    if (!_goodsLab){
        _goodsLab = [UILabel  zj_labelWithFontSize:14
                                         textColor:RGBSigle(51)
                                         superView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.top.mas_equalTo(self.goodsImg.mas_top);
                                           make.right.offset =AdaptedWidth(-12);
                                           make.height.offset = AdaptedHeight(15);
                                           make.left.mas_equalTo(self.goodsImg.mas_right).offset =AdaptedWidth(20);
                                       }];
        _goodsLab.numberOfLines = 2;
    }
    return _goodsLab;
}

- (UILabel *)priceLab {
    if (!_priceLab){
        _priceLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RedColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.goodsLab);
                                          make.bottom.offset = AdaptedHeight(-45);
                                          make.height.offset =AdaptedHeight(15);
                                          make.right.offset =AdaptedWidth(-70);
                                      }];
        _priceLab.text =[NSString stringWithFormat:@"￥%u", arc4random()%1000];
    }
    return _priceLab;
}
- (UIButton *)addCarBtn {
    if (!_addCarBtn){
        klWeakSelf;
        _addCarBtn = [UIButton zj_buttonWithNorImage:@"gouwuche_h"
                                        cornerRadius:0
                                             supView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.right.offset =AdaptedWidth(-20);
                                             make.height.width.offset =AdaptedHeight(40);
                                             make.bottom.offset = 0;
                                         } touchUp:^(id sender) {
                                             if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didAddShoppingCarBtnChick:)]) {
                                                 [weakSelf.delegate didAddShoppingCarBtnChick:weakSelf.indexPath];
                                             }
                                         }];
    }
    return _addCarBtn;
}

- (UILabel *)oldPriceLab {
    if (!_oldPriceLab){
        _oldPriceLab = [UILabel zj_labelWithFontSize:12
                                           textColor:TextColor
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.left.height.mas_equalTo(self.priceLab);
                                             make.width.offset =AdaptedWidth(80);
                                             make.bottom.mas_equalTo(self.goodsImg.mas_bottom);
                                         }];
    }
    return _oldPriceLab;
}
- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:TextColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.centerY.centerX.mas_equalTo(self.oldPriceLab);
                                     make.height.offset = 1;
                                     make.width.offset = AdaptedWidth(80);
                                 }];
    }
    return _line;
}

- (UIView *)lineView {
    if (!_lineView){
        _lineView = [UIView zj_viewWithBackColor:LineColor
                                         supView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.right.bottom.offset =0;
                                         make.height.offset =0.5f;
                                     }];
    }
    return _lineView;
}


@end
