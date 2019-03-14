//
//  KLGoodsDetailStoreCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface KLGoodsStoreView : UIView

@property (nonatomic, strong) UILabel     * numLab;
@property (nonatomic, strong) UILabel     * storeLab;

@end


NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

typedef void(^EnterStoreBlock)(UIButton * sender);
@interface KLGoodsDetailStoreCell : UITableViewCell

//***  门店图片  **/
@property (nonatomic, strong) UIImageView * storeImg;
//***  门店名称  **/
@property (nonatomic, strong) UILabel     * storeName;
//***  进入门店btn  **/
@property (nonatomic, strong) UIButton    * enterStoreBtn;
@property (nonatomic,copy) EnterStoreBlock enterStoreBlock;
//***  门店内容数量 数据数组  **/
@property (nonatomic, assign) NSInteger     markCount;
@property (nonatomic, strong) NSArray     * storeDecArray;


@end

NS_ASSUME_NONNULL_END
