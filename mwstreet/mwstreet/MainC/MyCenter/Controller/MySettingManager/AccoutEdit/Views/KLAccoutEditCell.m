//
//  KLAccoutEditCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/20.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLAccoutEditCell.h"
#import "UITextView+KLPlaceholder.h"


#pragma mark -  头像上传  **/
@implementation KLAccoutEditCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configerUI];
    }
    return self;
}
- (void)configerUI {
    [self titleLab];
    [self accoutImg];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.centerY.offset =0;
                                          make.left.offset =AdaptedWidth(12);
                                          make.height.offset =AdaptedHeight(20);
                                          make.width.offset =AdaptedWidth(100);
                                      }];
    }
    return _titleLab;
}

- (UIImageView *)accoutImg {
    if (!_accoutImg){
        _accoutImg = [UIImageView zj_imageViewWithImage:@"zhanweitoux"
                                              SuperView:self.contentView
                                            constraints:^(MASConstraintMaker *make) {
                                                make.height.width.offset =AdaptedWidth(36);
                                                make.centerY.offset =0;
                                                make.right.offset =AdaptedWidth(-12);
                                            }];
        [_accoutImg setLayerCornerRadius:AdaptedHeight(18)];
    }
    return _accoutImg;
}

@end




#pragma mark -  昵称编辑  **/
@implementation KLAccoutNickNameEditCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}
- (void)configerUI {
    [self titleLab];
    [self angleImg];
    [self nickField];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.centerY.offset =0;
                                          make.left.offset =AdaptedWidth(12);
                                          make.height.offset =AdaptedHeight(20);
                                          make.width.offset =AdaptedWidth(100);
                                      }];
    }
    return _titleLab;
}



- (UIImageView *)angleImg {
    if (!_angleImg){
        _angleImg = [[UIImageView alloc]init];
        _angleImg.contentMode = UIViewContentModeScaleAspectFit;
        _angleImg.image = [UIImage imageNamed:@"more"];
        [self.contentView addSubview:_angleImg];
        [_angleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -15;
            make.centerY.offset =0;
            make.height.offset =AdaptedHeight(15);
            make.width.offset =AdaptedWidth(12);
        }];
    }
    return _angleImg;
}

- (UITextField *)nickField {
    if (!_nickField){
        _nickField = [[UITextField alloc]init];
        _nickField.textColor = TextColor;
        _nickField.placeholder =@"昵称";
        _nickField.font =AdaptedSYSFontSize(14);
        _nickField.tintColor =MainColor;
        _nickField.textAlignment =NSTextAlignmentRight;
        [self.contentView addSubview:_nickField];
        [_nickField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.angleImg.mas_left).offset =AdaptedWidth(-5);
            make.height.offset =AdaptedHeight(20);
            make.centerY.mas_equalTo(self.titleLab);
            make.width.offset =MainWidth - AdaptedWidth(100);
        }];
    }
    return _nickField;
}

- (void)setDataString:(NSString *)dataString andIndexPath:(NSIndexPath *)indexPath{
    // 核心代码
    self.nickField.indexPath = indexPath;
    self.nickField.text = dataString;
}

@end



#pragma mark -  性别、生日选择  **/
@implementation KLAccoutSexBothdayEditCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    [self titleLab];
    [self angleImg];
    [self textLab];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.centerY.offset =0;
                                          make.left.offset =AdaptedWidth(12);
                                          make.height.offset =AdaptedHeight(20);
                                          make.width.offset =AdaptedWidth(120);
                                      }];
    }
    return _titleLab;
}



- (UIImageView *)angleImg {
    if (!_angleImg){
        _angleImg = [[UIImageView alloc]init];
        _angleImg.contentMode = UIViewContentModeScaleAspectFit;
        _angleImg.image = [UIImage imageNamed:@"more"];
         [self.contentView addSubview:_angleImg];
        [_angleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -15;
            make.centerY.offset =0;
            make.height.offset =AdaptedHeight(15);
            make.width.offset =AdaptedWidth(12);
        }];
    }
    return _angleImg;
}

- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel zj_labelWithFontSize:12
                                       textColor:TextColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.right.mas_equalTo(self.angleImg.mas_left).offset =AdaptedWidth(-5);
                                         make.height.offset =AdaptedHeight(20);
                                         make.centerY.mas_equalTo(self.titleLab);
                                         make.width.offset =MainWidth - AdaptedWidth(140);
                                     }];
        _textLab.textAlignment =NSTextAlignmentRight;
    }
    return _textLab;
}


@end



@implementation KLAccoutRemarksEditCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;

        [self configerUI];
        
    }
    return self;
}

- (void)configerUI {
    [self titleLab];
    [self remarksView];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.top.offset =AdaptedHeight(17);
                                          make.left.offset =AdaptedWidth(15);
                                          make.height.offset =AdaptedHeight(15);
                                          make.width.offset =AdaptedWidth(180);
                                      }];
    }
    return _titleLab;
}

- (UITextView *)remarksView {
    if (!_remarksView){
        _remarksView = [[UITextView alloc]init];
        _remarksView.font =AdaptedSYSFontSize(14);
        _remarksView.textColor = TitleColor;
        _remarksView.tintColor = MainColor;
        _remarksView.maxInputLength = 100;
        _remarksView.placeholder =@"编写属于自己的个性签名,100字以内！";
        _remarksView.placeholderAttributes = @{NSFontAttributeName:AdaptedSYSFontSize(14),NSForegroundColorAttributeName:RGBSigle(208)};
        [self.contentView addSubview:_remarksView];
        [_remarksView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset =AdaptedWidth(12);
            make.right.offset =AdaptedWidth(-12);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset =AdaptedHeight(5);
            make.bottom.offset =AdaptedHeight(-8);
        }];
    }
    return _remarksView;
}



@end
