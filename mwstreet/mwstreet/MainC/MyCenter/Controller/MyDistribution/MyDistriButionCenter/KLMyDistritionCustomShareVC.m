//
//  KLMyDistritionCustomShareVC.m
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyDistritionCustomShareVC.h"
#import "KLMyShareTextView.h"

@interface KLMyDistritionCustomShareVC ()

@property (nonatomic, strong) KLMyShareTextView * shareTextView;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, copy) NSString * textViewStr;
@end

@implementation KLMyDistritionCustomShareVC

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"自定义分享语"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [super viewWillDisappear:animated];
    [self.shareTextView.textView resignFirstResponder];
}


#pragma mark - 分享按钮响应
- (void)didShareBtnChick:(UIButton *)sender {
    
    //***  过滤空格  **/
    NSString * textViewSting = [NSString getWithFilteringStringSpace:self.textViewStr];
    //***  过滤换行  **/
    NSString *textStr =[textViewSting stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    KLLog(@"输入的文本是：%@",textStr);

}


#pragma mark - lazy UI
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];
    [self shareTextView];
    [self shareBtn];
}

- (KLMyShareTextView *)shareTextView {
    
    if (!_shareTextView){
        _shareTextView = [[KLMyShareTextView alloc]initWithFrame:CGRectMake(AdaptedWidth(22), AdaptedHeight(10), MainWidth-AdaptedWidth(44), AdaptedHeight(134))];
        [_shareTextView wy_automaticFollowKeyboard:self.view];
        [_shareTextView setLayerCornerRadius:5.0f borderWidth:0.5f borderColor:MainColor];
        klWeakSelf;
        _shareTextView.textViewBlock = ^(NSString * _Nonnull text) {
            weakSelf.textViewStr = text;
        };
        [self.view addSubview:_shareTextView];
       
    }
    return _shareTextView;
}


- (UIButton *)shareBtn {
    if (!_shareBtn){
        klWeakSelf;
        _shareBtn = [UIButton createBtnTitle:@"分享"
                                  titleColor:[UIColor whiteColor]
                                        font:kFont_14
                                   imageName:@""
                              backgrounColor:BMainColor
                                      action:^(UIButton * _Nonnull button) {
                                          [weakSelf.shareTextView.textView resignFirstResponder];
                                          [weakSelf didShareBtnChick:button];
                                      }];
        [self.view addSubview:_shareBtn];
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.shareTextView.mas_bottom).offset =AdaptedHeight(11);
            make.right.mas_equalTo(self.shareTextView);
            make.height.offset =AdaptedHeight(25);
            make.width.offset =AdaptedWidth(65);
        }];
    }
    return _shareBtn;
}




- (void)dealloc {
    [self.view wy_releaseKeyboardNotification];
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
