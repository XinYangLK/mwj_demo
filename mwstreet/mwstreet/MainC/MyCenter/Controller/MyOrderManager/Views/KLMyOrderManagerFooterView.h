//
//  KLMyOrderManagerFooterView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/15.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^SectionBtnBlock)(UIButton * sender, NSInteger sention);
@interface KLMyOrderManagerFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) NSString * totalDes;
@property (nonatomic, strong) NSString * rightText;
@property (nonatomic, strong) NSString * centerText;
@property (nonatomic, strong) NSString * leftText;

@property (nonatomic, strong) UIButton * rightBtn;
@property (nonatomic, strong) UIButton * centerBtn;
@property (nonatomic, strong) UIButton * leftBtn;

@property (nonatomic, assign) NSInteger section;
@property (nonatomic,copy) SectionBtnBlock sectionBtnBlock;
@end

NS_ASSUME_NONNULL_END
