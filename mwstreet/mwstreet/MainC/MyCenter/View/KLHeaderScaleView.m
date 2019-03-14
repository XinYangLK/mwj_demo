//
//  KLHeaderScaleView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/18.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLHeaderScaleView.h"
#import "KLHeaderButton.h"

@interface KLHeaderScaleView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, assign) CGPoint prePoint;

//***  背景图 **/
@property (nonatomic, strong) UIImageView * backGroundImg;
//***  用户图像 **/
@property (nonatomic, strong) UIImageView * accoutImg;
//*** 昵称lab **/
@property (nonatomic, strong) UILabel     * accoutName;
//*** 电话 **/
@property (nonatomic, strong) UILabel     * accoutPhone;
//*** 积分 **/
@property (nonatomic, strong) KLHeaderButton * scoreBtn;
//*** 余额 **/
@property (nonatomic, strong) KLHeaderButton * balanceBtn;
//*** 优惠券 **/
@property (nonatomic, strong) KLHeaderButton * couponsBtn;
//*** 昵称str **/
@property (nonatomic, strong) NSString       *  nameTitle;


@end

@implementation KLHeaderScaleView
- (id)initWithFrame:(CGRect)frame title:(NSString *__nullable)title telPhone:(NSString *__nullable )phone
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.nameTitle = title;

        _backGroundImg =[[UIImageView alloc]initWithFrame:self.frame];
        _backGroundImg.image =[UIImage imageNamed:@"beijing"];
        [self addSubview:self.backGroundImg];
        
        
        _accoutImg =[[UIImageView alloc]initWithFrame:CGRectMake(MainWidth/2-AdaptedHeight(26), StatusBarHeight + 21, AdaptedHeight(52), AdaptedHeight(52))];
        _accoutImg.image =[UIImage imageNamed:@"touxiang"];
        [self addSubview:_accoutImg];
        
        CGFloat nameX =AdaptedWidth(30);
        CGFloat nameY = CGRectGetMaxY(_accoutImg.frame) + AdaptedHeight(20);
        CGFloat nameW =MainWidth-AdaptedWidth(60);
        CGFloat nameH =AdaptedHeight(14);
        _accoutName =[UILabel zj_labelWithFrame:CGRectMake(nameX,nameY,nameW,nameH)
                                           text:[NSString isBlankString:title]?@"立即登录":title
                                       fontSize:16
                                         isBold:NO
                                      textColor:[UIColor whiteColor]
                                   textAligment:NSTextAlignmentCenter
                                       numLines:1];
        [self addSubview:_accoutName];
        
        if (![NSString isBlankString:phone] && ![NSString isBlankString:title]) {
            CGFloat phoneY = CGRectGetMaxY(_accoutName.frame) + AdaptedHeight(11);
            _accoutPhone =[UILabel zj_labelWithFrame:CGRectMake(AdaptedWidth(30), phoneY, MainWidth-AdaptedWidth(60), AdaptedHeight(15)) text:phone fontSize:16 isBold:NO textColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter numLines:1];
            [self addSubview:_accoutPhone];
        }
       
      
        
        CGFloat w = (MainWidth-AdaptedWidth(40))/3;
        CGFloat y = self.height - AdaptedHeight(70);
        self.scoreBtn.frame =CGRectMake(AdaptedWidth(10), y, w, AdaptedHeight(40));
        self.balanceBtn.frame =CGRectMake(CGRectGetMaxX(self.scoreBtn.frame)+ AdaptedWidth(10), y, w, AdaptedHeight(40));
        self.couponsBtn.frame =CGRectMake(CGRectGetMaxX(self.balanceBtn.frame)+ AdaptedWidth(10), y, w, AdaptedHeight(40));
        
        [self addSubview:self.scoreBtn];
        [self addSubview:self.balanceBtn];
        [self addSubview:self.couponsBtn];
    }
    
    return self;
}


//***  表头按钮点击事件 tag == 230 - 232 **/
- (void)headerBtnChick:(KLHeaderButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHeaderBtnChick:)]) {
        [self.delegate didHeaderBtnChick:(long)sender.tag];
    }
    
}

//***  点击背景响应  **/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([NSString isBlankString:self.nameTitle]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didHeaderBtnChick:)]) {
            [self.delegate didHeaderBtnChick:(long)229];
        }
    }else {
        KLLog(@"已登录状态");
    }
}



-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:Nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0 ,0 , 0);
    self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    CGPoint newOffset = [change[@"new"] CGPointValue];
    [self updateSubViewsWithScrollOffset:newOffset];
    
}

-(void)updateSubViewsWithScrollOffset:(CGPoint)newOffset
{

    CGFloat destinaOffset = - StatusBarAndNavigationBarHeight;
    CGFloat startChangeOffset = -self.scrollView.contentInset.top;
    newOffset = CGPointMake(newOffset.x, newOffset.y<startChangeOffset?startChangeOffset:(newOffset.y>destinaOffset?destinaOffset:newOffset.y));
    
    CGFloat subviewOffset = self.frame.size.height - StatusBarHeight; // 子视图的偏移量
    CGFloat newY = -newOffset.y-self.scrollView.contentInset.top;
    CGFloat d = destinaOffset-startChangeOffset;
    CGFloat alpha = 1-(newOffset.y-startChangeOffset)/d;
    CGFloat imageReduce = 1-(newOffset.y-startChangeOffset)/((d + 27.5)*2);
    
    
    self.frame = CGRectMake(0, newY, self.frame.size.width, self.frame.size.height);
   
    CGFloat redu = MainHeight >= 667 ? 0.50f : 0.495f;
    CGFloat reduc = MainHeight > 568 ? redu : 0.515f;
    CGFloat reduce = (kDevice_Is_iPhoneX) ? 0.46 : reduc;
    
    CGAffineTransform t = CGAffineTransformMakeTranslation(newY*0.14 ,(subviewOffset-reduce*self.frame.size.height)*(1-alpha));
    
    CGAffineTransform t3 = CGAffineTransformScale(t,imageReduce, imageReduce);
    
    self.accoutImg.transform = CGAffineTransformConcat (t, t3);
    self.accoutName.transform = CGAffineTransformMakeTranslation(-newY*0.5,(subviewOffset-0.73f*self.frame.size.height)*(1-alpha));
    self.accoutPhone.transform = CGAffineTransformMakeTranslation(-newY*0.5,(subviewOffset-0.73f*self.frame.size.height)*(1-alpha));
    
    self.backgroundColor = MainAlphaColor(1-alpha);
    
    self.backGroundImg.alpha = alpha;
    self.accoutPhone.alpha   = alpha;
    self.accoutName.alpha    = alpha;
    
    self.scoreBtn.alpha      = alpha;
    self.balanceBtn.alpha    = alpha;
    self.couponsBtn.alpha    = alpha;
    
}

















- (KLHeaderButton *)scoreBtn {
    if (!_scoreBtn){
        _scoreBtn = [[KLHeaderButton alloc]init];
        _scoreBtn.textLab.text =@"萌豆";
        _scoreBtn.numLab.text =@"0";
        _scoreBtn.tag = 230;
        [_scoreBtn addTarget:self action:@selector(headerBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scoreBtn;
}

- (KLHeaderButton *)balanceBtn {
    if (!_balanceBtn){
        _balanceBtn = [[KLHeaderButton alloc]init];
        _balanceBtn.textLab.text =@"收藏夹";
        _balanceBtn.numLab.text =@"0";
        _balanceBtn.tag = 231;
        [_balanceBtn addTarget:self action:@selector(headerBtnChick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _balanceBtn;
}

- (KLHeaderButton *)couponsBtn {
    if (!_couponsBtn){
        _couponsBtn = [[KLHeaderButton alloc]init];
        _couponsBtn.textLab.text =@"优惠券";
        _couponsBtn.numLab.text =@"0";
        _couponsBtn.tag = 232;
        [_couponsBtn addTarget:self action:@selector(headerBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _couponsBtn;
}




- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}



@end
