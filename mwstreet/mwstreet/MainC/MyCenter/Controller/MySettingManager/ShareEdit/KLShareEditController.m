//
//  KLShareEditController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLShareEditController.h"
#import "KLMyShareTextView.h"

@interface KLShareEditController ()

@property (nonatomic, strong) UILabel  * titleLab;
@property (nonatomic, strong) KLMyShareTextView *shareTextView;
@property (nonatomic, copy)   NSString * textViewStr;

@end

@implementation KLShareEditController

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



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];
    [self titleLab];
    [self shareTextView];
}


//*** 发送 自定义分享语  **/
- (void)right_button_event:(UIButton *)sender {
    
    KLLog(@"------发送");
}



#pragma mark - lazy UI
//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:MainColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = kFont_15;
    return rightBtn;
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:15
                                            lines:1
                                             text:@"自定义分享语"
                                        textColor:RGBSigle(51)
                                        superView:self.view
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset   = AdaptedWidth(12);
                                          make.right.offset  = AdaptedWidth(-12);
                                          make.top.offset    = AdaptedHeight(17);
                                          make.height.offset = AdaptedHeight(15);
                                      }];
    }
    return _titleLab;
}



- (KLMyShareTextView *)shareTextView {
    
    if (!_shareTextView){
        _shareTextView = [[KLMyShareTextView alloc]initWithFrame:CGRectMake(AdaptedWidth(22), AdaptedHeight(62), MainWidth-AdaptedWidth(44), AdaptedHeight(134))];
        [_shareTextView wy_automaticFollowKeyboard:self.view];
        _shareTextView.textView.backgroundColor = BackgroundColor;
        klWeakSelf;
        _shareTextView.textViewBlock = ^(NSString * _Nonnull text) {
            weakSelf.textViewStr = text;
        };
        [self.view addSubview:_shareTextView];
    }
    return _shareTextView;
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
