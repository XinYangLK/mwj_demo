//
//  KLHomeProtocol.h
//  mwstreet
//
//  Created by 科pro on 2018/12/20.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^cityBlock)(NSString * city);
NS_ASSUME_NONNULL_BEGIN

@protocol KLHomeProtocol <NSObject>

@optional //选实现
/**
 * 分类按钮 点击delegate
 * @param  indexPath cell index.row
 */
- (void)didClickBtn:(UIButton *)button indexPath:(NSIndexPath *)indexPath;

/**
 * 定位按钮 点击delegate
 */
- (void)loctionCityBtn:(UIButton *)sender;

//- (void)loctionCity:(cityBlock)block;

@end

NS_ASSUME_NONNULL_END
