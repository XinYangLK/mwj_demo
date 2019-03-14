//
//  KLMyDisInputConfigure.h
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//类型枚举
typedef NS_ENUM(NSInteger, MyTextEidtType) {
    MyTextEidtTitleInput, //带标题信息输入编辑
    MyTextEidtTextInput,  //不带标题信息输入编辑
    MyTextEidtSexChange, //性别选择
};

@interface KLMyDisInputConfigure : NSObject

/** 类方法创建 */
+ (instancetype)textInputConfigure;
//***  文本框边类型  **/
@property (nonatomic, assign) MyTextEidtType type;
//***  占位符  **/
@property (nonatomic, strong) NSString * placeholder;
//***  标题  **/
@property (nonatomic, strong) NSString * title;

@end

NS_ASSUME_NONNULL_END
