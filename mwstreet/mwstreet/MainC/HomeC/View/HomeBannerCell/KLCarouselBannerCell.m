//
//  KLCarouselBannerCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/19.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLCarouselBannerCell.h"
#define kViewTag 666
#define kCount 1

@implementation KLCarouselBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureUI];
        [self.contentView addSubview:self.cerView];
        [self.cerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset =AdaptedWidth(50);
            make.right.offset =AdaptedWidth(-50);
            make.bottom.offset = 0;
            make.height.offset =AdaptedHeight(60);
        }];
    }
    return self;
}

//***  悬浮认证框view  **/
- (KLHomePetView *)cerView {
    if (!_cerView){
        _cerView = [[KLHomePetView alloc]init];
        _cerView.petImg.image =[UIImage imageNamed:@"tx-h"];
        _cerView.nickNameLab.text =@"名称:爱迪生";
        _cerView.nameLab.text =@"泰迪";
        _cerView.ageLab.text =@"2岁";
        //点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTapChange:)];
        tap.numberOfTapsRequired = 1;
        [_cerView addGestureRecognizer:tap];
    }
    return _cerView;
}

- (void)doTapChange:(UITapGestureRecognizer *)tapRecognizer{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapBtnChick)]) {
        [self.delegate tapBtnChick];
    }
}


- (void)configureUI {
    if(self.carousel) {
        [self.carousel releaseTimer];
        [self.carousel removeFromSuperview];
    }

    CWFlowLayout *flowLayout = [[CWFlowLayout alloc] initWithStyle:CWCarouselStyle_H_1];
    flowLayout.itemSpace_H = 10;
    //***  使用frame创建视图  **/
    CWCarousel *carousel = [[CWCarousel alloc] initWithFrame:CGRectMake(0, 0, MainWidth, AdaptedHeight(143))
                                                    delegate:self
                                                  datasource:self
                                                  flowLayout:flowLayout];
    [self.contentView addSubview:carousel];
    carousel.isAuto = NO;
    carousel.autoTimInterval = 2;
    carousel.endless = YES; //是否无限轮播
    carousel.backgroundColor = [UIColor clearColor];
    [carousel registerViewClass:[UICollectionViewCell class] identifier:@"cellId"];
    [carousel freshCarousel];
    self.carousel = carousel;
}


- (void)setImageArr:(NSArray *)imageArr {
    
    self.markIndex ++;
    if (self.markIndex > 1) {
        return;
    }
    _imageArr = imageArr;
    
    self.carousel.isAuto = imageArr.count == 0 ? NO : YES;
}


- (NSInteger)numbersForCarousel {
   
    return self.imageArr.count == 0 ? kCount : self.imageArr.count;
}

#pragma mark - Delegate
- (UICollectionViewCell *)viewForCarousel:(CWCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{
    
    UICollectionViewCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor cyanColor];
    UIImageView *imgView = [cell.contentView viewWithTag:kViewTag];
    if(!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imgView.tag = kViewTag;
        imgView.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:imgView];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 8;
    }
    //    https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwio8MyTp-DdAhWKM94KHUmEDcAQjRx6BAgBEAU&url=http%3A%2F%2F699pic.com%2Ftupian%2Fchuan.html&psig=AOvVaw20gpsPpW4JcNm0mJi9dYrb&ust=1538313533814128
//    NSString *name = [NSString stringWithFormat:@"%02ld.jpg", index + 1];
   
    if (self.imageArr.count != 0) {
        UIImage * img = [UIImage imageNamed:self.imageArr[index]];
        [imgView setImage:img];
    }
    
    return cell;
}
- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index {
    
    NSLog(@"...%ld...", (long)index);
    
}






@end
