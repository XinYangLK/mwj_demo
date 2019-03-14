//
//  KLEditPhotoView.m
//  VisaModules
//
//  Created by 科pro on 2018/11/28.
//  Copyright © 2018年 palmble. All rights reserved.
//

#import "KLEditPhotoView.h"

@interface KLRemoveButton :UIButton
@property(weak,nonatomic) UIButton *removeBtn;
@end

@implementation KLRemoveButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *removeBtn = [[UIButton alloc]init];
        [removeBtn addTarget:self action:@selector(removeImageIcon:) forControlEvents:UIControlEventTouchUpInside];
        [removeBtn setImage:[UIImage imageNamed:@"dele"] forState:UIControlStateNormal];
        [self addSubview:removeBtn];
        self.removeBtn = removeBtn;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat removeW = 34;
    CGFloat removeH = removeW;
    CGFloat removeX = self.width - removeW + 12;
    CGFloat removeY = - removeW/2;
    self.removeBtn.frame = CGRectMake(removeX, removeY, removeW, removeH);
}
-(void)removeImageIcon:(UIButton *)button{
    //    NSLog(@"--removeImageIcon--");
    UIButton *willDisBtn = (UIButton *)button.superview;
    //    [button.superview removeFromSuperview];
    //当某张图片删除时候，我们发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kDeleteAPicFromView" object:nil userInfo:@{@"obj":willDisBtn}];
}

@end






static NSInteger const kMaxColumn      = 4;          //最大列数

@interface KLEditPhotoView ()
/**  提示文字 */
@property(weak, nonatomic)  UILabel *noticeLab;
/**  加号按钮 */
@property(strong,nonatomic) UIButton *addBtn;
/**  用于存放照片的控制器 */
@property(nonatomic,strong)NSMutableArray *photoes;

#define KLImage [UIImage imageNamed:@"wwetryu"]

@end
@implementation KLEditPhotoView

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc]init];
        [_addBtn setBackgroundImage:KLImage forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addImages:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(NSMutableArray *)photoes{
    if (!_photoes) {
        _photoes = [[NSMutableArray alloc]init];
    }
    return _photoes;
}
#pragma mark - 初始化
+ (id)editPhotoView{
    
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubviews];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self createSubviews];
    }
    return self;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.noticeLab.text = titleStr;
}

/**  创建子view */
-(void)createSubviews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetPostNofificationForDeletePic:) name:@"kDeleteAPicFromView" object:nil];
    //添加一个提示按钮
    UILabel *noticeLab = [[UILabel alloc]init];
    noticeLab.textColor = RGBSigle(51);
    [self addSubview:noticeLab];
    noticeLab.font = kFont_14;
    self.noticeLab = noticeLab;
   

    /**  添加加号图片 */
    [self.photoes addObject:KLImage];
    //添加button
    for (int i = 0; i<self.photoes.count; i++) {
        UIButton *button = nil;
       
        if (self.photoes.count == i+1) {
            //最后一个用来添加图片
            button = self.addBtn;
        }
        else{
            //在button上添加一个删除按钮
            button = [[KLRemoveButton alloc]init];
        }
        button.contentMode = UIViewContentModeCenter;
        [button setBackgroundImage:self.photoes[i] forState:UIControlStateNormal];
        [self addSubview:button];
    }
}


#pragma mark - 删除图片的通知处理事件和移除通知监听
-(void)GetPostNofificationForDeletePic:(NSNotification *)noti{
    
    UIButton *button = noti.userInfo[@"obj"];
    //获取tag,然后删除数组中的元素,开始的tag = 46（不能算lable）
    NSInteger concreteNo =  (button.tag - 46) + 1;
    //先从照片中remove ,然后是数组
    [self.photoes removeObjectAtIndex:(concreteNo-1)];
    [button removeFromSuperview];
    //删除照片的时候，我们判断的数量，添加“+”
    BOOL isShow = [self.subviews containsObject:self.addBtn];
    if (self.photoes.count == self.pageIndex - 2 && !isShow) {
        [self.photoes addObject:KLImage];
        [self addSubview:self.addBtn];
    }
    [self updateNoticeText];
    [self setNeedsLayout];
}

-(void)dealloc{
    @try {
        [[NSNotificationCenter debugDescription] removeObserver:self forKeyPath:@"kDeleteAPicFromView"];
    }
    @catch (NSException *exception) {
        NSLog(@"多次删除kvo 报错了");
    }
}
#pragma mark - 添加图片
-(void)addImages:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(editPhotoViewToOpenAblum:)]) {
        [self.delegate editPhotoViewToOpenAblum:self];
    }
}


//布局
-(void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat labX = AdaptedWidth(12);
    CGFloat labY = AdaptedHeight(17);
    CGFloat labW = AdaptedWidth(200);
    CGFloat labH = AdaptedHeight(15);
    self.noticeLab.frame = CGRectMake(labX, labY, labW, labH);
    
    //设置button的frame
    CGFloat buttonW = (MainWidth- AdaptedWidth(60))/4; // kImageViewWidth;
    CGFloat buttonH = buttonW;
    CGFloat kMargin = AdaptedHeight(52);
    CGFloat kMarginW = AdaptedWidth(12);
        
    for (int i = 1; i < self.subviews.count; ++ i) {
        UIButton *sub = self.subviews[i];
        sub.tag = 45 + i;//从46开始
        if ([sub isKindOfClass:[UIButton class]]) {
            CGFloat currentRow = (i-1)/kMaxColumn;
            NSInteger currentCol = (i-1)%kMaxColumn;
            CGFloat buttonX = currentCol * (buttonW + kMarginW) + kMarginW;
            CGFloat buttonY;
            if (currentRow == 0) {
                buttonY = currentRow *(buttonW + kMargin) + kMargin;
            }else{
                buttonY = currentRow * (buttonW + kMargin) + AdaptedHeight(12);
            }
            sub.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            [sub addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        sub.contentMode = UIViewContentModeCenter;
        [sub setBackgroundImage:self.photoes[i-1] forState:UIControlStateNormal];
    }
    //判断自己的view的高度
    NSInteger currentRow = (self.photoes.count - 1)/ kMaxColumn + 1;//至少有一行
    [self setHeight:currentRow *(buttonW + AdaptedHeight(12)) + kMargin];// + labH + labY];
}


- (void)btnChick:(UIButton *)sender{
    
    if (![sender.currentBackgroundImage isEqual:KLImage]) {
        @weakify(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(previewPhotosBtn:img:editView:block:)]) {
            @strongify(self)
            [self.delegate previewPhotosBtn:sender img:sender.imageView.image editView:self block:^(UIImage *img) {
                
                [sender setBackgroundImage:img forState:UIControlStateNormal];
                
            }];
        }
    }
}




-(void)addOneImage:(UIImage *)image{
    
    [self.photoes insertObject:image atIndex:(self.photoes.count - 1)];
    //在button上添加一个删除按钮
    KLRemoveButton *button = [[KLRemoveButton alloc]init];
    [self insertSubview:button atIndex:(self.subviews.count - 1)];
    //判断照片的数量，如果10张，我们就删除“+”
    if (self.photoes.count == self.pageIndex) {
        [self.photoes removeLastObject];
        [self.addBtn removeFromSuperview];
    }
    [self updateNoticeText];
    [self setNeedsLayout];
}


//更新noticeLab的文字
- (void)updateNoticeText{
    NSInteger picCount = [self fetchPhotos].count;
//    self.noticeLab.text = [NSString stringWithFormat:@"为了照片质量，请有限发横图(%ld/8)",picCount];
    
    if ([self.delegate respondsToSelector:@selector(fetchPhotosNumber:editView:)]) {
        [self.delegate fetchPhotosNumber:picCount editView:self];
    }
}
#pragma 获取图片数组
- (NSArray *)fetchPhotos{
    //判断self.addBtn 是否在view中，用来确定是否返回
    if ([self.subviews containsObject:self.addBtn]) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:self.photoes];
        [temp removeLastObject];
        return temp;
    }else{
        return self.photoes;
    }
}


@end
