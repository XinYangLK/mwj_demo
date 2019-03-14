//
//  KLTextInputConfigure.h
//  mwstreet
//
//  Created by 科pro on 2019/1/17.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//类型枚举
typedef NS_ENUM(NSInteger, TextFieldType) {
    TextFieldVerificationType,   //输入框带验证码
    TextFieldDefaultType,        //常规
};


@interface KLTextInputConfigure : NSObject

/** 类方法创建 */
+ (instancetype)textInputConfigure;

//***  图标  **/
@property (nonatomic, strong) NSString * imgName;
//***  文本框占位符  **/
@property (nonatomic, strong) NSString * placeholder;
//***  框边 颜色  **/
@property (nonatomic, strong) UIColor * boxColor;
//***  文本框边类型  **/
@property (nonatomic, assign) TextFieldType type;
//***  计数  **/
@property (nonatomic, assign) NSInteger timeCount;
//***  密文形式  **/
@property (nonatomic, assign) BOOL security;

@end

NS_ASSUME_NONNULL_END
