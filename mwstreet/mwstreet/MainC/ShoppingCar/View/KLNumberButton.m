//
//  KLNumberButton.m
//  mwstreet
//
//  Created by 科pro on 2019/1/24.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLNumberButton.h"

@interface KLNumberButton ()
/** 记录最终选中的个数*/
@property (nonatomic,assign)NSInteger  addCount;
@end

@implementation KLNumberButton

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        
        self.addCount = 1;
        
        [self setLayerCornerRadius:12 borderWidth:1 borderColor:LineColor];

        [self minusLab];
        [self plusLab];

        [self numLab];
        
     
    }
    return self;
}

- (void)leftClick:(UITapGestureRecognizer *)tap {
    NSInteger count = [self.numLab.text integerValue];
    count--;
    if (count<=0){
        count = 1;
        return;
    }
    [self clickLeftOrRight:self.minusLab count:count];
}

- (void)rightClick:(UITapGestureRecognizer *)tap {
    NSInteger count = [self.numLab.text integerValue];
    count++;
    [self clickLeftOrRight:self.plusLab count:count];
}
- (void)centerClick:(UITapGestureRecognizer *)tap {
    
    self.numberBlock ? self.numberBlock(self.numLab) : nil;
}

/** 计算最终的商品个数*/
-(void)clickLeftOrRight:(id)obj count:(NSInteger)count{
    
    if ([obj isKindOfClass:[UILabel class]]) {
        self.numLab.text = [NSString stringWithFormat:@"%zd",count];
    }
    
//    self.cdModel.cdChooseCount = [NSString stringWithFormat:@"%zd",self.addCount];
    
//    self.showNowPrice.text = [NSString stringWithFormat:@"%zdx%@",self.addCount,self.cdModel.cdPrice];
    
//    if ([self.delegate respondsToSelector:@selector(clickLeftReduceOrRightAddGetTotalMoney)]) {
//        [self.delegate clickLeftReduceOrRightAddGetTotalMoney];
//    }
}




- (UILabel *)minusLab {
    if (!_minusLab){
        _minusLab = [UILabel zj_labelWithFont:kFont_12
                                        lines:1
                                         text:@"－"
                                    textColor:TitleColor
                                    superView:self
                                  constraints:^(MASConstraintMaker *make) {
                                      make.left.height.centerY.mas_equalTo(self);
                                      make.width.offset =AdaptedWidth(30);
                                  }];
        _minusLab.textAlignment =NSTextAlignmentCenter;
        _minusLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftClick:)];
        [_minusLab addGestureRecognizer:tapLeft];
    }
    return _minusLab;
}


- (UILabel *)numLab {
    if (!_numLab){
        _numLab = [UILabel zj_labelWithFont:kFont_12
                                      lines:1
                                       text:[@(self.addCount) stringValue]
                                  textColor:TitleColor
                                  superView:self
                                constraints:^(MASConstraintMaker *make) {
                                    make.left.mas_equalTo(self.minusLab.mas_right);
                                    make.right.mas_equalTo(self.plusLab.mas_left);
                                    make.centerY.height.mas_equalTo(self);
                                }];
        _numLab.textAlignment =NSTextAlignmentCenter;
        [_numLab setLayerCornerRadius:0 borderWidth:1 borderColor:LineColor];
        _numLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapCenter = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerClick:)];
        [_numLab addGestureRecognizer:tapCenter];
    }
    return _numLab;
}


- (UILabel *)plusLab {
    if (!_plusLab){
        _plusLab = [UILabel zj_labelWithFont:kFont_12
                                       lines:1
                                        text:@"＋"
                                   textColor:TitleColor
                                   superView:self
                                 constraints:^(MASConstraintMaker *make) {
                                     make.right.height.centerY.equalTo(self);
                                     make.width.mas_equalTo(self.minusLab);
                                 }];
        _plusLab.textAlignment =NSTextAlignmentCenter;
        _plusLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRight = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightClick:)];
        [_plusLab addGestureRecognizer:tapRight];
    }
    return _plusLab;
}



@end
