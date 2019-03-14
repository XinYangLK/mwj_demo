//
//  KLMenuView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ChooseBlock) (NSString *chooseContent,NSIndexPath *indexPath);

typedef void(^ShowBlock) (BOOL showStatus);


@interface KLMenuView : UIView

@property (nonatomic, strong) NSString    * chooseContent;  //选中的item
@property (nonatomic, strong) NSIndexPath * currentSelectIndex;
@property (nonatomic, copy )  ChooseBlock   block; //选择回调条件
@property (nonatomic, copy )  ShowBlock     showBlock; //弹出层显示与否回调
@property (nonatomic, strong) UICollectionView * collectionView;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
