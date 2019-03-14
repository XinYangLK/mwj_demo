//
//  KLStoreServiceCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/29.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreServiceCell.h"

@interface KLStoreServiceCell ()
//***  服务图片  **/
@property (nonatomic, strong) UIImageView * serImg;
//***  服务名称  **/
@property (nonatomic, strong) UILabel     * titleLab;
//***  服务价格  **/
@property (nonatomic, strong) UILabel     * priceLab;
//***  服务已售量  **/
@property (nonatomic, strong) UILabel     * decLab;
//***  购买服务按钮  **/
@property (nonatomic, strong) UIButton    * payBtn;

@end

@implementation KLStoreServiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configerUI];
    }
    return self;
}
- (void)configerUI {
    [self serImg];
    [self titleLab];
    [self priceLab];
    [self decLab];
    [self payBtn];

}

- (UIImageView *)serImg {
    if (!_serImg){
        _serImg = [UIImageView zj_imageViewWithImage:@"gipjd_1"
                                           SuperView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.left.offset = AdaptedWidth(11);
                                             make.width.height.offset =AdaptedHeight(48);
                                             make.centerY.offset =0;
                                         }];
    }
    return _serImg;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:@"[ 洗澡 ]小型犬"
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.serImg.mas_right).offset =AdaptedWidth(28);
                                          make.height.offset =AdaptedHeight(15);
                                          make.top.mas_equalTo(self.serImg);
                                          make.right.mas_equalTo(-75);
                                      }];
    }
    return  _titleLab;
}

- (UILabel *)priceLab {
    if (!_priceLab){
        _priceLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:@"￥30起"
                                        textColor:RedColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.height.right.left.mas_equalTo(self.titleLab);
                                          make.bottom.mas_equalTo(self.serImg);
                                      }];
    }
    return _priceLab;
}

- (UILabel *)decLab {
    if (!_decLab){
        _decLab = [UILabel zj_labelWithFontSize:10
                                           lines:1
                                            text:@"已售 12"
                                       textColor:TextColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.top.height.mas_equalTo(self.titleLab);
                                         make.right.offset =AdaptedWidth(-12);
                                         make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(5);
                                     }];
        _decLab.textAlignment = NSTextAlignmentCenter;
    }
    return _decLab;
}

- (UIButton *)payBtn {
    if (!_payBtn){
        klWeakSelf;
        _payBtn = [UIButton zj_buttonWithTitle:@"购买"
                                    titleColor:RedColor
                                      norImage:nil
                                 selectedImage:nil
                                     backColor:[UIColor clearColor]
                                      fontSize:12
                                        isBold:NO
                                   borderWidth:1
                                   borderColor:RedColor
                                  cornerRadius:AdaptedHeight(10)
                                       supView:self.contentView
                                   constraints:^(MASConstraintMaker *make) {
                                       make.right.offset =AdaptedWidth(-12);
                                       make.bottom.mas_equalTo(self.serImg);
                                       make.height.offset =AdaptedHeight(21);
                                       make.left.mas_equalTo(self.decLab);
                                   } touchUp:^(id sender) {
                                       
                                       weakSelf.payBlock ?  weakSelf.payBlock(sender) : nil;
                                   }];
        
    }
    return _payBtn;
}

@end
