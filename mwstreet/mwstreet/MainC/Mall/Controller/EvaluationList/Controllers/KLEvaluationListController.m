//
//  KLEvaluationListController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/7.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLEvaluationListController.h"
#import "KLEvaluationHeaderView.h"        //评价区头标签
#import "KLEvaluationListViewCell.h"      //评价cell
#import "KLEvaluationListModel.h"         // 评价列表 model
#import "UITableView+FDTemplateLayoutCell.h"

#import "KLEvaluationDetailController.h" //评价详情

@interface KLEvaluationListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
//***  数据源  **/
@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation KLEvaluationListController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"评价"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    [self refreshTableViewData];
    [self loadingData];
}


#pragma mark - 加载评价数据
- (void)loadingData {
    
    NSArray *imageArray = @[@"https://img.chuizhicai.com/product/20170525/dfa33deb-a228-4a96-bc14-879079497995.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400",@"https://img.chuizhicai.com/product/20170421/e91186ef-2e9a-4118-8fb9-ddc887a6c6fc.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400",@"https://img.chuizhicai.com/ad/20170927/d16b8eb5-f0a2-419d-bde7-8afedc14fa73.jpg",@"https://img.chuizhicai.com/product/20170616/6f989f6e-15bc-4a5f-9c0d-548f265e24bc.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400",@"https://img.chuizhicai.com/product/20170704/93a18f6c-bef0-45e7-a22d-7fbe4605e07a.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400"];
    
    for (int i = 0; i < 12; i++) {
        
        KLEvaluationListModel *model = [[KLEvaluationListModel alloc]init];
        model.iconImage = @"http://q.qlogo.cn/qqapp/1106276139/D1A908A09FE81C02D31FD0EA242397F5/100";
        model.iconName  = @"朋友圈啊";
        model.timer     = @"2018-12-15 ";
        model.scoreNum  = @"8.3";
        model.praiseNum = @"1";
        model.msgNum    = @"2";

        int number =1 + arc4random_uniform(5);
        NSMutableArray *imagesArray = [NSMutableArray array];
        NSString *string = [NSString string];
        for (int i = 0; i < number; i++) {
            int pictureCount = (int)imageArray.count;
            int picture = arc4random_uniform(pictureCount);
            NSString * string2  = @"斗鱼,主要是指归属于鲈形目、攀鲈亚目、丝足鲈科、斗鱼亚科的小型鱼类,与其他鱼类相似,主要以鳃呼吸";
            string = [string stringByAppendingString:string2];
            [imagesArray addObject:imageArray[picture]];
        }
        model.content = string;
        model.images = imagesArray;
        
        [self.dataSource addObject:model];
    }
    
    [self.tableView reloadData];
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

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLEvaluationListViewCell class]);
//        _tableView.mCustomFooterHeaderClass([KLEvaluationHeaderView class]);
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLEvaluationListViewCell * cell = kCellIdentifier(KLEvaluationListViewCell);
    
    cell.evaluationListModel = self.dataSource[indexPath.row];
    cell.indexPath           = indexPath;
    @weakify(self)
    cell.goodsImagesBlock = ^(UIButton * _Nonnull sender, NSMutableArray * _Nonnull imgArray, NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        [self lookImageArray:imgArray index:sender.tag-120] ;
    };

    cell.praiseBlock = ^(UIButton * _Nonnull sender, NSIndexPath * _Nonnull indexPath) {
        
        KLLog(@"--  赞---%ld--------- %ld",sender.tag,indexPath.row);
    };
    cell.msgBlock = ^(UIButton * _Nonnull sender, NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        KLEvaluationDetailController *vc =[[KLEvaluationDetailController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        KLLog(@"--- 二级评论----%ld--------- %ld",sender.tag,indexPath.row);
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    klWeakSelf;
  
    CGFloat height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([KLEvaluationListViewCell class]) cacheByIndexPath:indexPath configuration:^(KLEvaluationListViewCell * cell) {
        cell.evaluationListModel = weakSelf.dataSource[indexPath.row];
    }];
    return height +AdaptedHeight(10);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSArray * buttonArray = @[@"全部（129）",@"好评（109）",@"产品好（89）",@"喜欢（69）",@"差评（0）"];
    KLEvaluationHeaderView * headerFooterView =[KLEvaluationHeaderView initWith:tableView tagArray:buttonArray];
    return [headerFooterView headerForHeight] + AdaptedHeight(20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    NSArray * buttonArray = @[@"全部（129）",@"好评（109）",@"产品好（89）",@"喜欢（69）",@"差评（0）"];
    KLEvaluationHeaderView * headerView  = [KLEvaluationHeaderView initWith:tableView tagArray:buttonArray];
    return headerView;
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView =[UIView new];
    return footerView;
}


//*** 将图片数组加入图片浏览器  **/
- (void)lookImageArray:(NSMutableArray *)imageArray index:(NSInteger)index{
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i < imageArray.count; i++) {
        NSString *urlStr = [imageArray[i] stringByReplacingOccurrencesOfString:@"bmiddle" withString:@"large"];
        KSPhotoItem  * item = [KSPhotoItem itemWithSourceView:nil imageUrl:[NSURL URLWithString:urlStr]];
        [items addObject:item];
    }
    [self ks_photoBrowser:items index:index];
}
#pragma mark - 加载图片浏览器
- (void)ks_photoBrowser:(NSMutableArray *)itemsArray index:(NSInteger)index{
    
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:itemsArray selectedIndex:index];
    browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleRotation;
    browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlur;
    browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
    browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleDot;
    browser.bounces = YES;
    [browser showFromViewController:self];
}


- (NSMutableArray *)dataSource
{
    if(!_dataSource){
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
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
