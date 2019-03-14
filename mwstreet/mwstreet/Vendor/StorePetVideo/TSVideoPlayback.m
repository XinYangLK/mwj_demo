//
//  TSVideoPlayback.m
//  avplayer
//
//  Created by Feng on 2018/7/1.
//  Copyright © 2018年 Feng. All rights reserved.
//

#import "TSVideoPlayback.h"

#import <ZFPlayer/UIImageView+ZFCache.h>

@interface TSVideoPlayback ()<UIScrollViewDelegate>
{
    NSInteger imgIndex;
}

@property (nonatomic,strong) UIScrollView * scrolView;
@property (nonatomic,strong) UILabel  * indexLab;//当前播放页数
@property (nonatomic,strong) UIButton * playBtn;//播放按钮
@property (nonatomic,strong) UIButton * videoBtn;//切换到视频
@property (nonatomic,strong) UIButton * imgBtn;//切换到图片
@property (nonatomic,strong) NSArray  * dataArray;


@end

@implementation TSVideoPlayback

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialControlUnit];
        }
    return self;
}

-(void)setWithIsVideo:(TSDETAILTYPE)type andDataArray:(NSArray *)array
{
    self.dataArray = array;
    
    self.scrolView.contentSize = CGSizeMake(self.dataArray.count*self.frame.size.width, 200);
    self.type = type;
    if (type == TSDETAILTYPEVIDEO) {
        [self.playBtn setHidden:NO];
        [self.videoBtn setHidden:NO];
        [self.imgBtn setHidden:NO];
    }else{
        [self.playBtn setHidden:YES];
        [self.videoBtn setHidden:YES];
        [self.imgBtn setHidden:YES];
    }
    for (int i = 0; i < _dataArray.count; i ++) {
        if (type == TSDETAILTYPEVIDEO) {
            if (i == 0) {
                
//                NSURL *url = [NSURL URLWithString:self.dataArray[0]];
                [self.coverImageView setImageWithURLString:@"http://img.ptocool.com/3332-1518523974126-29" placeholder:[UIImage imageNamed:@"loading_bgView"]];
                self.coverImageView.frame = CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
            }
            else{
                UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
                img.userInteractionEnabled = YES;
                [img sd_setImageWithURL:[NSURL URLWithString:self.dataArray[i]] placeholderImage:[UIImage imageNamed:@"icon_video"]];
                [self.scrolView addSubview:img];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapClick)];
                [img addGestureRecognizer:tap];
            }
            
            if (_dataArray.count > 1) {
                self.indexLab.text = [NSString stringWithFormat:@"%d/%d",1,(int)self.dataArray.count - 1];
                self.indexLab.hidden = YES;
                self.videoBtn.selected = YES;
                self.imgBtn.selected = NO;
            }
        }else{//全图片
            UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            [img sd_setImageWithURL:[NSURL URLWithString:self.dataArray[i]] placeholderImage:[UIImage imageNamed:@"icon_video"]];
            img.userInteractionEnabled = YES;
            [self.scrolView addSubview:img];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapClick)];
            [img addGestureRecognizer:tap];
            
            self.indexLab.text = [NSString stringWithFormat:@"%d/%d",1,(int)self.dataArray.count];
            self.indexLab.hidden = NO;
            self.videoBtn.selected = YES;
            self.imgBtn.selected = YES;
        }
    }
}

#pragma mark - action
-(void)playClick:(UIButton *)btn
{
    self.playerBlock ? self.playerBlock(btn) : nil;
}


//***  滚动视图视频图片按钮切换点击事件  **/
- (void)changeBtnClick:(UIButton *)btn{
    if (btn.tag == 1) {
        self.videoBtn.selected = YES;
        self.imgBtn.selected = NO;
        self.videoBtn.backgroundColor = MainColor;
        self.imgBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        
        if ([self.scrolView.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
            [self.scrolView setContentOffset:CGPointMake(0, 0) animated:NO];
            [self scrollViewDidEndDecelerating:self.scrolView];
        }
    }
    else{
        if (self.dataArray.count < 2) {
            return;
        }
        self.videoBtn.selected = NO;
        self.imgBtn.selected = YES;
        self.videoBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        self.imgBtn.backgroundColor = MainColor;
        if (self.scrolView.contentOffset.x < self.frame.size.width) {
            if ([self.scrolView.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
                [self.scrolView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
                [self scrollViewDidEndDecelerating:self.scrolView];
            }
        }
    }
    return;
}


-(void)imgTapClick
{
    if ([self.delegate respondsToSelector:@selector(videoView:didSelectItemAtIndexPath:)]) {
        if (self.type == TSDETAILTYPEVIDEO) {
            [self.delegate videoView:self didSelectItemAtIndexPath:imgIndex];
        }else{
            [self.delegate videoView:self didSelectItemAtIndexPath:imgIndex+1];
        }
    }
}
#pragma mark - scrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/self.bounds.size.width;
    imgIndex = index;
    if (self.type == TSDETAILTYPEVIDEO) {
        if (self.scrolView.contentOffset.x < self.frame.size.width) {
            self.indexLab.hidden = YES;
            [self.playBtn setHidden:NO];
            
            if (self.scrolView.contentOffset.x == 0) {
                self.plaerPauseBlock ? self.plaerPauseBlock(NO) : nil;
            }
        }
        else{
            self.indexLab.hidden = NO;
            [self.playBtn setHidden:YES];
        }
        self.indexLab.text = [NSString stringWithFormat:@"%d/%d",(int)index,(int)self.dataArray.count - 1];
    }else{
        self.indexLab.hidden = NO;
        self.indexLab.text = [NSString stringWithFormat:@"%d/%d",(int)index+1,(int)self.dataArray.count];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.type == TSDETAILTYPEVIDEO) {
        if (self.scrolView.contentOffset.x < self.frame.size.width) {
            self.videoBtn.selected = YES;
            self.imgBtn.selected = NO;
            self.videoBtn.backgroundColor = MainColor;
            self.imgBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
           
            if (self.scrolView.contentOffset.x == 0) {
                 //视频滑出
                 self.plaerPauseBlock ? self.plaerPauseBlock(NO) : nil;
            }

        } else{
            self.videoBtn.selected = NO;
            self.imgBtn.selected = YES;
            [self.playBtn setSelected:NO];

            self.videoBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
            self.imgBtn.backgroundColor = MainColor;
            //视频滑入
            self.plaerPauseBlock ? self.plaerPauseBlock(YES) : nil;
        }
    }else{
        return;
    }
}



- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.userInteractionEnabled = YES;
        _coverImageView.tag = 100;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.clipsToBounds = YES;
    }
    return _coverImageView;
}


-(void)initialControlUnit
{
    _scrolView = [[UIScrollView alloc]init];
    _scrolView.pagingEnabled  = YES;
    _scrolView.delegate = self;
    _scrolView.showsVerticalScrollIndicator = NO;
    _scrolView.showsHorizontalScrollIndicator = NO;
    _scrolView.userInteractionEnabled = YES;
    [self addSubview:_scrolView];
    self.scrolView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    [self.scrolView addSubview:self.coverImageView];

    _playBtn = [[UIButton alloc]init];
    _playBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
    [_playBtn setImage:[UIImage imageNamed:@"new_allPause_44x44_"] forState:UIControlStateSelected];
    [self.coverImageView addSubview:_playBtn];
    self.playBtn.frame = CGRectMake((self.frame.size.width - 60)/2.0, (self.frame.size.height - 60)/2.0, 60, 60);
    
    _indexLab = [[UILabel alloc]init];
    _indexLab.textColor = [UIColor whiteColor];
    _indexLab.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    _indexLab.font = [UIFont systemFontOfSize:11];
    _indexLab.textAlignment = 1;
    _indexLab.layer.cornerRadius = 24/2;
    _indexLab.layer.masksToBounds = YES;
    [self.indexLab setHidden:YES];
    [self addSubview:self.indexLab];
    self.indexLab.frame = CGRectMake(self.frame.size.width - 60, self.frame.size.height - 45, 50, 24);
    
    _videoBtn = [[UIButton alloc]init];
    [_videoBtn setTitle:@"视频" forState:UIControlStateNormal];
    [_videoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_videoBtn setBackgroundColor:MainColor];
    _videoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _videoBtn.layer.cornerRadius = 24/2;
    _videoBtn.layer.masksToBounds = YES;
    self.videoBtn.tag = 1;
    [self addSubview:_videoBtn];
    self.videoBtn.frame = CGRectMake(self.center.x - 70, self.frame.size.height - 45, 60, 24);
    
    _imgBtn = [[UIButton alloc]init];
    [_imgBtn setTitle:@"图片" forState:UIControlStateNormal];
    [_imgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_imgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _imgBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _imgBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    _imgBtn.layer.cornerRadius = 24/2;
    _imgBtn.layer.masksToBounds = YES;
    self.imgBtn.tag = 2;
    [self addSubview:_imgBtn];
    self.imgBtn.frame = CGRectMake(self.center.x + 10, self.frame.size.height - 45, 60, 24);
    
    
    [self.videoBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.imgBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
}


@end
