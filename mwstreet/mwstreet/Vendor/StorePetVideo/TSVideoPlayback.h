//
//  TSVideoPlayback.h
//  avplayer
//
//  Created by Feng on 2018/7/1.
//  Copyright © 2018年 Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSVideoPlayback;
typedef enum : NSUInteger {
    TSDETAILTYPEVIDEO,//视屏
    TSDETAILTYPEIMAGE,//图片
} TSDETAILTYPE;

@protocol TSVideoPlaybackDelegate <NSObject>

//点击图片索引
-(void)videoView:(TSVideoPlayback *)view didSelectItemAtIndexPath:(NSInteger)index;

@end


typedef void(^PlayerBlock)(UIButton * sender);
typedef void(^PlaerPauseBlock)(BOOL pause);

@interface TSVideoPlayback : UIView

@property (nonatomic,weak) id<TSVideoPlaybackDelegate> delegate;
@property (nonatomic,assign) TSDETAILTYPE type;
@property (nonatomic,copy) PlayerBlock playerBlock;         //播放按钮回调
@property (nonatomic,copy) PlaerPauseBlock plaerPauseBlock; //轮播划出视频停止
@property (nonatomic, strong) UIImageView *coverImageView;

/*
 * isVideo  是否带视屏链接
 * array    数据
 */
-(void)setWithIsVideo:(TSDETAILTYPE)type andDataArray:(NSArray *)array;



@end
