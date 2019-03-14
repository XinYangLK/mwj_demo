//
//  UIButton+Extention.m
//  mwstreet
//
//  Created by 科pro on 2018/12/19.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>
@implementation UIButton (Extension)

static NSString *keyOfUseCategoryMethod;//用分类方法创建的button，关联对象的key
static NSString *keyOfBlock;


+ (UIButton *)createBtnTitle:(NSString *)title
                  titleColor:(UIColor *)titleColor
                        font:(UIFont *)font
                   imageName:(NSString *)imgName
              backgrounColor:(UIColor *)backColor
                      action:(tapActionBlock)actionBlock{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (![NSString isBlankString:imgName]) {
        [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setBackgroundImage:[UIImage imageWithColor:backColor] forState:UIControlStateNormal];
    [button addTarget:button action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    objc_setAssociatedObject (button , &keyOfUseCategoryMethod , actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC );
    return button;
}

+ (UIButton *)createBtnTitle:(NSString *)title
                  titleColor:(UIColor *)titleColor
                        font:(UIFont *)font
                   imageName:(NSString *)imgName
              backgrounColor:(UIColor *)backColor
         SSImagePositionType:(SSImagePositionType)type
                     spacing:(CGFloat)spac
                      action:(tapActionBlock)actionBlock{
    
    UIButton * button = [self createBtnTitle:title titleColor:titleColor font:font imageName:imgName backgrounColor:backColor action:actionBlock];
    
    [button setImagePositionWithType:type spacing:spac];
    
    return button;
}

//+ (UIButton *)createBtnTitle:(NSString *)title bgImageName:(NSString *)bgImageName action:(tapActionBlock)actionBlock
//{
//
//
////    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
////    [button setTitle:title forState:UIControlStateNormal];
////    [button setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
////    [button addTarget:button action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    /**
//     *用runtime中的函数通过key关联对象
//     *
//     *objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
//     *id object                     表示关联者，是一个对象，变量名理所当然也是object
//     *const void *key               获取被关联者的索引key
//     *id value                      被关联者，这里是一个block
//     *objc_AssociationPolicy policy 关联时采用的协议，有assign，retain，copy等协议，一般使用OBJC_ASSOCIATION_RETAIN_NONATOMIC
//
//     */
//    objc_setAssociatedObject (button , &keyOfUseCategoryMethod , actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC );
//
//    return button;
//}
- (void)tapAction:(UIButton*)sender
{
    /**
     * 通过key获取被关联对象
     *objc_getAssociatedObject(id object, const void *key)
     *
     */
    tapActionBlock block = ( tapActionBlock )objc_getAssociatedObject (sender , &keyOfUseCategoryMethod );
    
    if (block) {
        
        block(sender);
        
    }
}


- (void)setActionBlock:(tapActionBlock)actionBlock
{
    objc_setAssociatedObject (self , &keyOfBlock , actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC );
    
}

- (tapActionBlock)actionBlock
{
    return objc_getAssociatedObject (self , &keyOfBlock );
}


@end

