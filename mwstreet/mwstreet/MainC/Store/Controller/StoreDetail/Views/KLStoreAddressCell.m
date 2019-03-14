//
//  KLStoreAddressCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/29.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreAddressCell.h"
@interface KLStoreAddressCell ()
//***  定位图标  **/
@property (nonatomic, strong) UIImageView * locImg;
//***  定位地址  **/
@property (nonatomic, strong) UILabel     * addressLab;
//***  定位距离  **/
@property (nonatomic, strong) UILabel     * distanceLab;
//***  分割线  **/
@property (nonatomic, strong) UIView      * line;
//***  联系客服电话  **/
@property (nonatomic, strong) UIImageView * phoneImg;

@end
@implementation KLStoreAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self confingerUI];
    }
    return self;
}
- (void)confingerUI {
    [self locImg];
    [self addressLab];
    [self distanceLab];
    [self line];
    [self phoneImg];

}


- (UIImageView *)locImg {
    if (!_locImg){
        _locImg = [UIImageView zj_imageViewWithImage:@"wz"
                                           SuperView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.centerY.offset = 0;
                                             make.height.offset =AdaptedHeight(20);
                                             make.width.offset =AdaptedWidth(16);
                                             make.left.offset = AdaptedWidth(14);
                                         }];
    }
    return _locImg;
}


- (UILabel *)addressLab {
    if (!_addressLab){
        klWeakSelf;
        _addressLab = [UILabel zj_labelWithFontSize:12
                                              lines:1
                                               text:@"奶粉分开发客人凤飞飞看被verf e"
                                          textColor:TitleColor
                                          superView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.left.mas_equalTo(weakSelf.locImg.mas_right).offset =AdaptedWidth(9);
                                            make.top.offset =AdaptedHeight(11);
                                            make.right.offset = AdaptedWidth(-120);
                                            make.height.offset =AdaptedHeight(15);
                                        }];
    }
    return _addressLab;
}

- (UILabel *)distanceLab {
    if (!_distanceLab){
        klWeakSelf;
        _distanceLab = [UILabel zj_labelWithFontSize:10
                                               lines:1
                                                text:@"2.33千米"
                                           textColor:TextColor
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.top.mas_equalTo(weakSelf.addressLab.mas_bottom).offset =AdaptedHeight(6);
                                             make.left.right.mas_equalTo(weakSelf.addressLab);
                                             make.height.offset =AdaptedHeight(12);
                                         }];
    }
    return _distanceLab;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.right.offset   = AdaptedWidth(-116);
                                     make.width.offset   = 1.0f;
                                     make.centerY.offset = 0;
                                     make.height.offset  = AdaptedHeight(28);
                                 }];
    }
    return _line;
}

- (UIImageView *)phoneImg {
    if (!_phoneImg){
        _phoneImg = [UIImageView zj_imageViewWithImage:@"dianhuahua"
                                             SuperView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.centerY.offset =0;
                                               make.right.offset =AdaptedWidth(-41);
                                               make.height.offset =AdaptedHeight(20);
                                               make.width.offset =AdaptedWidth(20);
                                           }];
        _phoneImg.userInteractionEnabled = YES;
        
        //添加点击手势
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        //点击几次后触发事件响应，默认为：1
        click.numberOfTapsRequired = 1;
        //需要几个手指点击时触发事件，默认：1
        click.numberOfTouchesRequired = 1;
        [_phoneImg addGestureRecognizer:click];
       
    }
    return _phoneImg;
}

- (void)clickAction{
    
    KLLog(@"电话咨询");
    
}

@end
