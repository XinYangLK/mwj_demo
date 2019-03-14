//
//  SQFiltrateView.h
//  FiltrateView
//
//  Created by quanminqianbao on 2017/12/7.
//  Copyright © 2017年 yangshuquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQCustomButton.h"

OS_ASSUME_NONNULL_BEGIN


//筛选列表的类型
typedef NS_ENUM(NSInteger, OptionListType) {
    OptionListType_Tag,    //标签
    OptionListType_Cell,   //列表
};

typedef NS_ENUM(NSInteger, OptionNumberType) {
    OptionNumberType_Single,//单选
    OptionNumberType_Many,//多选
};

@interface SQFiltrateItem:NSObject

@property (nonatomic, assign) OptionListType listType;
@property (nonatomic, assign) OptionNumberType numberType;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *optionData;
//@property (nonatomic, strong) NSString *key;//该字段可以自定义，用来标识

//
@property (nonatomic, strong) UIView * bg_View;
@property (nonatomic, strong)UIScrollView * backView;
//@property (nonatomic, strong) UIScrollView *bg_View;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) CGFloat bg_ViewHeight;
@property (nonatomic, strong) SQCustomButton *button;
@property (nonatomic, strong) NSArray *listCellViews;
@property (nonatomic, strong) NSMutableSet *choseSet;//

@end



@interface SQFiltrateView : UIView

@property (nonatomic, strong) void(^touchBlock)(SQFiltrateView *view,SQFiltrateItem *item);
@property (nonatomic, strong) NSArray *filtrateItems;
- (instancetype)initWithFrame:(CGRect)frame filtrateItems:(NSArray <SQFiltrateItem *>*)filtrateItems;
- (void)touchBlock:(void(^)(SQFiltrateView *view,SQFiltrateItem *item))block;
//隐藏所有选项
- (void)hideAllItemView;

OS_ASSUME_NONNULL_END
@end

