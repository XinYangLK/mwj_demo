//
//  KLServerOrderCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLServerOrderCell : UITableViewCell

//***  服务图片  **/
@property (nonatomic, strong) UIImageView * serImg;
//***  服务名称  **/
@property (nonatomic, strong) UILabel     * titleLab;
//***  服务价格  **/
@property (nonatomic, strong) UILabel     * priceLab;
//***  服务已售量  **/
@property (nonatomic, strong) UILabel     * decLab;

@end

NS_ASSUME_NONNULL_END
