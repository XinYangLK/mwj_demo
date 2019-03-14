//
//  KLMenuCollectionCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLMenuCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIButton * selectBtn;
@property (nonatomic,assign)BOOL isSelected;
-(void)UpdateCellWithState:(BOOL)select;

@end

NS_ASSUME_NONNULL_END
