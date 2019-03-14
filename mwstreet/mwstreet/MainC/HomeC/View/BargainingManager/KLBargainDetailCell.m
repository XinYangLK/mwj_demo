//
//  KLBargainDetailCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBargainDetailCell.h"
#import "KLBargainFriendCell.h"

@interface KLBargainDetailCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView * backImg;
@property (nonatomic, strong) UIView      * backView;

//countPercentageLabel.format = @"%.2f%";
//[countPercentageLabel countFrom:5 to:10];
@end

@implementation KLBargainDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}



- (void)didPagessViewAnimationDelay:(CGFloat)delayTime Ratio:(CGFloat)ratio{
    CGFloat MaxW = MainWidth -AdaptedWidth(66)-2;
    [UIView animateWithDuration:delayTime animations:^{
       
         self.headerView.sliderShowView.mj_w = ratio;
    
        if (ratio <= MaxW/100*1) {
             self.headerView.showLable.mj_x =AdaptedWidth(14);
             self.headerView.showAngle.centerX =AdaptedWidth(24);

        }else if( MaxW/100*1 < ratio && ratio <= MaxW/100*2){
            self.headerView.showLable.mj_x =AdaptedWidth(16);;
            self.headerView.showAngle.centerX =AdaptedWidth(26);

        }else if (ratio >= MaxW/100*98) {
            self.headerView.showLable.centerX =MaxW - AdaptedWidth(10);
            self.headerView.showAngle.centerX = MaxW +  AdaptedWidth(14);

        }else if (ratio >= MaxW/100*97 && ratio < MaxW/100*98) {
            self.headerView.showLable.centerX = MaxW - AdaptedWidth(14);
            self.headerView.showAngle.centerX =AdaptedWidth(15);
        }else{
            self.headerView.showLable.centerX = ratio + AdaptedWidth(14);
            self.headerView.showAngle.centerX = ratio + AdaptedWidth(14);
        }
    }];
}

#pragma mark - lazy UI

- (void)configerUI {
    [self backImg];
    [self.contentView addSubview:self.bargainGoodsView];
    
    [self.bargainGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.offset =0;
        make.height.offset =AdaptedHeight(206);
    }];
    
    [self timerLab];
    [self shareBtn];
    
    
    [self backView];
    [self.backView addSubview:self.tableView];
    
   
    [self.backView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset =0;
        make.height.offset =AdaptedHeight(133);
    }];
   
}

- (UIImageView *)backImg {
    if (!_backImg){
        _backImg = [UIImageView zj_imageViewWithImage:@"jgjhnbfj"
                                            SuperView:self.contentView
                                          constraints:^(MASConstraintMaker *make) {
                                              make.edges.mas_equalTo(self);
                                          }];
    }
    return _backImg;
}

- (KLBargainGoodsView *)bargainGoodsView {
    if (!_bargainGoodsView){
        _bargainGoodsView = [[KLBargainGoodsView alloc]init];
    }
    return _bargainGoodsView;
}

- (UILabel *)timerLab {
    if (!_timerLab){
        _timerLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:@""
                                        textColor:[UIColor whiteColor]
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(30);
                                          make.height.offset =AdaptedHeight(15);
                                          make.width.offset= MainWidth -AdaptedWidth(60);
                                          make.top.mas_equalTo(self.bargainGoodsView.mas_bottom).offset =AdaptedHeight(21);
                                      }];
        _timerLab.backgroundColor =[UIColor clearColor];
        _timerLab.textAlignment = NSTextAlignmentCenter;
    }
    return _timerLab;
}

-(UIButton *)shareBtn {
    if (!_shareBtn){
        _shareBtn = [UIButton zj_buttonWithTitle:@"分享到群，多砍一刀" titleColor:RedColor backColor:RGB(255,174,47) fontSize:18 isBold:YES cornerRadius:AdaptedHeight(20) supView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.offset =AdaptedWidth(33);
            make.height.offset=AdaptedHeight(41);
            make.centerX.offset =0;
            make.top.mas_equalTo(self.timerLab.mas_bottom).offset =AdaptedHeight(25);
        } touchUp:^(id sender) {
            
        }];
    }
    return _shareBtn;
}




- (UIView *)backView {
    if (!_backView){
        _backView = [UIView zj_viewWithBackColor:[UIColor whiteColor]
                                         supView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.offset =AdaptedWidth(16);
                                         make.height.offset =AdaptedHeight(275);
                                         make.top.offset =AdaptedHeight(349);
                                         make.centerX.offset =0;
                                     }];
        [_backView setLayerCornerRadius:5];
    }
    return _backView;
}


//

- (KLCellHeaderView *)headerView {
    if (!_headerView){
        _headerView = [[KLCellHeaderView alloc]init];
    }
    return _headerView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, AdaptedHeight(143), MainWidth-AdaptedWidth(32), AdaptedHeight(132)) style:UITableViewStylePlain];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[UIView new];
        _tableView.mCustomClass([KLBargainFriendCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLBargainFriendCell *cell = kCellIdentifier(KLBargainFriendCell);
    cell.imgName =@"touxiang";
    cell.accName =@"费尔法诶";
    cell.bargain =@"10.21";
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return AdaptedHeight(35);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}






@end
