//
//  KLSeckillingAreaCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/20.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLSeckillingAreaCell.h"

@interface KLSeckillingAreaCell ()

//***  数据array  **/
@property (nonatomic, strong) NSArray          * goodsArray;
//标题
@property (nonatomic, strong) NSString         * titleStr;
//副标题
@property (nonatomic, strong) NSString         * textStr;
//是否隐藏倒计时
@property (nonatomic, assign) BOOL               hidden;

@end

@interface KLSeckillingAreaCell ()

@end

@implementation KLSeckillingAreaCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title text:(NSString *)text goodsArray:(NSArray *)goodsArray hidden:(BOOL)hidden{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        self.titleStr   = title;
        self.textStr    = text;
        self.goodsArray = goodsArray;
        self.hidden     = hidden;

        [self configUI];

    }
    return self;
}
#pragma mark ------ UI 构建
- (void)configUI {
    [self.contentView addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}


+ (KLSeckillingAreaCell *)initWith:(UITableView *)tableView title:(NSString *)title text:(NSString *)text goodsArray:(NSArray *)goodsArray hidden:(BOOL)hidden{
    
    KLSeckillingAreaCell * cell = kCellIdentifier(KLSeckillingAreaCell);
    if (!cell) {
        cell = [[KLSeckillingAreaCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([KLSeckillingAreaCell class]) title:title text:text goodsArray:goodsArray hidden:hidden];
    }
    return cell;
}


- (KLScrollActivityView *)activityView {
    if (!_activityView){
        _activityView = [[KLScrollActivityView alloc]initWithFrame:CGRectZero title:self.titleStr text:self.textStr goodsArray:self.goodsArray hidden:self.hidden indexPath:self.indexPath];
        klWeakSelf;
        _activityView.goodsBlock = ^(UIButton * _Nonnull button, NSIndexPath * _Nonnull indexPath) {
            if (weakSelf.goodsBlock) {
                weakSelf.goodsBlock(button,weakSelf.indexPath);
            }
        };
        _activityView.moreBlock = ^(UIButton * _Nonnull button) {
            if (weakSelf.cellMoreBlock) {
                weakSelf.cellMoreBlock(button, weakSelf.indexPath);                
            }
        };
    }
    return _activityView;
}





@end
