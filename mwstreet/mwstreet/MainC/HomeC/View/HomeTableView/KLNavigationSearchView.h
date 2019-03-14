//
//  KLNavigationSearchView.h
//  mwstreet
//
//  Created by 科pro on 2018/12/19.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLHomeProtocol.h"

@interface KLSearchBar : UISearchBar

@end


NS_ASSUME_NONNULL_BEGIN

@interface KLNavigationSearchView : UIView

@property (nonatomic, strong) UIButton    * loctionBtn; //定位按钮
@property (nonatomic, strong) KLSearchBar * searchView; //搜索框
@property (nonatomic, strong) UIButton    * messageBtn; //消息按钮
@property (nonatomic, strong) UIImageView * shadowLine;   //分割线
@property (nonatomic, weak) id<KLHomeProtocol> delegate;

+ (instancetype)creatNavigationView;


@end

NS_ASSUME_NONNULL_END
