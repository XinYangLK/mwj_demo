//
//  KLAccoutEditCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/20.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark -  头像上传  **/
@interface KLAccoutEditCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UIImageView * accoutImg;

@end


#pragma mark -  昵称编辑  **/
@interface KLAccoutNickNameEditCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UITextField * nickField;
@property (nonatomic, strong) UIImageView * angleImg;
/**
 *  设置cell、数据
 *  @param string        左边的标题
 *  @param dataString    textfield输入内容
 *  @param indexPath     indexPath。唯一绑定当前textfield
 */
- (void)setDataString:(NSString *)dataString
          andIndexPath:(NSIndexPath *)indexPath;
@end



#pragma mark -  性别、生日选择  **/
@interface KLAccoutSexBothdayEditCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * textLab;
@property (nonatomic, strong) UIImageView * angleImg;

@end


#pragma mark - 个人简介
@interface  KLAccoutRemarksEditCell : UITableViewCell//备注cell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITextView *remarksView;

@end


NS_ASSUME_NONNULL_END
