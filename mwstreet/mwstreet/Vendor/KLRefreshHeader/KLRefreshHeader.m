//
//  KLRefreshHeader.m
//  mwstreet
//
//  Created by 科pro on 2018/12/25.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLRefreshHeader.h"
#import "NSDate+Time.h"
@interface KLRefreshHeader ()

//***  刷新提示语  **/
@property (strong, nonatomic) UILabel                 * titleLabel;
//***  刷新时间   **/
@property (strong, nonatomic) UILabel                 * timeLab;
//***  刷新风火轮  **/
@property (strong, nonatomic) UIActivityIndicatorView * loading;
@end
@implementation KLRefreshHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h =  StatusBarAndNavigationBarHeight + 15;
    
    [self configUI];
}

#pragma mark ------ 构建 UI
- (void)configUI {
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.timeLab];
    [self addSubview:self.loading];

}

- (UILabel *)titleLabel {
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = MJRefreshLabelFont;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = MJRefreshLabelTextColor;
    }
    return _titleLabel;
}
- (UILabel *)timeLab {
    if (!_timeLab){
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = MJRefreshLabelFont;
        _timeLab.textAlignment = NSTextAlignmentCenter;
        _timeLab.textColor = MJRefreshLabelTextColor;
    }
    return _timeLab;
}
- (UIActivityIndicatorView *)loading {
    if (!_loading){
        _loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _loading;
}


#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = StatusBarHeight + 5;
        make.centerX.offset =0;
        make.width.offset =AdaptedWidth(100);
        make.height.offset =AdaptedHeight(15);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset =8;
        make.centerX.offset =0;
        make.width.offset =AdaptedWidth(200);
        make.height.offset =AdaptedHeight(15);
    }];
    
    [self.loading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_top).offset =6;
        make.right.mas_equalTo(self.titleLabel.mas_left).offset =-30;
        make.height.width.offset =AdaptedHeight(20);
    }];
    
    self.timeLab.text = [NSDate timeStringWithTimeInterval:[[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey]];
}



#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            self.titleLabel.text = @"下拉可以刷新";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            self.titleLabel.text = @"松开立即刷新";
            break;
        case MJRefreshStateRefreshing:
            self.titleLabel.text = @"正在刷新数据中...";
            [self.loading startAnimating];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    //    CGFloat red = 1.0 - pullingPercent * 0.5;
    //    CGFloat green = 0.5 - 0.5 * pullingPercent;
    //    CGFloat blue = 0.5 * pullingPercent;
    //    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //    self.titleLabel.textColor =[UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
@end
