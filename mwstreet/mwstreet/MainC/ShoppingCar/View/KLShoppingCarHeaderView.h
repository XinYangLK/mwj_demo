//
//  KLShoppingCarHeaderView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KLShoppingCarHeaderView;
@protocol KLShoppingCarHeaderViewDelegate <NSObject>

@optional //选实现
/**
 选中sectionHearder上的按钮时的代理事件
 
 @param headerView self
 @param isSelected 是否选中，YES：是；NO：取消选中/未选中
 @param section 当前的section
 */
- (void)hearderView:(KLShoppingCarHeaderView *)headerView isSelected:(BOOL)isSelected section:(NSInteger)section;

@required //必实现

@end




@interface KLShoppingCarHeaderView : UITableViewHeaderFooterView

@property (nonatomic,weak) id<KLShoppingCarHeaderViewDelegate> delegate;
//***  选择按钮  **/
@property (nonatomic, strong) UIButton    * selectBtn;
//***  商店图标  **/
@property (nonatomic, strong) UIImageView * storeImg;
//***  商店名称  **/
@property (nonatomic, strong) UILabel     * storeName;
//***  选择的区  **/
@property (nonatomic, assign) NSInteger     section;

@end


NS_ASSUME_NONNULL_END
