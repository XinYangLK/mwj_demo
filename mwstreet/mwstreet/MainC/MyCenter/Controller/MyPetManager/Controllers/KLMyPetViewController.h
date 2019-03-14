//
//  KLMyPetViewController.h
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLMyPetViewController : KLBaseViewController
//***  宠物图片  **/
@property (nonatomic, strong) UIImage *petImg;
//***  宠物名称  **/
@property (nonatomic, strong) NSString *petName;
//***  宠物类别  **/
@property (nonatomic, strong) NSString *petClassify;
//***  宠物年龄  **/
@property (nonatomic, strong) NSString *petAge;
//***  宠物性别  **/
@property (nonatomic, strong) NSString *petSex;

@end

NS_ASSUME_NONNULL_END
