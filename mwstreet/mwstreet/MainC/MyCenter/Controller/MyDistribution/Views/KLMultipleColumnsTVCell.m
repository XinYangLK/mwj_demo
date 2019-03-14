//
//  KLMultipleColumnsTVCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/1.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMultipleColumnsTVCell.h"

@interface KLMultipleColumnsTVCell ()

@property (nonatomic,assign) NSInteger columns;

@end

@implementation KLMultipleColumnsTVCell

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 0;
        
        self.backgroundColor = [UIColor whiteColor];

        [self loadCreateViewLayout];
        
    }
    return self;
}

-(instancetype)init{
    if ([super init]) {
        [self loadCreateViewLayout];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self loadCreateViewLayout];
}

//设置页面布局
- (void) loadCreateViewLayout{
    
    CGRect mainScreen = [UIScreen mainScreen].bounds;
    if (mainScreen.size.width == 320) {
        self.columns = 3;
    }else{
        self.columns = 4;
    }
}
-(void)setDataArrayCount:(NSInteger)dataArrayCount{
    _dataArrayCount = dataArrayCount;
    self.cellHeight = [self heightForCount:_dataArrayCount];
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}


-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self loadCreateScratchableLatex];
}

//创建九宫格---
- (void)loadCreateScratchableLatex {
    
    if (self.dataArray.count <= 0) {
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        label.text = @"暂无数据";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        [self addSubview:label];
        
    }else{
        
       
        for (NSInteger i = 0; i < self.dataArray.count ; i++) {
            
            UIButton * selectBtn = [[UIButton alloc] initWithFrame:[self frameForItemIndex:i]];
            [selectBtn setTitle:self.dataArray[i] forState:UIControlStateNormal];
            [selectBtn setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
            [selectBtn setImage:[UIImage imageNamed:self.imgArray[i]] forState:UIControlStateNormal];
            selectBtn.titleLabel.font = kFont_14;
            [selectBtn setImagePositionWithType:SSImagePositionTypeTop spacing:10];
            [selectBtn setLayerCornerRadius:0 borderWidth:0.5 borderColor:LineColor];
            [selectBtn addTarget:self action:@selector(clickBtnAct:) forControlEvents:UIControlEventTouchUpInside];
            selectBtn.tag = i+100;
            [self addSubview:selectBtn];
    
        }
    }
}

//btn的点击响应事件
- (void)clickBtnAct:(UIButton *)sender {
    
    self.ReturnClickItemIndex(self.indexPath, sender.tag - 100);
}

//计算每个UIButton的frame
-(CGRect)frameForItemIndex:(NSInteger)count{
    
    //每个图片的宽度
    CGFloat itemW = (MainWidth - (self.columns+1)* self.minimumInteritemSpacing)/self.columns;
    //计算xy轴的坐标
    CGFloat x = count%self.columns*itemW +self.minimumInteritemSpacing *(count%self.columns+1);
    CGFloat y = count/self.columns* AdaptedHeight(76) +self.minimumLineSpacing *(count/self.columns+1);
    
    return CGRectMake(x, y, itemW, AdaptedHeight(76));
}

//根据数据计算高度
-(CGFloat)heightForCount:(NSInteger)count{
    
    //计算行数
    long row = count/self.columns;
    
    if (count%self.columns != 0) {
        
        row++;
    }
    
    //每个图片的宽度
    //    CGFloat itemW = (kViewWidth - (self.columns+1)*kJianXi)/self.columns;
    CGFloat height = AdaptedHeight(76) * row +self.minimumLineSpacing*(row+1);
    
    return height;
}


@end
