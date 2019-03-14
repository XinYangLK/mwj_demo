//
//  KLFilterMenuCollectionCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLFilterMenuCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, retain) UIButton * selectIconBtn;
@property (nonatomic, assign) BOOL isSelected;

-(void)UpdateCellWithState:(BOOL)select;

@end

NS_ASSUME_NONNULL_END
