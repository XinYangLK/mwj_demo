//
//  KLCityListLocController.m
//  mwstreet
//
//  Created by 科pro on 2018/12/24.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLCityListLocController.h"
#import "KLIndexView.h"
#import <ZYPinYinSearch/ZYPinYinSearch.h>
#import "KLHotCityTableViewCell.h"
#import "KLLoctionCityHeaderView.h"
#import "XWLocationManager.h"

@interface KLCityListLocController ()<
UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate>
//{
//    NSMutableArray * allCities;//所有城市
//    NSMutableArray * hostCities;//热门城市
//    NSMutableArray * allCityNames;//搜索列表
//}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KLIndexView * klView;
@property (nonatomic, strong) UISearchBar   * customSearchBar;//导航栏搜索

@property (nonatomic, strong) NSMutableArray * allCities;//所有城市
@property (nonatomic, strong) NSMutableArray * hostCities;//热门城市
@property (nonatomic, strong) NSMutableArray * allCityNames;//搜索列表
@property (nonatomic, strong) NSMutableArray * dataArray;//数据源
@property (assign, nonatomic) BOOL isSearch;//是否是搜索状态
@property (nonatomic, strong) NSMutableArray * searchData;//搜索列表数据

@end

@implementation KLCityListLocController

//***  每次离开移除导航上搜索框 并置空，防止导航titleView保留影响上下级导航界面 **/
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.customSearchBar removeFromSuperview];
    self.customSearchBar = nil;
}
//*** 由于前级界面导航代理隐藏显示原因--> 需在该界面视图view开始布局时(晚于 viewWillAppear)加载导航搜索框  **/
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //***  放在 viewWillAppear 里加载然后前置 会出现闪现情况 **/
    [self.navigationController.view addSubview:self.customSearchBar];
}
//***  视图加载完成 将导航搜索框前置  **/
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.view addSubview:self.customSearchBar];
    [self.navigationController.view bringSubviewToFront:self.customSearchBar];
}

//***  数据源集合  **/
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cityGroups" ofType:@"plist"]];
    }
    return _dataArray;
}
//***  全部城市 字母分组集合  **/
- (NSMutableArray *)allCities {
    if (!_allCities){
       _allCities = [NSMutableArray new];
    }
    return _allCities;
}
//***  热门城市名称集合  **/
- (NSMutableArray *)hostCities {
    if (!_hostCities){
        _hostCities = [NSMutableArray new];
    }
    return _hostCities;
}
//***  全部城市名称集合  **/
- (NSMutableArray *)allCityNames {
    if (!_allCityNames){
        _allCityNames = [NSMutableArray new];
    }
    return _allCityNames;
}
//***  搜索城市名称集合  **/
- (NSMutableArray *)searchData {
    if (!_searchData){
        _searchData = [NSMutableArray new];
    }
    return _searchData;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataScoure];

    [self.view addSubview:self.tableView];
    [self creatKLView];
}

#pragma mark -  加载数据
- (void)loadDataScoure {
    
    for (NSDictionary *dic in self.dataArray) {
        if (![dic[@"title"] isEqualToString:@"热门"]) {
            for (NSString *cityName in dic[@"cities"]) {
                [self.allCityNames addObject:cityName];
            }
            [self.allCities addObject:dic];
        }else{
            self.hostCities = dic[@"cities"];
        }
    }
}


#pragma mark - 热门城市点击回调
- (void)didHotCityActionChick:(UIButton *)sender{
    
    self.selectLocBlock(sender.titleLabel.text);
    
    [self.navigationController popViewControllerAnimated:YES];
    
    KLLog(@"-----%@",sender.titleLabel.text);
    
}
//***  定位城市  **/
- (void)didLoctionCityChick:(UIButton *)sender {
   
    [[XWLocationManager sharedXWLocationManager] getCurrentLocation:^(CLLocation *location, CLPlacemark *placeMark, NSString *error) {
        if (error) {
            KLLog(@"定位出错,错误信息:%@",error);
        }else{
            
            NSString *name                  = placeMark.name;
            NSString *thoroughfare          = placeMark.thoroughfare;
            NSString *subThoroughfare       = placeMark.subThoroughfare;
            NSString *subLocality           = placeMark.subLocality;
            NSString *administrativeArea    = placeMark.administrativeArea;
            NSString *subAdministrativeArea = placeMark.subAdministrativeArea;
            NSString *postalCode            = placeMark.postalCode;
            NSString *ISOcountryCode        = placeMark.ISOcountryCode;
            NSString *country               = placeMark.country;
            NSString *inlandWater           = placeMark.inlandWater;
            NSString *ocean                 = placeMark.ocean;
            NSArray *areasOfInterest        = placeMark.areasOfInterest;
            NSString *city                  = placeMark.locality;  // 获取城市
             // 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
            if (!city)city = placeMark.administrativeArea;
            NSMutableString *text = [[NSMutableString alloc] initWithFormat:@"纬度=%f，经度=%f\n", location.coordinate.latitude, location.coordinate.longitude];
            [text appendFormat:@"city=%@\n", city];
            [text appendFormat:@"name=%@\n", name];
            [text appendFormat:@"thoroughfare=%@\n", thoroughfare];
            [text appendFormat:@"subThoroughfare=%@\n", subThoroughfare];
            [text appendFormat:@"subLocality=%@\n", subLocality];
            [text appendFormat:@"administrativeArea=%@\n", administrativeArea];
            [text appendFormat:@"subAdministrativeArea=%@\n", subAdministrativeArea];
            [text appendFormat:@"postalCode=%@\n", postalCode];
            [text appendFormat:@"ISOcountryCode=%@\n", ISOcountryCode];
            [text appendFormat:@"country=%@\n", country];
            [text appendFormat:@"inlandWater=%@\n", inlandWater];
            [text appendFormat:@"inlandWater=%@\n", inlandWater];
            [text appendFormat:@"ocean=%@\n", ocean];
            [text appendFormat:@"areasOfInterest=%@\n", areasOfInterest];
            
            KLLog(@"定位成功:经度:%f 纬度:%lf 当前地址:%@=%@=%@=%@  \n location详细信息:%@ \n ",location.coordinate.latitude, location.coordinate.longitude, placeMark.administrativeArea,placeMark.locality,placeMark.subLocality,placeMark.name, location);

        }
    } onViewController:self];
    
}


#pragma mark - lazy UI
////创建导航栏searchBar
- (UISearchBar *)customSearchBar {
    if (!_customSearchBar) {
        
        CGRect mainViewBounds = self.navigationController.view.bounds;
        CGFloat statusH = (kDevice_Is_iPhoneX) ? 44 : 24;
        CGFloat x = CGRectGetWidth(mainViewBounds)/2- ((CGRectGetWidth(mainViewBounds)-AdaptedWidth(40))/2)+AdaptedWidth(30);
        CGFloat y = CGRectGetMinY(mainViewBounds)+ statusH;
        CGFloat w = CGRectGetWidth(mainViewBounds)-AdaptedWidth(70);
        CGFloat h = (kDevice_Is_iPhoneX) ? 35 : 30 ;
        
        _customSearchBar = [[UISearchBar alloc] init];
        _customSearchBar.frame = CGRectMake(x, y, w, h);
        _customSearchBar.layer.masksToBounds = YES;
        _customSearchBar.layer.cornerRadius = 5.0f;
        _customSearchBar.placeholder = @" 搜索城市";
        _customSearchBar.searchBarStyle = UISearchBarStyleProminent;
        //改变searchBar背景色
        UIView *firstSubView = _customSearchBar.subviews.firstObject;
        firstSubView.backgroundColor = RGBSigle(245);
        //移除原有背景view
        UIView *backgroundImageView = [firstSubView.subviews firstObject];
        [backgroundImageView removeFromSuperview];
        
        UITextField *searchField = [_customSearchBar valueForKey:@"searchField"];
        [_customSearchBar showsSearchResultsButton];
        if (searchField) {
            searchField.frame =CGRectMake(0, 0, _customSearchBar.mj_w, 30);
            [searchField setBackgroundColor:RGBSigle(245)];
            searchField.tintColor =MainColor;
            searchField.font = [UIFont systemFontOfSize:14];
            searchField.layer.cornerRadius = 5.0f;
            searchField.layer.masksToBounds = YES;
        }
        _customSearchBar.delegate = self;
        _customSearchBar.showsCancelButton = NO;
    }
    return _customSearchBar;
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
        _tableView.mCustomFooterHeaderClass([KLLoctionCityHeaderView class]);
    }
    return _tableView;
}

//***  索引 View  **/
-(void)creatKLView
{
    if (!self.isSearch) {

        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"#", nil];
        for (NSDictionary *dic in self.allCities) {
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
            [weakSelf.customSearchBar resignFirstResponder];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            });
        }];
    }else {
        return ;
    }
}

#pragma mark - 表单 tableViewDelegete && tableViewDatascoure

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    if (!self.isSearch) {
        
        return self.allCities.count + 1;
        
    }else{
        
        return 1;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!self.isSearch) {
        
        if (section == 0 ) {
            
            return 1;
            
        }else{
            
            NSArray *cities = self.allCities[section - 1][@"cities"];
            return cities.count;
        }
        
    }else {
        
        return self.searchData.count;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.isSearch) {
        if (indexPath.section == 0) {
            
            KLHotCityTableViewCell * cell =[KLHotCityTableViewCell initWith:tableView hotCityArray:self.hostCities];
            klWeakSelf;
            cell.hotCityBlock = ^(UIButton * _Nonnull sender) {
                [weakSelf didHotCityActionChick:sender];
            };
            return cell;
            
           
        }else{
            
            UITableViewCell *cell = kCellIdentifier(UITableViewCell);
            NSDictionary *dic = self.allCities[indexPath.section - 1];
            cell.textLabel.textColor =RGBSigle(51);
            cell.textLabel.font =kFont_14;
            cell.textLabel.text = dic[@"cities"][indexPath.row];
            return cell;
        }

    }else{
        
        UITableViewCell *cell = kCellIdentifier(UITableViewCell);
        cell.textLabel.text = self.searchData[indexPath.row];
        cell.textLabel.textColor =RGBSigle(51);
        cell.textLabel.font =kFont_14;
         return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (!self.isSearch && indexPath.section == 0) {
        
        int index = ceil((float)self.hostCities.count/3);
        return index != 0 ? index * AdaptedHeight(50) + AdaptedHeight(20) : 0;
        
    }else {
        
        return AdaptedHeight(40);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.customSearchBar resignFirstResponder];

    if (!self.isSearch && indexPath.section > 0) {
       
        UITableViewCell * cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        self.selectLocBlock(cell.textLabel.text);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else {
        UITableViewCell * cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        self.selectLocBlock(cell.textLabel.text);
        [self.navigationController popViewControllerAnimated:YES];
       
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    if (!self.isSearch) {
        
        if (section == 0) {
            
             return AdaptedHeight(115);
            
        }else {
            
            return AdaptedHeight(30);
        }
        
    }else {
        
        return CGFLOAT_MIN;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    if (!self.isSearch) {
        if (section == 0) {
            klWeakSelf;
            KLLoctionCityHeaderView *headerView = kHeaderFooterIdentifier(KLLoctionCityHeaderView);
            headerView.locCtiyBlock = ^(UIButton * _Nonnull sender) {
                [weakSelf didLoctionCityChick:sender];
            };
            return headerView;
            
        }else {
            
            UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
            if (!headerView) {
                headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
            }
            headerView.contentView.backgroundColor = SpacColor;
            
            return headerView;
        }
    }else {
        
        UIView *headerView =[UIView new];
        return headerView;
    }
    
   
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   
    UIView *footerView =[UIView new];
    return footerView;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   
    if (!self.isSearch && section > 0) {
        
       return self.allCities[section - 1][@"title"];
        
    }else {
        return nil;
    }
    
}


#pragma mark - 搜索框 SearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(nonnull NSString *)searchText{
    [self.searchData removeAllObjects];
    klWeakSelf;
    [ZYPinYinSearch searchByPropertyName:@"cities" withOriginalArray:self.allCityNames searchText:searchText success:^(NSArray *results) {
        
        if (searchText.length == 0) {
            weakSelf.klView.hidden =NO;
            
            [weakSelf.searchData addObjectsFromArray:weakSelf.allCityNames];
            weakSelf.isSearch = NO;
        }else {
            weakSelf.klView.hidden =YES;
            
            [weakSelf.searchData addObjectsFromArray:results];
            weakSelf.isSearch = YES;
        }
        [weakSelf.tableView reloadData];
        
    } failure:^(NSString *errorMessage) {
        
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    return YES;
}


#pragma mark - 去除搜索框响应 scrollviewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.customSearchBar resignFirstResponder];
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
