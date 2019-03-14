//
//  KLStoreDetailHeaderView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/30.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookMoreHeaderBlock)(UIButton * sender,NSInteger section);

@interface KLStoreDetailHeaderView : UITableViewHeaderFooterView

@property (nonatomic,copy) LookMoreHeaderBlock lookMoreBlock;

@property (nonatomic, assign) NSInteger  section;

@property (nonatomic, strong) UILabel  * titleLab;


+ (KLStoreDetailHeaderView *)initWith:(UITableView *)tableView title:(NSString *)title moreHidden:(BOOL)hidden lineHidden:(BOOL)lineHidden;

@end

NS_ASSUME_NONNULL_END
