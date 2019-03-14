//
//  AddNumView.h
//  TDS
//
//  Created by admin on 16/4/18.
//  Copyright © 2016年 sixgui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddNumViewDelegate <NSObject>

-(void)AddNumView:(UIView *)view;

@end

@interface BVAddNumView : UIView

@property (nonatomic, weak) id<AddNumViewDelegate>delegate;
// 减少数量按钮
@property (nonatomic ,strong) UIButton *minusBtn;
// 增加数量按钮
@property (nonatomic ,strong)  UIButton *addBtn;
// 商品数量Label
@property (nonatomic ,strong) UILabel *numLabel;
// 商品数量
@property (nonatomic ,assign) NSInteger num;

@property (nonatomic ,assign) NSInteger numInteger;

@property (nonatomic ,assign) NSInteger minInteget;

@property (nonatomic ,copy) NSString *size;

@end
