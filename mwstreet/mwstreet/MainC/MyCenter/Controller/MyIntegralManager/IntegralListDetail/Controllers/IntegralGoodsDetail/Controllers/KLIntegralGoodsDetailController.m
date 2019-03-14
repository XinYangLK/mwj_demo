//
//  KLIntegralGoodsDetailController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLIntegralGoodsDetailController.h"
#import "KLMallBannerCell.h"
#import "KLIntegralGoodsDetailCell.h"
#import <WebKit/WebKit.h>


@interface KLIntegralGoodsDetailController ()
<
UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate,
WKNavigationDelegate
>
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * goodsBannerImgArray;
//***  商品详情web  **/
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation KLIntegralGoodsDetailController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"实木木马红木胡桃木"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cocoachina.com"]]];
}


//***  加载web  **/
- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectZero];
        _webView.scrollView.scrollEnabled = YES;
        _webView.navigationDelegate = self;
      
    }
    return _webView;
}


- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h  = MainHeight - StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLMallBannerCell class]);
        _tableView.mCustomClass([KLIntegralGoodsDetailCell class]);
        _tableView.mCustomClass([UITableViewCell class]);
        _tableView.mCustomClass([KLIntegralGoodsWebCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        KLMallBannerCell * cell = kCellIdentifier(KLMallBannerCell);
        cell.carouselView.imageURLStringsGroup = self.goodsBannerImgArray;
        cell.carouselView.delegate =self;
        return cell;
        
    }else if(indexPath.row == 1){
     
        KLIntegralGoodsDetailCell *cell = kCellIdentifier(KLIntegralGoodsDetailCell);
        cell.titleLab.text = @"实木木马红木胡桃木";
        cell.numLab.text =@"100萌豆";
        return cell;
        
    }else if (indexPath.row == 2){
        
        UITableViewCell *cell = kCellIdentifier(UITableViewCell);
        cell.textLabel.text =@"商品详情";
        cell.textLabel.font =kFont_15;
        cell.textLabel.textColor = RGBSigle(51);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }else {
        
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell.contentView addSubview:_webView];
            /* 忽略点击效果 */
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 0) {
        
        return AdaptedHeight(251);
        
    }else if (indexPath.row == 1){
        
        return AdaptedHeight(132);
        
    }else if (indexPath.row == 2){
        
        return AdaptedHeight(51);
        
    }else{
        
        return self.webView.frame.size.height+5;;
    }
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




#pragma mark - webviewdelegate
// 页面加载完成之后调用 此方法会调用多次
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    __block CGFloat webViewHeight;
    //获取内容实际高度（像素）@"document.getElementById(\"content\").offsetHeight;"
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result,NSError * _Nullable error) {
        // 此处js字符串采用scrollHeight而不是offsetHeight是因为后者并获取不到高度，看参考资料说是对于加载html字符串的情况下使用后者可以(@"document.getElementById(\"content\").offsetHeight;")，但如果是和我一样直接加载原站内容使用前者更合适
        //获取页面高度，并重置webview的frame
        webViewHeight = [result doubleValue];
        webView.height = webViewHeight;
        
        self.webView.frame = CGRectMake(0,0, MainWidth, webView.top + webViewHeight + 10);
        
        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:3 inSection:0];
        @weakify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        });
    }];
}



#pragma mark - 轮播图点击事件delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    [self lookImageArray:self.goodsBannerImgArray index:index];
}

//*** 将图片数组加入图片浏览器  **/
- (void)lookImageArray:(NSMutableArray *)imageArray index:(NSInteger)index{
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i < imageArray.count; i++) {
        NSString *urlStr = [imageArray[i] stringByReplacingOccurrencesOfString:@"bmiddle" withString:@"large"];
        //KSPhotoItem *item = [KSPhotoItem itemWithSourceView:nil imageUrl:[NSURL URLWithString:urlStr]];
        KSPhotoItem *item =[KSPhotoItem itemWithSourceView:nil image:[UIImage imageNamed:urlStr]];
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


#pragma mark - 数据源

- (NSMutableArray *)goodsBannerImgArray {
    if (!_goodsBannerImgArray){
        _goodsBannerImgArray = [NSMutableArray arrayWithObjects:@"1_sdgvxc",@"2_sdgvxc",@"3_sdgvxc", nil];
    }
    return _goodsBannerImgArray;
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
