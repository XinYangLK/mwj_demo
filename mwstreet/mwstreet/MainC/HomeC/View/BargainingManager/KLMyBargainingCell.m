//
//  KLMyBargainingCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/14.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyBargainingCell.h"
@interface KLMyBargainingCell ()

//***  商品图片  **/
@property (nonatomic, strong) UIImageView * goodImgView;
//***  商品标题  **/
@property (nonatomic, strong) UILabel     * titleLab;
//***  砍价Lab  **/
@property (nonatomic, strong) UILabel     * timeLab;
//***  参与人数  **/
@property (nonatomic, strong) UILabel     * desNumberLab;
//***  剩余差价  **/
@property (nonatomic, strong) UILabel     * desPriceLab;
//***  砍价操作btn  **/
@property (nonatomic, strong) UIButton    * operationBtn;

@end
@implementation KLMyBargainingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configerUI];
    }
    return self;
}

- (void)setGoodsImg:(NSString *)goodsImg {
    _goodsImg =goodsImg;
    self.goodImgView.image =[UIImage imageNamed:_goodsImg];
}
- (void)setGoodsTitle:(NSString *)goodsTitle{
    _goodsTitle = goodsTitle;
    self.titleLab.text = _goodsTitle;
    CGSize size = [self.titleLab getLableRectWithMaxWidth:MainWidth -AdaptedWidth(142)];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset   = AdaptedWidth(130);
        make.right.offset  = AdaptedWidth(-11);
        make.top.offset    = AdaptedHeight(18);
        make.height.offset = size.height;
    }];
}

- (void)setGoodsNumDes:(NSString *)goodsNumDes {
    _goodsNumDes = goodsNumDes;
    self.desNumberLab.text = goodsNumDes;
}

- (void)setGoodsPriceDes:(NSString *)goodsPriceDes {
    _goodsPriceDes = goodsPriceDes;
    self.desPriceLab.text = goodsPriceDes;
}



#pragma mark - lazy -- UI
- (void)configerUI {
    
    [self goodImgView];
    [self titleLab];
    [self timeLab];
    [self operationBtn];
    [self desNumberLab];
    [self desPriceLab];
    
}



- (UIImageView *)goodImgView {
    if (!_goodImgView){
        _goodImgView = [UIImageView zj_imageViewWithImage:nil
                                                SuperView:self.contentView
                                              contentMode:UIViewContentModeScaleAspectFit
                                                   isClip:NO
                                              constraints:^(MASConstraintMaker *make) {
                                                  make.left.offset   = AdaptedWidth(10);
                                                  make.top.offset    = AdaptedHeight(12);
                                                  make.width.offset  = AdaptedWidth(85);
                                                  make.height.offset = AdaptedHeight(84);
                                              }];
    }
    return _goodImgView;
}
- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:12
                                            lines:2
                                             text:self.goodsTitle
                                        textColor:TitleColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset   = AdaptedWidth(130);
                                          make.right.offset  = AdaptedWidth(-11);
                                          make.top.offset    = AdaptedHeight(18);
                                          make.height.offset = AdaptedHeight(15);
                                      }];
    }
    return _titleLab;
}

- (UILabel *)timeLab {
    if (!_timeLab){
        _timeLab = [UILabel zj_labelWithFontSize:10
                                           lines:1
                                            text:@"砍价倒计时"
                                       textColor:TextColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.offset   = AdaptedWidth(130);
                                         make.height.offset = AdaptedHeight(15);
                                         make.width.offset  = AdaptedWidth(60);
                                         make.bottom.offset = AdaptedHeight(-56);
                                     }];
    }
    return _timeLab;
}


- (UILabel *)desPriceLab {
    if (!_desPriceLab){
        _desPriceLab = [UILabel zj_labelWithFontSize:12
                                           textColor:RedColor
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.left.offset   = AdaptedWidth(130);
                                             make.height.offset = AdaptedHeight(15);
                                             make.bottom.offset = AdaptedHeight(-35);
                                             make.right.mas_equalTo(self.operationBtn.mas_left).offset = AdaptedWidth(-8);
                                         }];
    }
    return _desPriceLab;
}

- (UILabel *)desNumberLab {
    if (!_desNumberLab){
        _desNumberLab = [UILabel zj_labelWithFontSize:10
                                           textColor:TextColor
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.left.right.height.mas_equalTo(self.desPriceLab);
                                             make.bottom.offset = AdaptedHeight(-12);
                                         }];
    }
    return _desNumberLab;
}


- (UIButton *)operationBtn {
    if (!_operationBtn){
        _operationBtn = [UIButton zj_buttonWithTitle:@"抓紧砍价"
                                          titleColor:[UIColor whiteColor]
                                            norImage:nil
                                       selectedImage:nil
                                           backColor:[UIColor clearColor]
                                            fontSize:12
                                              isBold:NO
                                        cornerRadius:AdaptedWidth(5)
                                             supView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.right.offset  = AdaptedWidth(-10);
                                             make.height.offset = AdaptedHeight(24);
                                             make.width.offset  = AdaptedWidth(72);
                                             make.bottom.offset = AdaptedHeight(-7);
                                         } touchUp:^(id sender) {
                                             
                                             KLLog(@"-----砍价9折购-----");
                                         }];
        [_operationBtn setBackgroundImage:[UIImage imageWithColor:RedColor] forState:UIControlStateNormal];
    }
    return _operationBtn;
}


@end
