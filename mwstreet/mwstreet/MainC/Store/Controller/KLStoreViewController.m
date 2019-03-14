//
//  KLStoreViewController.m
//  mengWuStreet
//
//  Created by 科pro on 2018/12/15.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLStoreViewController.h"
#import "KLStoreListCell.h"
#import "KLNavigationSearchBtn.h"
#import "TFDropDownMenuView.h"

//#import "KLStoreDetailController.h" //门店详情
#import "KLStoreDetailViewController.h"//门店详情

@interface KLStoreViewController ()<
UITableViewDelegate,
UITableViewDataSource,
TFDropDownMenuViewDelegate
>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) KLNavigationSearchBtn *searchBtn;
@end

@implementation KLStoreViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBtn removeFromSuperview];
    _searchBtn = nil;
}

//*** 由于前级界面导航代理隐藏显示原因--> 需在该界面视图view开始布局时(晚于 viewWillAppear)加载导航搜索框  **/
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //***  放在 viewWillAppear 里加载然后前置 会出现闪现情况 **/
    [self.navigationController.view addSubview:self.searchBtn];
}
//***  视图加载完成 将导航搜索框前置  **/
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.view addSubview:self.searchBtn];
//    [self.navigationController.view bringSubviewToFront:self.searchBtn];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self configerUI];
}

#pragma mark ------ 自定义方法 \delegate 响应事件
//***  搜索响应  **/
- (void)searchBtnChick:(UIButton *)sender{
   
    KLLog(@"搜索响应");
}

#pragma mark ------ 下拉菜单 delegate
- (void)menuView:(TFDropDownMenuView *)menu selectIndex:(TFIndexPatch *)index {
    NSLog(@"index: %ld", index.section);
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)menuView:(TFDropDownMenuView *)menu tfColumn:(NSInteger)column {
    NSLog(@"column: %ld", column);
}


#pragma mark ------ lazy 构建 UI
- (void)configerUI {
    [self.view addSubview:self.tableView];
    [self refreshTableViewData];
    [self creatDropMenu];
}

//***  自定义导航伪搜索框  **/
- (UIButton *)searchBtn {
    if (!_searchBtn){
        CGFloat y = (kDevice_Is_iPhoneX) ? 44 : 24;
        CGRect mainViewBounds = self.navigationController.view.bounds;
        _searchBtn = [[KLNavigationSearchBtn alloc]init];
        _searchBtn.tag =1000;
        _searchBtn.frame = CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-AdaptedWidth(40))/2), CGRectGetMinY(mainViewBounds)+y, CGRectGetWidth(mainViewBounds)-AdaptedWidth(40), 30);
        _searchBtn.searchLab.text =@"野兽派";
        [_searchBtn addTarget:self action:@selector(searchBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}
//***  创建 下拉菜单 **/
- (void)creatDropMenu {
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:@"面积最大", @"面积最小", @"价格最高", @"价格最低", nil];
  NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"从大到小", @"从小到大", @"从高到低", @"从低到高", @"从右到左", @"从左到右", @"从前到后", @"从后到前", nil];
    
//    NSMutableArray *array3 = [NSMutableArray arrayWithObjects:@"热门推荐", @"美食", @"影院", @"自助餐", @"景区", @"汽车", @"网吧", @"游戏", nil];
//    NSArray *array31 = @[
//                         @[@"好玩的", @"好吃的", @"好景的", @"好喝的", @"好唱的"],
//                         @[@"美食城1",@"美食城2", @"美食城3", @"美食城5", @"美食城10"],
//                         @[@"金逸影院", @"万达影院", @"兄弟影院", @"新影联影院", @"保利影院", @"大地影院"],
//                         @[@"韩式烤肉", @"日式自助", @"海底捞", @"湘十二楼", @"金百万金百万金百万金百万金百万金百万", @"金钱豹", @"望京小腰", @"盘古自助", @"旋转餐厅", @"鼎极轩", @"玉林串串香", @"大鸭梨"],
//                         @[@"长城", @"故宫", @"天安门", @"明十三陵", @"颐和园", @"圆明园"],
//                         @[@"玛莎拉蒂", @"法拉利", @"奔驰", @"宝马", @"奥迪"],
//                         @[@"休闲网咖", @"学子网吧"],
//                         @[@"英雄联盟", @"王者荣耀", @"大吉大利", @"大话西游", @"传奇"]
//                         ];
    
    NSMutableArray *data1 = [NSMutableArray arrayWithObjects:array1, array2,@[@"自定义"], nil];
    NSMutableArray *data2 = [NSMutableArray arrayWithObjects:@[],@[],@[], nil];
    TFDropDownMenuView *menu = [[TFDropDownMenuView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, AdaptedHeight(44)) firstArray:data1 secondArray:data2];
    menu.delegate = self;
    menu.cellSelectBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    menu.ratioLeftToScreen = 0.35;
    [self.view addSubview:menu];
    
    /*副标*/
//    NSMutableArray *detail1 = [NSMutableArray arrayWithObjects:@"21", @"22", @"23", @"24", nil];
//    NSMutableArray *detail2 = [NSMutableArray arrayWithObjects:@"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", nil];
//    NSMutableArray *detail3 = [NSMutableArray arrayWithObjects:@"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", nil];
//    NSArray *detail21 = @[
//                          @[@"111", @"112", @"113", @"114", @"115"],
//                          @[@"121",@"122", @"123", @"125", @"125"],
//                          @[@"131", @"132", @"133", @"134", @"135", @"136"],
//                          @[@"141", @"142", @"143", @"144", @"145"],
//                          @[@"151", @"152", @"153", @"154", @"155", @"156"],
//                          @[@"161", @"162", @"163", @"164", @"165"],
//                          @[@"171", @"172"],
//                          @[@"181", @"182", @"183", @"184", @"185"]
//                          ];
//    menu.firstRightArray = [NSMutableArray arrayWithObjects:detail1, detail2,detail3, nil];
//    menu.secondRightArray = [NSMutableArray arrayWithObjects:@[], detail21, nil];
    
    /*风格*/
    menu.menuStyleArray = [NSMutableArray arrayWithObjects:
                           [NSNumber numberWithInteger:TFDropDownMenuStyleTableView],
                           [NSNumber numberWithInteger:TFDropDownMenuStyleCollectionView],
//                           [NSNumber numberWithInteger:TFDropDownMenuStyleTableView],
                           [NSNumber numberWithInteger:TFDropDownMenuStyleCustom], nil];
    
    /*自定义视图*/
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, MainHeight-StatusBarAndNavigationBarHeight)];
    label.text = @"我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图";
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor orangeColor];
    menu.customViews = [NSMutableArray arrayWithObjects:[NSNull null], [NSNull null], label, nil];
}



//***  lazy tableView表  **/
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat y = AdaptedHeight(44);
        CGFloat h = MainHeight-StatusBarAndNavigationBarHeight - TabbarHeight - y;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, y, MainWidth, h) style:UITableViewStylePlain];
        _tableView.alwaysBounceVertical = NO;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[UIView new];
        _tableView.mCustomClass([KLStoreListCell class]);
    }
    return _tableView;
}

//***  刷新-加载  **/
-(void)refreshTableViewData{
    
    klWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        //网络刷新请求
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        //网络请求
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KLStoreListCell * cell =kCellIdentifier(KLStoreListCell);
    cell.goodsImg.image = [UIImage imageNamed:@"dianmian"];
    cell.titleLab.text =@"狗粮王菲菲慰问和复位范文芳微服务额废物和";
    cell.distanceLab.text =[NSString stringWithFormat:@"%ld千米",indexPath.row+1];
    cell.addressLab.text =@"上海市静安区的定位ID我才问问是weUI是底层DVD";
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(135);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KLStoreDetailViewController *vc =[[KLStoreDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
