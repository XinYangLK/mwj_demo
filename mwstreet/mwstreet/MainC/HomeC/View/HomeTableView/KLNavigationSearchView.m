//
//  KLNavigationSearchView.m
//  mwstreet
//
//  Created by 科pro on 2018/12/19.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLNavigationSearchView.h"

@implementation KLSearchBar

-(void)layoutSubviews{
    
    for (UIView *view in self.subviews) {
        
        for (UIView *subView in view.subviews) {
            
            if ([subView isKindOfClass:[UITextField class]]) {
                CGFloat h = (kDevice_Is_iPhoneX) ? 35 : 30 ;
                subView.frame = CGRectMake(0, 0, self.frame.size.width,h);
            }
        }
    }
}

@end



@implementation KLNavigationSearchView

+ (instancetype)creatNavigationView {
    
    static KLNavigationSearchView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return  shareInstance;
}
   
- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self creatNavigationUI];
    }
    return self;
}

//***  加载自定义navigationView 上控件  **/
- (void)creatNavigationUI{
    
    [self addSubview:self.loctionBtn];
    [self addSubview:self.searchView];
    [self addSubview:self.messageBtn];
    [self addSubview:self.shadowLine];
    
    [self.loctionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.height.offset =AdaptedHeight(30);
        make.top.offset = StatusBarHeight + ((kDevice_Is_iPhoneX) ? 0.0f : 5.0f) ;
        make.width.offset =AdaptedWidth(70);
    }];
    CGFloat h = (kDevice_Is_iPhoneX) ? 35 : 30 ;

    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loctionBtn.mas_right).offset =AdaptedWidth(5);
        make.height.offset = h;
        make.centerY.mas_equalTo(self.loctionBtn);
        make.right.offset = -AdaptedWidth(55);
    }];
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset =AdaptedWidth(-15);
        make.width.offset =AdaptedWidth(25);
        make.height.offset =AdaptedHeight(25);
        make.centerY.mas_equalTo(self.loctionBtn);
    }];
    [self.shadowLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset =0;
        make.height.offset =0.5f;
    }];
    
}


- (void)messageBtnAction:(UIButton *)sender {
    
    KLLog(@" 消息 ");
    
}



#pragma mark ------UI lazy  加载子控件
//***  定位按钮  **/
- (UIButton *)loctionBtn {
    if (!_loctionBtn){
        klWeakSelf;
        _loctionBtn = [UIButton createBtnTitle:@"定位"
                                    titleColor:RGBSigle(51)
                                          font:kFont_13
                                     imageName:@"loction"
                                backgrounColor:[UIColor clearColor]
                           SSImagePositionType:SSImagePositionTypeLeft
                                       spacing:6
                                        action:^(UIButton * _Nonnull button) {

                                            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(loctionCityBtn:)]) {
                                                [weakSelf.delegate loctionCityBtn:button];
                                            }
                                            
                                        }];
    }
    return _loctionBtn;
}

//***  搜索框  **/
- (KLSearchBar *)searchView {
    if (!_searchView) {
        _searchView = [[KLSearchBar alloc]init];
        _searchView.backgroundImage = [[UIImage alloc] init];
        _searchView.placeholder = @"搜索热门国家/地区";
        _searchView.tintColor =[UIColor whiteColor];
        UITextField *searchField = [_searchView valueForKey:@"searchField"];
        if (searchField) {
            [searchField setBorderStyle:UITextBorderStyleRoundedRect];
            //自定义放大镜图片
            CGFloat y = (kDevice_Is_iPhoneX) ? 10 : 6 ;

            UIImage *image = [UIImage imageNamed: @"search"];
            UIImageView *iView = [[UIImageView alloc] initWithImage:image];
            iView.frame = CGRectMake(10, y, 14, 14);
            searchField.leftView.hidden = YES;
            [searchField addSubview:iView];
            [searchField setValue:TextColor forKeyPath:@"_placeholderLabel.textColor"];   //修改placeholder的颜色
            [searchField setBackgroundColor:RGBSigle(242)];
            searchField.font =kFont_14;
            searchField.textColor =TitleColor;
            searchField.tintColor =MainColor;
        }
    }
    return _searchView;
}


//***  消息按钮  **/
- (UIButton *)messageBtn {
    if (!_messageBtn){
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageBtn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
        [_messageBtn addTarget:self action:@selector(messageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}

- (UIImageView *)shadowLine {
    if (!_shadowLine){
        _shadowLine = [[UIImageView alloc]init];
        _shadowLine.backgroundColor = COLOR(@"cccccc");
    }
    return _shadowLine;
}

@end
