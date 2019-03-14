//
//  KLPetIndexListController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/18.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPetIndexListController.h"
#import "KLIndexView.h"
#import "KLPetHotTableViewCell.h"
#import "KLPetInfoEntryController.h" //宠物信息录入

@interface KLPetIndexListController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KLIndexView * klView;
@property (nonatomic, strong) NSMutableArray * dataArray;//数据源
@property (nonatomic, strong) NSMutableArray * allPets;  //所有宠物
@property (nonatomic, strong) NSMutableArray * hostPets; //热门宠物
//@property (nonatomic, strong) NSMutableArray * allPetNames;//搜索列表

@end

@implementation KLPetIndexListController
//***  数据源集合  **/
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cityGroups" ofType:@"plist"]];
    }
    return _dataArray;
}
//***  全部城市 字母分组集合  **/
- (NSMutableArray *)allPets {
    if (!_allPets){
        _allPets = [NSMutableArray new];
    }
    return _allPets;
}
//***  热门城市名称集合  **/
- (NSMutableArray *)hostPets {
    if (!_hostPets){
        _hostPets = [NSMutableArray new];
    }
    return _hostPets;
}
////***  全部城市名称集合  **/
//- (NSMutableArray *)allPetNames {
//    if (!_allPetNames){
//        _allPetNames = [NSMutableArray new];
//    }
//    return _allPetNames;
//}


- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"添加宠物"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataScoure];
    [self.view addSubview:self.tableView];
    [self creatKLView];

}

#pragma mark - 热门宠物点击回调
- (void)didHotCityActionChick:(KLHotPetButton *)sender{
    
    KLLog(@"-----%@",sender.petNameLab.text);
    
    KLPetInfoEntryController *vc =[[KLPetInfoEntryController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -  加载数据
- (void)loadDataScoure {
    
    for (NSDictionary *dic in self.dataArray) {
        if (![dic[@"title"] isEqualToString:@"热门"]) {
//            for (NSString *cityName in dic[@"cities"]) {
//                [self.allPetNames addObject:cityName];
//            }
            [self.allPets addObject:dic];
        }else{
            self.hostPets = dic[@"cities"];
        }
    }
}

//***  tableView UI  **/
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BackgroundColor;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([UITableViewCell class]);
    }
    return _tableView;
}

//***  索引 View  **/
-(void)creatKLView
{
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"#", nil];
    for (NSDictionary *dic in self.allPets) {
        [arr addObject:dic[@"title"]];
    }
    CGFloat w = AdaptedWidth(35);
    CGFloat x = MainWidth - w;
    CGFloat y = AdaptedHeight(30);
    CGFloat h = MainHeight - StatusBarAndNavigationBarHeight - y * 4;
    self.klView = [[KLIndexView alloc]initWithFrame:CGRectMake(x,y,w,h) indexArray:arr];
    [self.view addSubview:self.klView];
    klWeakSelf;
    [self.klView selectIndexBlock:^(NSInteger section){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        });
    }];
}
#pragma mark - 表单 tableViewDelegete && tableViewDatascoure

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.allPets.count + 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0 ) {
        
        return 1;
        
    }else{
        
        NSArray *cities = self.allPets[section - 1][@"cities"];
        return cities.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        KLPetHotTableViewCell * cell =[KLPetHotTableViewCell initWith:tableView hotPetArray:self.hostPets];
        klWeakSelf;
        cell.hotPetBlock = ^(KLHotPetButton * _Nonnull sender) {
            [weakSelf didHotCityActionChick:sender];
        };
        return cell;
        
        
    }else{
        
        UITableViewCell *cell = kCellIdentifier(UITableViewCell);
        NSDictionary *dic = self.allPets[indexPath.section - 1];
        cell.textLabel.textColor =RGBSigle(51);
        cell.textLabel.font =kFont_14;
        cell.textLabel.text = dic[@"cities"][indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        
        CGFloat marginX = AdaptedWidth(20);     //按钮距离左边和右边的距离
        CGFloat gapX = AdaptedWidth(10);        //左右按钮之间的距离
        NSInteger col = 3;                      //这里只布局3列
        NSInteger count = self.hostPets.count;   //这里先设置布局任意个按钮
        CGFloat viewWidth = MainWidth - AdaptedWidth(20);        //视图的宽度
        //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
        CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gapX)/col*1.0f;
        CGFloat itemHeight = itemWidth +AdaptedHeight(30); //按钮的高度可以根据情况设定 这里设置为相等

        int index = ceil((float)count/3);
        return index != 0 ? index * (itemHeight + AdaptedHeight(10))+ AdaptedHeight(10) : 0;
        
    }else {
        
        return AdaptedHeight(40);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section > 0) {
        
        KLPetInfoEntryController *vc =[[KLPetInfoEntryController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    if (section == 0) {
        
        return CGFLOAT_MIN;
        
    }else {
        
        return AdaptedHeight(30);
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    if (!headerView) {
        headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
    }
    headerView.contentView.backgroundColor = SpacColor;
    
    return headerView;
    
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView =[UIView new];
    return footerView;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section > 0) {
        
        return self.allPets[section - 1][@"title"];
        
    }else {
        return nil;
    }
    
}




@end
