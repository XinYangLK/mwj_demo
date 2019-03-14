//
//  KLStoreDetailHeaderView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/30.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreDetailHeaderView.h"

@interface KLStoreDetailHeaderView ()
@property (nonatomic, strong) UIButton * moreBtn;
@property (nonatomic, strong) UIView   * line;
@property (nonatomic, strong) NSString *title;
@end

@implementation KLStoreDetailHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title moreHidden:(BOOL)hidden lineHidden:(BOOL)lineHidden{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        self.title = title;
        [self titleLab];
        if (!hidden) {
            [self moreBtn];
        }
        if (!lineHidden) {
            [self line];
        }
    }
    return self;
}


+ (KLStoreDetailHeaderView *)initWith:(UITableView *)tableView title:(NSString *)title moreHidden:(BOOL)hidden lineHidden:(BOOL)lineHidden{
    NSString *identifier = [NSString stringWithFormat:@"%@%@",title,NSStringFromClass([KLStoreDetailHeaderView class])];
    KLStoreDetailHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!headerView) {
        headerView =[[KLStoreDetailHeaderView alloc]initWithReuseIdentifier:identifier title:title moreHidden:hidden lineHidden:lineHidden];
    }
    return headerView;
}



- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:self.title
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(10);
                                          make.height.offset =AdaptedHeight(15);
                                          make.width.offset =AdaptedWidth(120);
                                          make.centerY.offset = 0;
                                      }];
    }
    return _titleLab;
}

- (UIButton *)moreBtn {
    if (!_moreBtn){
        klWeakSelf;
        _moreBtn = [UIButton createBtnTitle:@"查看全部" titleColor:TitleColor font:kFont_12 imageName:@"more" backgrounColor:[UIColor clearColor] SSImagePositionType:SSImagePositionTypeRight spacing:4 action:^(UIButton * _Nonnull button) {
            //***  回调  **/
            weakSelf.lookMoreBlock(button, weakSelf.section);
            
        }];
        _moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.contentView addSubview:_moreBtn];
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset =AdaptedWidth(-10);
            make.centerY.offset =0;
            make.height.offset =AdaptedHeight(20);
            make.width.offset =AdaptedWidth(120);
        }];
    }
    return _moreBtn;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.bottom.right.offset = 0;
                                     make.height.offset = 0.5f;
                                 }];
    }
    return _line;
}
@end
