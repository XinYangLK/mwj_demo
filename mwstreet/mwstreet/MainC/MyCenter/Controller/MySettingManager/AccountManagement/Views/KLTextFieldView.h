//
//  KLTextFieldView.h
//  mwstreet
//
//  Created by 科pro on 2019/2/20.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TextFieldType) {
    TextFieldDefaultType,        //常规
    TextFieldPasswordType,       //输入框带密码查看隐藏
    TextFieldVerificationType,   //输入框带验证码
};


@interface KLTextFieldView : UIView

{
    NSTimer*_timer;
}
@property (nonatomic, assign) NSInteger timeCount;

//文本框
@property (nonatomic,strong) UITextField *textField;
//分割线
@property (nonatomic, strong) UILabel *line;
//***  获取验证码按钮  **/
@property (nonatomic, strong) UIButton *verBtn;
//***  查看<->隐藏密码  **/
@property (nonatomic, strong) UIButton *lookBtn;
//获取验证码遮盖Lab
@property (nonatomic, strong) UILabel *tipLab;
//线
@property (nonatomic,strong) UIView *lineView;
//填充线
@property (nonatomic,strong) CALayer *lineLayer;

@property (nonatomic, assign) TextFieldType type;

- (instancetype)initWithFrame:(CGRect)frame type:(TextFieldType)type;

-(void)addLineAnmation;

-(void)moveLineAnimation;

-(void)readSecond;


@end

NS_ASSUME_NONNULL_END
