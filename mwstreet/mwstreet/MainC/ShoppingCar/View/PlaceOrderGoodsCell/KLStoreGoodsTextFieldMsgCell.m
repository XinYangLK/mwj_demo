//
//  KLStoreGoodsTextFieldMsgCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/16.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreGoodsTextFieldMsgCell.h"
@interface KLStoreGoodsTextFieldMsgCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation KLStoreGoodsTextFieldMsgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configerUI];
    }
    return self;
}

#pragma mark - lazy UI
- (void)configerUI {
    [self titleLab];
    [self textField];
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:@"买家留言"
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset = AdaptedWidth(10);
                                          make.width.offset = AdaptedWidth(60);
                                          make.height.offset = AdaptedHeight(15);
                                          make.centerY.offset = 0;
                                      }];
   
    }
    return _titleLab;
}

- (UITextField *)textField {
    if (!_textField){
        _textField = [UITextField zj_textFieldWithHolder:@"选填"
                                                    text:@""
                                               superView:self.contentView
                                             constraints:^(MASConstraintMaker *make) {
                                                 make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(10);
                                                 make.height.centerY.mas_equalTo(self.titleLab);
                                                 make.right.offset =AdaptedWidth(-20);
                                             }];
        _textField.textColor = TextColor;
        _textField.tintColor = TextColor;
        _textField.font      = kFont_14;
    }
    return _textField;
}

@end
