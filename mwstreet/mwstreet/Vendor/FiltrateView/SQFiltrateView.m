//
//  SQFiltrateView.m
//  FiltrateView
//
//  Created by quanminqianbao on 2017/12/7.
//  Copyright © 2017年 yangshuquan. All rights reserved.
//

#import "SQFiltrateView.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


@implementation SQFiltrateItem

- (NSMutableSet *)choseSet{
    if (_choseSet) {
        return _choseSet;
    }
    _choseSet = [NSMutableSet set];
    
    return _choseSet;
}

@end


@interface SQFiltrateView ()

@property (nonatomic, strong) UIButton *bg_button;
@property (nonatomic, assign) NSUInteger select_itemIndex;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIView * line;

@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UIButton * rightBtn;

@property (nonatomic, assign) BOOL remake; //重置
@end;


@implementation SQFiltrateView

- (instancetype)initWithFrame:(CGRect)frame filtrateItems:(NSArray<SQFiltrateItem *> *)filtrateItems{
    if (self = [super initWithFrame:frame]) {
        self.remake = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.filtrateItems = filtrateItems;
        [self setViews];
    }
    return self;
}

- (void)setViews{
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    self.lineView = [UIView zj_viewWithBackColor:LineColor supView:self constraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.height.offset = 0.5f;
    }];


    CGRect selfRect = self.frame;
    
    _bg_button = [UIButton buttonWithType:UIButtonTypeCustom];
    _bg_button.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    _bg_button.hidden = YES;
    _bg_button.frame = CGRectMake(CGRectGetMinX(selfRect),CGRectGetMaxY(self.frame)+AdaptedHeight(88), CGRectGetWidth(selfRect), SCREEN_HEIGHT-CGRectGetHeight(selfRect));
    [[UIApplication sharedApplication].keyWindow addSubview:_bg_button];
    [_bg_button addTarget:self action:@selector(bg_button_Action:) forControlEvents:UIControlEventTouchUpInside];
  
    NSMutableArray *buttons = @[].mutableCopy;
    __block  UIView *lastView = nil;
    CGFloat marginX   = AdaptedWidth(10);  //按钮距离左边和右边的距离
    CGFloat marginY   = 0;  //按钮距离布局顶部的距离
    CGFloat toTop     = AdaptedHeight(15);  //布局区域距离顶部的距离
    CGFloat gap       = AdaptedWidth(3);    //按钮与按钮之间的距离
    NSInteger count   = self.filtrateItems.count;  //这里先设置布局5个按钮
    NSInteger col     = count;    //这里只布局4列
    CGFloat itemWidth = (MainWidth - marginX *2 - (col - 1)*gap)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat height    = AdaptedHeight(15);   //按钮的高度可以根据情况设定 这里设置为相等
    
    [self.filtrateItems enumerateObjectsUsingBlock:^(SQFiltrateItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize size;
        if (idx < 3) {
            size = CGSizeMake(8, 6);
        }else {
            size = CGSizeMake(9, 10);
        }
        
        SQCustomButton *button =  [[SQCustomButton alloc]initWithFrame:CGRectZero
                                                                  type:SQCustomButtonRightImageType
                                                             imageSize:size
                                                             midmargin:5];
        if (idx == 3) {
            button.imageView.image = [UIImage imageNamed:@"shaixuan"];
        }else{
            button.imageView.image = [UIImage imageNamed:@"xiaxia"];
        }
        button.titleLabel.text = obj.title;
        button.titleLabel.textColor = RGBSigle(51);
        button.titleLabel.font = kFont_14;
        button.tag = idx + 1000;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:button];
        [buttons addObject:button];
        obj.button = button;
        typeof(self) weakSelf = self;
        [button touchAction:^(SQCustomButton * _Nonnull button) {
            weakSelf.select_itemIndex = [buttons indexOfObject:button];
            [weakSelf click:obj];
        }];
        [self setListView:obj];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            //宽高是固定的，前面已经算好了
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(height);
            //topTop距离顶部的距离，单行不用考虑太多，多行，还需要计算距离顶部的距离
            make.top.mas_offset(toTop+marginY);
            if (!lastView) {  //last为nil 说明是第一个按钮
                make.left.mas_offset(marginX);
            }else{
                //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
                make.left.mas_equalTo(lastView.mas_right).mas_offset(gap);
            }
        }];
        lastView = button;
    }];
}

- (CGFloat)FiltrateHeight{
    return AdaptedHeight(200);
}

- (void)setListView:(SQFiltrateItem *)filtrateItem{
    
    UIView *tempView = [[UIView alloc]init];
    tempView.backgroundColor = [UIColor redColor];
    tempView.clipsToBounds = YES;
    filtrateItem.bg_View = tempView;
    tempView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:tempView];

    UIScrollView *backView = [[UIScrollView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    filtrateItem.backView = backView;
    [tempView addSubview:backView];
    
    
  
    
    if (filtrateItem.listType == OptionListType_Tag) {
        
        self.leftBtn = [UIButton zj_buttonWithTitle:@"重置"
                                         titleColor:RGBSigle(51)
                                          backColor:[UIColor whiteColor]
                                           fontSize:14
                                             isBold:NO
                                       cornerRadius:0
                                            supView:tempView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.left.bottom.offset = 0;
                                            make.width.offset = MainWidth/2;
                                            make.height.offset = AdaptedHeight(50);
                                        } touchUp:^(id sender) {
                                            [self remakeChick:sender item:filtrateItem];
                                        }];
        self.rightBtn = [UIButton zj_buttonWithTitle:@"确定"
                                          titleColor:[UIColor whiteColor]
                                           backColor:MainColor
                                            fontSize:14
                                              isBold:NO
                                        cornerRadius:0
                                             supView:tempView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.right.offset = 0;
                                             make.bottom.width.height.mas_equalTo(self.leftBtn);
                                         } touchUp:^(id sender) {
                                             [self confirmChick:sender item:filtrateItem];
                                         }];
        
        
        self.line = [UIView zj_viewWithBackColor:LineColor supView:tempView constraints:^(MASConstraintMaker *make) {
            make.left.right.offset = 0;
            make.height.offset = 1.0f;
            make.bottom.offset =AdaptedHeight(-50);
        }];
        
        NSInteger eachNumber = 2;
        NSInteger tagHeight = AdaptedHeight(30);
        CGFloat width = (self.frame.size.width-15*2-10*(eachNumber-1))/eachNumber;
        NSMutableArray *tempArray = @[].mutableCopy;
        for (NSInteger i=0; i<filtrateItem.optionData.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:filtrateItem.optionData[i] forState:UIControlStateNormal];
            [button setTitleColor:TitleColor forState:UIControlStateNormal];
            button.layer.cornerRadius = 2.f;
            button.titleLabel.font = kFont_14;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = TitleColor.CGColor;
            button.tag = i;
            NSInteger a = i/eachNumber;
            NSInteger b = i%eachNumber;
            
            button.frame = (CGRect){15+(width+10)*b,15+(tagHeight+10)*a,width,tagHeight};
            [backView addSubview:button];
            
            if (i== filtrateItem.optionData.count-1) {
               //***  背景View  **/
                tempView.frame = CGRectMake(CGRectGetMinX(self.frame),CGRectGetMaxY(self.frame)+AdaptedHeight(88), CGRectGetWidth(self.frame),0);
                //***  ScrollView  **/
                backView.frame = CGRectMake(CGRectGetMinX(self.frame), 0, CGRectGetWidth(self.frame),CGRectGetMaxY(button.frame)+15 >= [self FiltrateHeight] ? [self FiltrateHeight] :  CGRectGetMaxY(button.frame)+15);
               
                filtrateItem.backView.contentSize = CGSizeMake(SCREEN_WIDTH,CGRectGetMaxY(button.frame)+15);

                filtrateItem.bg_ViewHeight = CGRectGetMaxY(button.frame)+15 >= [self FiltrateHeight] ? [self FiltrateHeight] : CGRectGetMaxY(button.frame)+15;
            }
            
            [tempArray addObject:button];
            [button addTarget:self action:@selector(select_button_action:) forControlEvents:UIControlEventTouchUpInside];
        }
        filtrateItem.listCellViews = tempArray;
    }
    
    
    if (filtrateItem.listType == OptionListType_Cell) {
        CGFloat cellHeight = 45.f;
        NSMutableArray *tempArray = @[].mutableCopy;
        for (NSInteger i=0; i<filtrateItem.optionData.count; i++){
            UIView *labeltempView = [[UIView alloc]initWithFrame:CGRectMake(0, (cellHeight+0.5)*i, SCREEN_WIDTH, cellHeight)];
            [backView addSubview:labeltempView];
            labeltempView.tag = i;
            UILabel *label = [[UILabel alloc]init];
            label.textColor = TitleColor;
            label.font = kFont_14;
            label.text = filtrateItem.optionData[i];
            [labeltempView addSubview:label];
            [tempArray addObject:label];
            label.frame = CGRectMake(15, 0, SCREEN_WIDTH-15, cellHeight);
         
            if (i<filtrateItem.optionData.count-1) {
                UIView *lineView = [UIView new];
                lineView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
                [labeltempView addSubview:lineView];
                lineView.frame = CGRectMake(15, cellHeight-0.5, SCREEN_WIDTH-15, 0.5);
            }
            
            if (i==filtrateItem.optionData.count-1) {
                
                tempView.frame = CGRectMake(CGRectGetMinX(self.frame),CGRectGetMaxY(self.frame)+AdaptedHeight(88), CGRectGetWidth(self.frame),0);
                
                //***  ScrollView  **/
                backView.frame = CGRectMake(CGRectGetMinX(self.frame), 0, CGRectGetWidth(self.frame),CGRectGetMaxY(labeltempView.frame)+0.5 >= [self FiltrateHeight] ? [self FiltrateHeight]+AdaptedHeight(50) :  CGRectGetMaxY(labeltempView.frame)+0.5);
                
                filtrateItem.bg_ViewHeight = CGRectGetMaxY(labeltempView.frame)+0.5 >= [self FiltrateHeight] ? [self FiltrateHeight]+AdaptedHeight(50) :  CGRectGetMaxY(labeltempView.frame)+0.5;
                
                filtrateItem.backView.contentSize = CGSizeMake(SCREEN_WIDTH,CGRectGetMaxY(labeltempView.frame)+0.5);
            }
            labeltempView.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTap:)];
            [labeltempView addGestureRecognizer:tap];
        }
        filtrateItem.listCellViews = tempArray;
    }
}

//***  菜单弹出动画  **/
- (void)click:(SQFiltrateItem *)filtrateItem{
    
    self.remake = NO;
    [self changeSelectBtn:filtrateItem];
    for (SQFiltrateItem *item in self.filtrateItems) {
        
        if ([item.title isEqualToString:filtrateItem.title]) {
            item.isShow = !item.isShow;
            if (item.isShow) {
                item.bg_View.hidden = NO;
                [UIView animateWithDuration:0.2 animations:^{
                    
                    CGRect fram = item.bg_View.frame;
                    if (filtrateItem.listType == OptionListType_Cell) {
                        fram.size.height = item.bg_ViewHeight;
                    }else{
                        fram.size.height = item.bg_ViewHeight+AdaptedHeight(50);
                    }
                    item.bg_View.frame = fram;
                    
                    self->_bg_button.hidden = NO;
                    
                    if (item.button.tag == 1003) {
                        item.button.imageView.image = [UIImage imageNamed:@"shaixuan"];
                        item.button.titleLabel.textColor = MainColor;
                    }else{
                        item.button.imageView.image = [UIImage imageNamed:@"borrow_up"];
                    }
                    
                } completion:^(BOOL finished) {
                    
                }];
            }else{
                item.bg_View.hidden = YES;
                [UIView animateWithDuration:0.2 animations:^{
                    
                    CGRect fram = item.bg_View.frame;
                    fram.size.height = 0;
                    item.bg_View.frame = fram;
                    
                    self->_bg_button.hidden = YES;
                    if (item.button.tag == 1003) {
                        item.button.imageView.image = [UIImage imageNamed:@"shaixuan"];
                        item.button.titleLabel.textColor = RGBSigle(51);
                    }else{
                        item.button.imageView.image = [UIImage imageNamed:@"xiaxia"];
                    }
//                    item.button.imageView.image = [UIImage imageNamed:@"xiaxia"];
//                    item.button.titleLabel.textColor = TitleColor;
                } completion:^(BOOL finished) {
                    
                }];
            }
            
        }else{
            item.isShow = NO;
            item.bg_View.hidden = YES;
            CGRect fram = item.bg_View.frame;
            fram.size.height = 0;
            item.bg_View.frame = fram;
            if (item.button.tag == 1003) {
                item.button.imageView.image = [UIImage imageNamed:@"shaixuan"];
                item.button.titleLabel.textColor = RGBSigle(51);
            }else{
                item.button.imageView.image = [UIImage imageNamed:@"xiaxia"];
            }
//            item.button.imageView.image = [UIImage imageNamed:@"xiaxia"];
//            item.button.titleLabel.textColor = TitleColor;
        }
    }
    [self exchangeMenuColor:filtrateItem];

}

//***  菜单选中添加、删除--> 操作集合  **/
- (void)refreshListTag:(NSInteger)tag filtrateItem:(SQFiltrateItem *)filtrateItem{
   
    if ([filtrateItem.choseSet containsObject:@(tag)]) {
        [filtrateItem.choseSet removeObject:@(tag)];
    }else{
        if (filtrateItem.numberType == OptionNumberType_Single) {
            //单选
            [filtrateItem.choseSet removeAllObjects];
            [filtrateItem.choseSet addObject:@(tag)];
        }else{
            //多选
            if (tag > -1) {
                [filtrateItem.choseSet addObject:@(tag)];
            }
        }
    }
    //***  重置刷新界面选中按钮显示  **/
    [self changeSelectBtn:filtrateItem];

//    if (!filtrateItem.choseSet.count) {
//    }
    
    if (self.touchBlock) {
        self.touchBlock(self, filtrateItem);
    }
    if (filtrateItem.numberType == OptionNumberType_Single) {
        [self hideAllItemView];
    }
    
}

//***  重置刷新界面选项  **/
- (void)changeSelectBtn:(SQFiltrateItem *)filtrateItem{
    
    for (NSInteger i=0; i<filtrateItem.listCellViews.count; i++) {

        if ([filtrateItem.listCellViews[i] isKindOfClass:[UIButton class]]) {
            
            if (self.remake == YES) {

                UIButton *button = (UIButton *)filtrateItem.listCellViews[i];
                [button setTitleColor:TitleColor forState:0];
                button.layer.borderColor = TitleColor.CGColor;
                
            }else{
                
                UIButton *button = (UIButton *)filtrateItem.listCellViews[i];
                [button setTitleColor:[filtrateItem.choseSet containsObject:@(i)]?MainColor: TitleColor forState:0];
                button.layer.borderColor = ([filtrateItem.choseSet containsObject:@(i)]?MainColor: TitleColor).CGColor;
            }
        }
        
        if ([filtrateItem.listCellViews[i] isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)filtrateItem.listCellViews[i];
            [label setTextColor:([filtrateItem.choseSet containsObject:@(i)]?MainColor : TitleColor)];
        }
    }
}


//***  重置  **/
- (void)remakeChick:(UIButton *)sender item:(SQFiltrateItem *)filtrateItem {
    
    self.remake = YES;
    [self refreshListTag:-1 filtrateItem:filtrateItem];
    
}
//***  确认  **/
- (void)confirmChick:(UIButton *)sender item:(SQFiltrateItem *)filtrateItem {
    
    if (self.remake == YES) {
        self.remake = NO;
        [filtrateItem.choseSet removeAllObjects];
    }
    [self hideAllItemView];
    [self exchangeMenuColor:filtrateItem];
    
    if (self.touchBlock) {
        self.touchBlock(self, filtrateItem);
    }
}

//***  点击背景收回弹窗  **/
- (void)bg_button_Action:(UIButton *)button{

    [self hideAllItemView];
    
}
//***  收回弹出菜单  **/
- (void)hideAllItemView{
    for (SQFiltrateItem *item in self.filtrateItems) {
        item.isShow = YES;
    }
    [self click:self.filtrateItems[self.select_itemIndex]];
}

//***  菜单头部加载  **/
- (void)setFiltrateItems:(NSArray *)filtrateItems{
    _filtrateItems = filtrateItems;
    [self setViews];
}

//***  回调方法  **/
- (void)touchBlock:(void (^)(SQFiltrateView *, SQFiltrateItem *))block{
    self.touchBlock = block;
}

//***  判断菜单头字体颜色  **/
- (void)exchangeMenuColor:(SQFiltrateItem *)filtrateItem{
   
    if (filtrateItem.choseSet.count > 0) {
        filtrateItem.button.titleLabel.textColor = MainColor;
        if (filtrateItem.button.tag == 1003) {
            filtrateItem.button.imageView.image = [UIImage imageNamed:@"shaixuan_h"];
        }
    }else{
        filtrateItem.button.titleLabel.textColor = RGBSigle(51);
    }
}

//***  内部条件按钮点击响应  **/
- (void)select_button_action:(UIButton *)button{
    SQFiltrateItem *item = self.filtrateItems[self.select_itemIndex];

    if (self.remake == YES) {
        self.remake = NO;
        [item.choseSet removeAllObjects];
    }
    [self refreshListTag:button.tag filtrateItem:item];
}
//***  单选列表选项点击响应  **/
- (void)labelTap:(UITapGestureRecognizer *)tap{
    
    SQFiltrateItem *item = self.filtrateItems[self.select_itemIndex];
    [self refreshListTag:tap.view.tag filtrateItem:item];

}
@end
