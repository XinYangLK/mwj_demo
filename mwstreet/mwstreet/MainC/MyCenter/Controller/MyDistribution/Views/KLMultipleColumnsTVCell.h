//
//  KLMultipleColumnsTVCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/1.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


//#define kJianXi 1.0f
//#define kClickBtnHeight 76
@interface KLMultipleColumnsTVCell : UIView

//需要有数据源
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) NSArray * imgArray;

@property (nonatomic,assign) NSInteger dataArrayCount;

//点击时返回下标
@property (nonatomic,copy) void(^ReturnClickItemIndex)(NSIndexPath * itemtIP ,NSInteger itemIndex);

//横向间隙
@property (nonatomic, assign) NSInteger minimumInteritemSpacing;

//纵向间隙
@property (nonatomic, assign) NSInteger minimumLineSpacing;

//高度
@property (nonatomic,assign) CGFloat cellHeight;

//单元格的下标
@property (nonatomic,strong) NSIndexPath * indexPath;


@end

NS_ASSUME_NONNULL_END
