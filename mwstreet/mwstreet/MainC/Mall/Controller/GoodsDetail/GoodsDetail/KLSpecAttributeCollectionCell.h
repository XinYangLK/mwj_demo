//
//  KLSpecAttributeCollectionCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/10.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLSpecAttributeCollectionCell : UICollectionViewCell

@property (nonatomic ,strong)NSDictionary * propsInfo;//!<规格信息

@property (nonatomic, strong) UILabel * specLab;

@end

NS_ASSUME_NONNULL_END
