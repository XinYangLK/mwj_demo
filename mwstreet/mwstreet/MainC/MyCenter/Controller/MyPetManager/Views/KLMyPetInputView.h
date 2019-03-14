//
//  KLMyPetInputView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//类型枚举
typedef NS_ENUM(NSInteger, MyPetEidtType) {
    MyPetEidtTextInput, //信息输入编辑
    MyPetEidtSexChange, //性别选择
    MyPetEidtDateChange,//日期选择
};


@interface KLMyPetInputView : UIView

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *sexMale;
@property (nonatomic, strong) UIButton *sexFemale;
@property (nonatomic, strong) UIButton *dateBtn;
- (instancetype)initWithFrame:(CGRect)frame eidtType:(MyPetEidtType)type;
@end

NS_ASSUME_NONNULL_END
