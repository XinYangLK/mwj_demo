//
//  KLPayMentViewController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/17.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPayMentViewController.h"
#import "KLPayTopTableViewCell.h"
// 动态获取屏幕宽高
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define KScreenWidth  ([UIScreen mainScreen].bounds.size.width)

#define KColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define CColor                   KColorFromRGB(0x666666)
#define DColor                   KColorFromRGB(0x999999)
//#define RemindRedColor           KColorFromRGB(0xF05F50)

@interface KLPayMentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NSArray *dataArr;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,assign) NSInteger currentIndex;
@property (nonatomic ,strong) UIButton *sureBtn;
@property (nonatomic ,strong) UIViewController *vc;

@property (nonatomic ,copy) NSString *totalBalance;

@end

@implementation KLPayMentViewController

- (instancetype)initTotalPay:(NSString *)totalBalance vc:(UIViewController *)vc dataSource:(NSArray *)dataSource{
    if (self = [super init]) {
        self.vc = vc;
        self.totalBalance = totalBalance;
        self.dataArr = dataSource;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = 0;
    [self initPop];
    [self setUpUI];
}

- (void)initPop {
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat height = 140;
    height += self.dataArr.count * 60;
    //    self.contentSizeInPopup = CGSizeMake(self.view.frame.size.width, height);
    //    self.popupController.navigationBarHidden = YES;
    //    [self.popupController.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap)]];
}

- (void)setUpUI {
    [self.view addSubview:self.tableView];
    [self creatSureBtn];
}

-(void)closeBlockView {
    self.payType(@"取消",self.totalBalance);

    [self backgroundTap];
}

- (void)backgroundTap  {
    //    [self.popupController dismiss];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight * 0.4) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 50)];
        v.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, KScreenWidth, 1)];
        line.backgroundColor = LineColor;
        [v addSubview:line];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, KScreenWidth-30, 50)];
        label.textAlignment = 0;
        label.text = [NSString stringWithFormat:@"支付金额: ¥ %@",self.totalBalance];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = CColor;
        label.numberOfLines = 1;
        label.attributedText = [self setPriceAttreWithStr:label.text];
        [v addSubview:label];
        
        UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [xButton setImage:[UIImage imageNamed:@"delect"] forState:UIControlStateNormal];
        xButton.frame = CGRectMake(KScreenWidth - 35, 9, 30, 30);
        [v addSubview:xButton];
        [xButton addTarget:self action:@selector(closeBlockView) forControlEvents:UIControlEventTouchUpInside];
        
        _tableView.tableHeaderView = v;
    }
    return _tableView;
}

#pragma mark === 富文本设置字体
- (NSMutableAttributedString *)setPriceAttreWithStr:(NSString *)str
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:12] range:NSMakeRange(0, 7)];
    [attri addAttribute:NSForegroundColorAttributeName value:DColor range:NSMakeRange(0, 5)];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:18] range:NSMakeRange(7, str.length - 7)];
    [attri addAttribute:NSForegroundColorAttributeName value:MainColor range:NSMakeRange(5, str.length - 5)];
    return attri;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = [NSString stringWithFormat:@"PayTopTableViewCell%ld",indexPath.row];
    KLPayTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[KLPayTopTableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellId];
    }
    [self configCell:cell data:[self.dataArr objectAtIndex:indexPath.row] indexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
    [self.tableView reloadData];
}


- (void)configCell:(KLPayTopTableViewCell *)cell data:(NSDictionary *)data indexPath:(NSIndexPath *)indexPath{
    cell.iconImgView.image = [UIImage imageNamed:data[@"pic"]];
    NSString *str = data[@"title"];
    cell.titleLabel.text = str;
    cell.desLabel.text = @"推荐当前支付方式";
    if (self.currentIndex == indexPath.row) {
        cell.stateView.image =  [UIImage imageNamed:@"ghnbvb"];
    }else{
        cell.stateView.image =  [UIImage imageNamed:@"bvnhgc"];
    }
    
}


-(void)creatSureBtn
{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 90)];
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = AdaptedHeight(20);
    self.sureBtn.layer.masksToBounds = YES;
    [self.sureBtn addTarget:self action:@selector(handleSurePay) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn setBackgroundColor:MainColor];
    self.sureBtn.titleLabel.font = AdaptedBOLDSYSFontSize(15);
    [footer addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(footer);
        make.size.mas_equalTo(CGSizeMake(MainWidth - 30, AdaptedHeight(40)));
    }];
    self.tableView.tableFooterView = footer;
}

#pragma mark === 确认支付
-(void)handleSurePay
{
    if (self.payType) {
        self.payType([[self.dataArr objectAtIndex:self.currentIndex] objectForKey:@"type"],self.totalBalance);
        [self backgroundTap];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
