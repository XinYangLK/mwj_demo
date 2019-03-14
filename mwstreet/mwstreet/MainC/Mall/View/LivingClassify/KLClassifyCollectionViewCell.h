//
//  KLClassifyCollectionViewCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLClassifyCollectionViewCell : UICollectionViewCell
//***  类别图片  **/
@property (nonatomic, strong) UIImageView * classifyImg;
//***  类别名称  **/
@property (nonatomic, strong) UILabel     * classifyTitle;


@end

NS_ASSUME_NONNULL_END
