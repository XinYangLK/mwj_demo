//
//  KLEvaluationListModel.h
//  mwstreet
//
//  Created by 科pro on 2019/1/10.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLEvaluationListModel : NSObject

@property(nonatomic ,strong)NSString  * iconImage;
@property(nonatomic ,strong)NSString  * iconName;
@property(nonatomic ,strong)NSString  * timer;
@property(nonatomic ,strong)NSString  * scoreNum;
@property(nonatomic ,strong)NSString  * content;
@property(nonatomic ,strong)NSString  * praiseNum;
@property(nonatomic ,strong)NSString  * msgNum;
@property(nonatomic ,strong)NSArray   * images;

@end

NS_ASSUME_NONNULL_END
