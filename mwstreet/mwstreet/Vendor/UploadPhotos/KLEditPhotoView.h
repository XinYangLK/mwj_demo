//
//  KLEditPhotoView.h
//  VisaModules
//
//  Created by 科pro on 2018/11/28.
//  Copyright © 2018年 palmble. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^PreviewBlock)(UIImage * img);


@class KLEditPhotoView;
@protocol KLEditPhotoViewDelegate <NSObject>
//***   打开照片库  **/
-(void)editPhotoViewToOpenAblum:(KLEditPhotoView *)editView;

//***   图片剩余数量  **/
-(void)fetchPhotosNumber:(NSInteger)picCount editView:(KLEditPhotoView *)editView;


- (void)previewPhotosBtn:(UIButton *)sender img:(UIImage *)img editView:(KLEditPhotoView *)editView block:(PreviewBlock)photosBlock;

@end


@interface KLEditPhotoView : UIView

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong) NSString * titleStr;
/***   快速创建view  **/
+(id)editPhotoView;

/***  添加一张图片  **/
-(void)addOneImage:(UIImage *)image;

/***  获取editPhoto中的图片数组 **/
-(NSArray *)fetchPhotos;

/**代理*/
@property(assign,nonatomic)id<KLEditPhotoViewDelegate>delegate;

@end
