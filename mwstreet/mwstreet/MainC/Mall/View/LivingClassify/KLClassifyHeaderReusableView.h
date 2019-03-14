//
//  KLClassifyHeaderReusableView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLClassifyHeaderReusableView : UICollectionReusableView
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIView *lineView;
@end

typedef void(^Block)(UIButton *button, NSInteger section);

@interface KLClassifyFooterReusableView : UICollectionReusableView
@property (nonatomic, strong) UIButton * lookAllBtn;
@property (nonatomic, strong) UIView   * lineView;
@property (nonatomic,copy)    Block      lookAllBlock;
@property (nonatomic, assign) NSInteger  section;
@end


NS_ASSUME_NONNULL_END
