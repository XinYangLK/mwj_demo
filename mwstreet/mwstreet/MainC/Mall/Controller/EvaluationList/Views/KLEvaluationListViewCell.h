//
//  KLEvaluationListViewCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/23.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLEvaluationListModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^GoodsImagesBlock)(UIButton * sender , NSMutableArray * imgArray , NSIndexPath * indexPath);

typedef void(^PraiseBlock)(UIButton * sender , NSIndexPath * indexPath);
typedef void(^MsgBlock)(UIButton * sender , NSIndexPath * indexPath);


@interface KLEvaluationListViewCell : UITableViewCell
//***  评价列表model  **/
@property (nonatomic, strong) KLEvaluationListModel * evaluationListModel;
//***  赞  **/
@property (nonatomic, strong) UIButton         * praiseBtn;
//***  评价回复  **/
@property (nonatomic, strong) UIButton         * msgBtn;

@property (nonatomic, strong) NSIndexPath      * indexPath;

@property (nonatomic ,  copy) GoodsImagesBlock   goodsImagesBlock;
@property (nonatomic ,  copy) PraiseBlock        praiseBlock;
@property (nonatomic ,  copy) MsgBlock           msgBlock;

@end



typedef void(^ImagesBlock)(UIButton * sender , NSMutableArray * imgArray);

@interface ImagesView : UIView

@property (nonatomic ,strong) NSMutableArray   * imagesArray;
@property (nonatomic ,  copy) ImagesBlock        imagesBlock;
@end

NS_ASSUME_NONNULL_END
