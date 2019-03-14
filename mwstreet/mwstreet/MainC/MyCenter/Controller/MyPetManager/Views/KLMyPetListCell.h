//
//  KLMyPetListCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KLMyPetListCell;

@protocol KLMyPetListCellDelegate <NSObject>

@optional //选实现
- (void)didEidtBtnActionChick:(KLMyPetListCell *)cell;//编辑按钮方法回调

@end


@interface KLMyPetListCell : UITableViewCell
//***  宠物图像  **/
@property (nonatomic, strong) UIImageView * imgView;
//***  宠物名称  **/
@property (nonatomic, strong) UILabel     * nameLab;
//***  宠物类别  **/
@property (nonatomic, strong) UILabel     * classifyLab;
//***  宠物年龄  **/
@property (nonatomic, strong) UILabel     * ageLab;
//***  编辑按钮  **/
@property (nonatomic, strong) UIButton    * eidtBtn;

@property (nonatomic,weak) id<KLMyPetListCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
