//
//  KLGuideDisplayView.m
//  mwstreet
//
//  Created by 科pro on 2019/2/1.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLGuideDisplayView.h"
@interface KLGuideDisplayView ()<UIScrollViewDelegate>
{
    UIScrollView    *_bigScrollView;
    NSMutableArray  *_imageArray;
    UIPageControl   *_pageControl;
}

@end

@implementation KLGuideDisplayView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageArray = [@[@"yindaoye",@"yindaoye2"]mutableCopy];
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
        
        scrollView.contentSize = CGSizeMake((_imageArray.count + 1)*MainWidth, MainHeight);
        //设置反野效果，不允许反弹，不显示水平滑动条，设置代理为自己
        scrollView.pagingEnabled = YES;//设置分页
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _bigScrollView = scrollView;
        
        for (int i = 0; i < _imageArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(i * MainWidth, 0, MainWidth, MainHeight);
            UIImage *image = [UIImage imageNamed:_imageArray[i]];
            imageView.image = image;
            
            [scrollView addSubview:imageView];
        }
        
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(MainWidth/2, MainHeight - 60, 0, 40)];
        pageControl.numberOfPages = _imageArray.count;
        //        //设置未激活的指示点颜色
        //        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        //        //设置当前页指示点颜色
        //        pageControl.currentPageIndicatorTintColor =MainColor;
        
        [pageControl setValue:[UIImage imageNamed:@"pageImage"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"currentPageImage"] forKeyPath:@"currentPageImage"];
        pageControl.backgroundColor = [UIColor clearColor];
        [self addSubview:pageControl];
        
        _pageControl = pageControl;
        
        
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setLayerCornerRadius:AdaptedHeight(20) borderWidth:1 borderColor:RGBSigle(255)];
        [btn setTitle:@"立即体验" forState:UIControlStateNormal];
        [btn setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        btn.frame =CGRectMake(MainWidth * (_imageArray.count-1)+(MainWidth -AdaptedWidth(150))/2, MainHeight-AdaptedHeight(95), AdaptedWidth(150), AdaptedHeight(40));
        [btn addTarget:self action:@selector(handleSingleTapFrom) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btn];
        
    }
    
    return self;
}

-(void)handleSingleTapFrom
{
    if (_pageControl.currentPage == _imageArray.count-1) {
        [UIView animateWithDuration:0.8 animations:^{
            
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            self.transform=CGAffineTransformMakeScale(1.5, 1.5);
            self.alpha =0;
            
        } completion:^(BOOL finished) {
            self.hidden = YES;
            
            [self removeFromSuperview];
        }];
        
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _bigScrollView) {
        
        CGPoint offSet = scrollView.contentOffset;
        
        _pageControl.currentPage = offSet.x/(self.bounds.size.width);//计算当前的页码
        [scrollView setContentOffset:CGPointMake(self.bounds.size.width * (_pageControl.currentPage), scrollView.contentOffset.y) animated:YES];
    }
    
    if (scrollView.contentOffset.x == (_imageArray.count) *MainWidth) {
        
        self.hidden = YES;
        [self removeFromSuperview];
    }
    
}


@end
