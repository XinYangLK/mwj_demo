//
//  AddNumView.m
//  TDS
//
//  Created by admin on 16/4/18.
//  Copyright © 2016年 sixgui. All rights reserved.
//

#import "BVAddNumView.h"
//#import "Header.h"

@implementation BVAddNumView

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _num = 1;
        self.backgroundColor = RGBA(251, 251, 251, 1.0);
        [self setLayerCornerRadius:0 borderWidth:0.5 borderColor:LineColor];
        
        self.minusBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, frame.size.height)];
        [self.minusBtn setTitle:@"-" forState:UIControlStateNormal];
        [self.minusBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.minusBtn.titleLabel.font = [UIFont systemFontOfSize:37.0];
        [self.minusBtn addTarget:self action:@selector(MinusBtn:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.minusBtn];
        
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, (frame.size.height - 18)/2, 35, 18)];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.textColor = TitleColor;
        _numLabel.font = kFont_14;
        [self addSubview:_numLabel];
        

        self.addBtn = [[UIButton alloc] initWithFrame:CGRectMake(64, 0, 32, frame.size.height)];
        [self.addBtn setTitle:@"+" forState:UIControlStateNormal];
        [self.addBtn setTitleColor:RGBA(51, 51, 51, 1.0) forState:UIControlStateNormal];
        self.addBtn.titleLabel.font = [UIFont systemFontOfSize:25.0];
        [self.addBtn addTarget:self action:@selector(AddBtn:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.addBtn];
        
    }
    return self;
}

-(void)MinusBtn:(UIButton *)sender{

    if (_num <= 0) {
        NSLog(@"超出范围");
    }else{
        _num  = _num -1;
    }
    
    _numLabel.text = [NSString stringWithFormat:@"%ld",(long)_num];
    [_delegate AddNumView:self];
}

-(void)AddBtn:(UIButton *)sender{
    
    if (_num >= 1000) {
        NSLog(@"超出范围");
    }else{
        _num = _num +1;
    }
    
    _numLabel.text = [NSString stringWithFormat:@"%ld",(long)_num];
    [_delegate AddNumView:self];
}

-(void)setNumInteger:(NSInteger)numInteger{

    _numInteger = numInteger;
     _numLabel.text = [NSString stringWithFormat:@"%ld",(long)_numInteger];
    _num = _numInteger;
}

-(void)setMinInteget:(NSInteger)minInteget{

    _minInteget = minInteget;
    if (_minInteget == 0) {
      
        _numLabel.text = @"0";
        _num = 0;
        
    }else if (_minInteget<=[_numLabel.text integerValue]){
    
        _numLabel.text = [NSString stringWithFormat:@"%ld",(long)_minInteget];
        _num = _minInteget;
    }
}

-(void)setNum:(NSInteger)num{
    _num = num;
    _numLabel.text = [NSString stringWithFormat:@"%ld",(long)_num];
}

@end
