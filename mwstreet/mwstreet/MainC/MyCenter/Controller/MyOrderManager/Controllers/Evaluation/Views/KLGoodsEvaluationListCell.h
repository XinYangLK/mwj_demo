//
//  KLGoodsEvaluationListCell.h
//  mwstreet
//
//  Created by 科pro on 2019/3/14.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^EvaluationBlock)(UIButton * sender, NSIndexPath * cellPath);
@interface KLGoodsEvaluationListCell : UITableViewCell

//***  商品图片  **/
@property (nonatomic, strong) UIImageView * imgView;
//***  商品名称  **/
@property (nonatomic, strong) UILabel     * titleLab;
@property (nonatomic, strong) NSString    * goodsTitle;

//***  商品价格  **/
@property (nonatomic, strong) UILabel     * priceLab;
//***  商品规格  **/
@property (nonatomic, strong) UILabel     * goodSpacLab;
@property (nonatomic, strong) NSString    * goodSpac;

//***  找相似按钮  **/
@property (nonatomic, strong) UIButton    * findBtn;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic,   copy) EvaluationBlock evaluationBlock;
@end

NS_ASSUME_NONNULL_END
