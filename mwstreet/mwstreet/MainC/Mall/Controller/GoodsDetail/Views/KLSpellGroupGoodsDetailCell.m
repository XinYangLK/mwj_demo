//
//  KLSpellGroupGoodsDetailCell.m
//  mwstreet
//
//  Created by 科pro on 2019/3/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLSpellGroupGoodsDetailCell.h"
#import "KLDroupOrderListCell.h"

@interface KLSpellGroupGoodsDetailCell ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation KLSpellGroupGoodsDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self speaLine];
    [self titleLab];
    [self.contentView addSubview:self.tableView];
}
- (UIView *)speaLine {
    if (!_speaLine){
        _speaLine = [UIView zj_viewWithBackColor:SpacColor
                                         supView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.right.top.offset = 0;
                                         make.height.offset = AdaptedHeight(5);
                                     }];
    }
    return _speaLine;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.top.mas_equalTo(self.speaLine.mas_bottom).offset = AdaptedHeight(14);
                                          make.left.offset   = AdaptedWidth(12);
                                          make.height.offset = AdaptedHeight(15);
                                          make.width.offset  = AdaptedWidth(150);
                                      }];
    }
    return _titleLab;
}



- (void)setDataAry:(NSMutableArray *)dataAry {
    _dataAry = dataAry;
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, AdaptedHeight(49), MainWidth, AdaptedHeight(150)) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.tableFooterView =[UIView new];
        _tableView.mCustomClass([KLDroupOrderListCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLDroupOrderListCell *cell = kCellIdentifier(KLDroupOrderListCell);
    cell.telLab.text   = @"186****2154";
    cell.titleLab.text = @"还差1人拼成";
    cell.timeLab.text  = self.dataAry[indexPath.row];
    cell.indexPath     = indexPath;
    if ([cell.timeLab.text isEqualToString:@"拼单已结束"]) {
        cell.joinBtn.backgroundColor =BackgroundColor;
        cell.joinBtn.titleLabel.backgroundColor =BackgroundColor;
        cell.joinBlock = ^(UIButton * _Nonnull sender, NSIndexPath * _Nonnull indexPath) {
//            KLLog(@"---拼单已结束--");
        };
    }else {
        cell.joinBtn.backgroundColor =MainColor;
        cell.joinBtn.titleLabel.backgroundColor =MainColor;
        @weakify(self)
        cell.joinBlock = ^(UIButton * _Nonnull sender, NSIndexPath * _Nonnull indexPath) {
            @strongify(self)
            self.joinGroundBlock ? self.joinGroundBlock(sender, indexPath) : nil;
        };
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return AdaptedHeight(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    if (!headerView) {
        headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
    }
    return headerView;
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerCell"];
    if (!footerView) {
        footerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"footerCell"];
    }
    return footerView;
}



@end
