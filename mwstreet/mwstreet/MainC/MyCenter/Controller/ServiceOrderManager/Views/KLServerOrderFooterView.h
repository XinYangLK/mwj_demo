//
//  KLServerOrderFooterView.h
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FooterBtnBlock)(UIButton *sender , NSIndexPath * indexPath);

@interface KLServerOrderFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) NSString * rightText;
@property (nonatomic, strong) NSString * leftText;

@property (nonatomic, strong) UIButton * rightBtn;
@property (nonatomic, strong) UIButton * leftBtn;

//***  底部按钮点击回调  **/
@property (nonatomic,copy) FooterBtnBlock footerBtnBlock;

@end

NS_ASSUME_NONNULL_END
