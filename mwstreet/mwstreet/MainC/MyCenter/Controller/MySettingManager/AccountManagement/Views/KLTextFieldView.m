//
//  KLTextFieldView.m
//  mwstreet
//
//  Created by 科pro on 2019/2/20.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLTextFieldView.h"

@implementation KLTextFieldView

static const CGFloat lineWidth = 1;

-(instancetype)initWithFrame:(CGRect)frame type:(TextFieldType)type{
    if(self = [super initWithFrame:frame]){
       
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        _lineView.backgroundColor = RGBSigle(240);
        [self addSubview:_lineView];
        
        _lineLayer = [CALayer layer];
        _lineLayer.frame = CGRectMake(0,0, 0, lineWidth);
        _lineLayer.anchorPoint = CGPointMake(0, 0.5);
        _lineLayer.backgroundColor = MainColor.CGColor;
        [_lineView.layer addSublayer:_lineLayer];
        
        
        _textField = [[UITextField alloc]initWithFrame:CGRectZero];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.font = AdaptedSYSFontSize(14);
        _textField.clearButtonMode =UITextFieldViewModeWhileEditing;
        _textField.textColor = [UIColor blackColor];
        _textField.tintColor = MainColor;
        [self addSubview:self.textField];
        
        if (type == TextFieldVerificationType) {
          
            _verBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            [_verBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            _verBtn.titleLabel.font =kFont_14;
            [_verBtn setTitleColor:MainColor forState:UIControlStateNormal];
            [self addSubview:_verBtn];
            
            _line =[[UILabel alloc]init];
            _line.backgroundColor = LineColor;
            [self addSubview:_line];
            
            _timeCount =60;
            _tipLab =[[UILabel alloc]init];
            _tipLab.textAlignment =NSTextAlignmentCenter;
            _tipLab.font =kFont_12;
            _tipLab.hidden =YES;
            _tipLab.textColor = TextColor;
            [self addSubview:_tipLab];
            
        }else if (type == TextFieldPasswordType){
            
            _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_lookBtn setImage:[UIImage imageNamed:@"bishangyanjing"] forState:UIControlStateNormal];
            [self addSubview:_lookBtn];
        }
    }
    return self;
}



-(void)layoutSubviews{
    [super layoutSubviews];

    _lineView.frame = CGRectMake(0, CGRectGetHeight(self.frame)-lineWidth, CGRectGetWidth(self.frame), lineWidth);
    
    CGFloat h =CGRectGetHeight(self.frame)-lineWidth;
    
    if (self.type == TextFieldDefaultType) {
        
        CGFloat w =CGRectGetWidth(self.frame)-AdaptedWidth(25);
        self.textField.frame = CGRectMake(AdaptedWidth(5), 0, w, h);
        
    }else if(self.type == TextFieldVerificationType){
        
        CGFloat w =CGRectGetWidth(self.frame)-AdaptedWidth(135);
        _textField.frame = CGRectMake(AdaptedWidth(5), 0, w, h);
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.textField.mas_right).offset =AdaptedWidth(4);
            make.centerY.offset =0;
            make.width.offset =1;
            make.height.offset =AdaptedHeight(25);
        }];
        
        [_verBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset =AdaptedWidth(0);
            make.height.offset =AdaptedHeight(30);
            make.width.offset =AdaptedWidth(100);
            make.centerY.offset =0;
        }];
        
        [_tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset =AdaptedWidth(0);
            make.height.offset =AdaptedHeight(30);
            make.width.offset =AdaptedWidth(100);
            make.centerY.offset =0;
        }];
        
    }else if(self.type == TextFieldPasswordType){
        
        CGFloat w =CGRectGetWidth(self.frame)-AdaptedWidth(47);
        _textField.frame = CGRectMake(AdaptedWidth(5), 0, w, h);
        
        [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset =AdaptedWidth(-12);
            make.width.height.offset =AdaptedHeight(30);
            make.centerY.offset =0;
        }];
    }
}


-(void)moveLineAnimation{
    @weakify(self)
    [UIView animateWithDuration:0.15 animations:^{
         @strongify(self)
        self.lineLayer.bounds = CGRectMake(0, 0, 0, lineWidth);
    }];
}

- (void)addLineAnmation{
    @weakify(self)
    [UIView animateWithDuration:0.15 animations:^{
         @strongify(self)
        self.lineLayer.bounds = CGRectMake(0, 0, CGRectGetWidth(self.frame), lineWidth);
    }];
}


#pragma mark-->读秒开始
-(void)readSecond{
    _verBtn.hidden=YES;
    _tipLab.hidden=NO;
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
    _timer.fireDate=[NSDate distantPast];
}

#pragma mark-->跑秒操作
-(void)dealTimer{
    _tipLab.text=[[NSString alloc]initWithFormat:@"(%lds)后重新获取",(long)_timeCount];
    _timeCount=_timeCount - 1;
    if(_timeCount== -1){
        _timer.fireDate=[NSDate distantFuture];
        _timeCount= 60;
        _tipLab.hidden=YES;
        _verBtn.hidden=NO;
    }
}


@end
