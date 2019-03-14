//
//  KLFilterMenuView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChooseBlock) (NSString *chooseContent,NSMutableArray *chooseArr);
typedef void(^ShowStatusBlock) (BOOL show);

@interface KLFilterMenuView : UIView

@property (nonatomic, strong) UIView           * backView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UITableView      * tableView;
@property (nonatomic, strong) UIView           * line;
@property (nonatomic, strong) UIButton         * remakeBtn;
@property (nonatomic, strong) UIButton         * confirmBtn;
//***  选择数据回调  **/
@property(nonatomic , copy)   ChooseBlock        block;
//***  选择数据回调  **/
@property(nonatomic , copy)   ShowStatusBlock    showBlock;
//***  选择数据数组  **/
@property (nonatomic, strong) NSMutableArray   * choosedArray;
//***  选择源 **/
@property (nonatomic, strong) NSMutableArray   * dataArray;
//***  展示菜单  **/
- (void)showInView:(UIView *)aView animated:(BOOL)animated;
//***  移除菜单view  **/
- (void)fadeOut;
@end

NS_ASSUME_NONNULL_END
