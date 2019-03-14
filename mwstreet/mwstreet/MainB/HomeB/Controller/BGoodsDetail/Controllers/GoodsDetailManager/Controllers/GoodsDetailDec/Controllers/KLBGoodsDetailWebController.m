//
//  KLBGoodsDetailWebController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/27.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBGoodsDetailWebController.h"
#import <WebKit/WebKit.h>

@interface KLBGoodsDetailWebController ()
<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation KLBGoodsDetailWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cocoachina.com"]]];

    [self.view addSubview:self.webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset = 0;
        make.height.offset =MainHeight - StatusBarAndNavigationBarHeight-AdaptedHeight(40);
    }];}

//***  加载web  **/
- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectZero];
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled = YES;
        
    }
    return _webView;
}

#pragma mark - webviewdelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [EasyLoadingView showLoadingText:@"正在加载..."];
}


-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [EasyLoadingView hidenLoading];

}
// 页面加载完成之后调用 此方法会调用多次
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
     [EasyLoadingView hidenLoading];
//    __block CGFloat webViewHeight;
//    //获取内容实际高度（像素）@"document.getElementById(\"content\").offsetHeight;"
//    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result,NSError * _Nullable error) {
//        // 此处js字符串采用scrollHeight而不是offsetHeight是因为后者并获取不到高度，看参考资料说是对于加载html字符串的情况下使用后者可以(@"document.getElementById(\"content\").offsetHeight;")，但如果是和我一样直接加载原站内容使用前者更合适
//        //获取页面高度，并重置webview的frame
//        webViewHeight = [result doubleValue];
//        webView.height = webViewHeight;
//        
//        self.webView.frame = CGRectMake(0,0, MainWidth, webView.top + webViewHeight + 10);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSIndexPath * insdexPath =[NSIndexPath indexPathForRow:1 inSection:2];
//            [self.tableView reloadRowsAtIndexPaths:@[insdexPath] withRowAnimation:UITableViewRowAnimationNone];
//        });
//    }];
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
