//
//  KLEvaluationListViewCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/23.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLEvaluationListViewCell.h"
#import <YYText/YYLabel.h>
#import <YYText/NSAttributedString+YYText.h>

@interface KLEvaluationListViewCell ()
//***  评价人图像  **/
@property (nonatomic, strong) UIImageView      * accoutImg;
//***  评价人昵称  **/
@property (nonatomic, strong) YYLabel          * titleLab;
//***  评价星数  **/
@property (nonatomic, strong) SYStarRatingView * starView;
//***  评价时间  **/
@property (nonatomic, strong) UILabel          * timeLab;
//***  评价内容  **/
@property (nonatomic, strong) YYLabel          * contentLab;

//***  标记 防止多次创建  **/
@property (nonatomic, assign) NSInteger           markCount;
//***  评价图片数组  **/
@property (nonatomic, strong) NSMutableArray   * imgArray;

@property (nonatomic, strong) ImagesView       * images;

//***  赞  **/
//@property (nonatomic, strong) UIButton         * praiseBtn;
////***  评价回复  **/
//@property (nonatomic, strong) UIButton         * msgBtn;

@end

@implementation KLEvaluationListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}

- (void)setEvaluationListModel:(KLEvaluationListModel *)evaluationListModel {
    _evaluationListModel = evaluationListModel;
    if (_evaluationListModel) {
        
        [self.accoutImg sd_setImageWithURL:[NSURL URLWithString:evaluationListModel.iconImage] placeholderImage:[UIImage imageNamed:@"touxiang"] completed:nil];
        
        self.titleLab.text   = evaluationListModel.iconName;
        
        self.timeLab.text    = evaluationListModel.timer;
        
        [self.praiseBtn setTitle:evaluationListModel.praiseNum forState:UIControlStateNormal];
        [self.msgBtn setTitle:evaluationListModel.msgNum forState:UIControlStateNormal];

        float num  = [evaluationListModel.scoreNum floatValue];
        [self.starView setScore:num/10 withAnimation:YES];
        
        self.contentLab.text = [NSString getBlankString:evaluationListModel.content];
        
     
        if (evaluationListModel.images.count == 0) {
            [self.images mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0).priorityMedium();
                make.bottom.mas_equalTo(self.contentView).priorityMedium();
            }];
        }
        self.images.imagesArray = [NSMutableArray arrayWithArray:evaluationListModel.images];
        
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(MainWidth - 60, CGFLOAT_MAX)];
        
        NSAttributedString *attributeString = [[NSAttributedString alloc]initWithString:evaluationListModel.iconName];
        
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:attributeString];
        
        self.titleLab.textLayout = layout;
        
      
        YYTextContainer *container2 = [YYTextContainer containerWithSize:CGSizeMake(MainWidth - AdaptedHeight(82), CGFLOAT_MAX)];
      
        NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString:evaluationListModel.content];
        text.yy_lineSpacing = 5;
        text.yy_font = kFont_14;
        text.yy_color = TitleColor;
        YYTextLayout *layout2 = [YYTextLayout layoutWithContainer:container2 text:text];
        self.contentLab.textLayout = layout2;
        self.contentLab.attributedText = text;
        
        
        [self.contentLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset   = AdaptedHeight(62);
            make.top.offset    = AdaptedHeight(80);
            make.width.offset  = MainWidth -AdaptedWidth(82);
            make.height.mas_equalTo(layout2.textBoundingSize.height);
        }];
        
    }
}



#pragma mark - lazy UI
- (void)configerUI {
    
    [self.contentView addSubview:self.accoutImg];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.timeLab];
    [self.contentView addSubview:self.contentLab];
    [self.contentView addSubview:self.images];
    [self.contentView addSubview:self.msgBtn];
    [self.contentView addSubview:self.praiseBtn];
    
    [self.accoutImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.top.offset = AdaptedHeight(10);
        make.width.height.offset =AdaptedWidth(31);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.accoutImg.mas_right).offset =AdaptedWidth(20);
        make.height.offset =AdaptedHeight(15);
        make.centerY.mas_equalTo(self.accoutImg);
        make.right.offset =AdaptedWidth(-90);
    }];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset =AdaptedHeight(15);
        make.height.offset =AdaptedHeight(15);
    }];
    
    [self.images mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLab.mas_bottom).offset =AdaptedHeight(5);
        make.left.offset = AdaptedWidth(62);
        make.right.mas_equalTo(self.contentView).offset(AdaptedWidth(-80));
        make.height.mas_equalTo(0).priorityLow();
        make.bottom.mas_equalTo(self.contentView).offset(-AdaptedHeight(20)).priorityLow();
    }];
    
    [self.msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset =AdaptedWidth(-6);
        make.height.offset =AdaptedHeight(15);
        make.bottom.offset =AdaptedHeight(-10);
        make.width.offset =AdaptedWidth(65);
    }];
    [self.praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.msgBtn.mas_left).offset =AdaptedWidth(-3);
        make.centerY.width.height.mas_equalTo(self.msgBtn);
    }];
    
}

- (ImagesView *)images
{
    if (!_images) {
        _images = [[ImagesView alloc] init];
        @weakify(self)
        _images.imagesBlock = ^(UIButton * _Nonnull sender, NSMutableArray * _Nonnull imgArray) {
           @strongify(self)
            self.goodsImagesBlock ? self.goodsImagesBlock(sender, imgArray,self.indexPath) : nil;
        };
    }
    return _images;
}


- (UIImageView *)accoutImg {
    if (!_accoutImg){
        _accoutImg = [[UIImageView alloc]init];
        _accoutImg.image =[UIImage imageNamed:@"tx-h"];
        [_accoutImg setLayerCornerRadius:AdaptedWidth(15.5)];
    }
    return _accoutImg;
}

- (YYLabel *)titleLab {
    if (!_titleLab){
        _titleLab = [YYLabel new];
        _titleLab.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _titleLab.displaysAsynchronously = YES;
        _titleLab.ignoreCommonProperties = YES;
        _titleLab.fadeOnHighlight = NO;
        _titleLab.fadeOnAsynchronouslyDisplay = NO;
        _titleLab.textColor = RGBSigle(51);
        _titleLab.font =kFont_14;
        _titleLab.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
            
        };
    }
    return _titleLab;
}

- (SYStarRatingView *)starView {
    if (!_starView){
        _starView = [[SYStarRatingView alloc]initWithFrame:CGRectMake(MainWidth-AdaptedWidth(85), AdaptedHeight(20), AdaptedWidth(75), AdaptedHeight(12))];
        _starView.foregroundImageName = @"xin_h";
        _starView.backgroundImageName = @"xin";
        _starView.isMove =NO;
        _starView.foregroundViewColor = MainColor;
    }
    return _starView;
}

- (UILabel *)timeLab {
    if (!_timeLab){
        _timeLab = [UILabel createLabelTextColor:TextColor font:kFont_12];
    }
    return _timeLab;
}


- (YYLabel *)contentLab {
    if (!_contentLab){
        _contentLab = [YYLabel new];
        _contentLab.textColor = RedColor;
        _contentLab.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _contentLab.displaysAsynchronously = YES;
        _contentLab.ignoreCommonProperties = YES;
        _contentLab.fadeOnHighlight = NO;
        _contentLab.fadeOnAsynchronouslyDisplay = NO;
        _contentLab.numberOfLines = 0;
        _contentLab.font =kFont_14;
        _contentLab.preferredMaxLayoutWidth = MainWidth -AdaptedWidth(82);
        _contentLab.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        };
    }
    return _contentLab;
}

- (UIButton *)praiseBtn {
    if (!_praiseBtn){
        @weakify(self)
        _praiseBtn = [UIButton createBtnTitle:@""
                                   titleColor:TextColor
                                         font:kFont_12
                                    imageName:@"zan"
                               backgrounColor:[UIColor clearColor]
                          SSImagePositionType:SSImagePositionTypeLeft
                                      spacing:4
                                       action:^(UIButton * _Nonnull button) {
                                           @strongify(self)
                                           self.praiseBlock ? self.praiseBlock(button, self.indexPath) : nil;
                                       }];
                      
    }
    return _praiseBtn;
}

- (UIButton *)msgBtn {
    if (!_msgBtn){
        @weakify(self)
        _msgBtn = [UIButton createBtnTitle:@""
                                titleColor:TextColor
                                      font:kFont_12
                                 imageName:@"xiaoxi"
                            backgrounColor:[UIColor clearColor]
                       SSImagePositionType:SSImagePositionTypeLeft
                                   spacing:4
                                    action:^(UIButton * _Nonnull button) {
                                        @strongify(self)
                                        self.msgBlock ? self.msgBlock(button, self.indexPath) : nil;
                                    }];
        
    }
    return _msgBtn;
}


@end



@interface ImagesView ()

@property(nonatomic ,strong)NSMutableArray * buttonArray;

@end

@implementation ImagesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpUI];
    }
    return self;
}

-(void)SetUpUI{
    
    //单行布局 不需要考虑换行的问题
    CGFloat marginX = 0;  //按钮距离左边和右边的距离
    CGFloat marginY = 0;  //按钮距离布局顶部的距离
    CGFloat toTop   = AdaptedHeight(10);  //布局区域距离顶部的距离
    CGFloat gap     = AdaptedWidth(10);    //按钮与按钮之间的距离
    NSInteger col   = 4;    //这里只布局3列
    NSInteger count = 4;    //这里先设置布局3个按钮
    
    CGFloat viewWidth = AdaptedWidth(140);  //视图的宽度
    CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1) * gap)/col * 1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat height = AdaptedHeight(33);   //按钮的高度可以根据情况设定 这里设置为相等
    
    UIButton *lastBtn = nil;   //上一个按钮
    //准备工作完毕 既可以开始布局了
    for (int i = 0 ; i < count; i++) {
        UIButton * btnImg =[UIButton buttonWithType:UIButtonTypeCustom];
        btnImg.tag = i + 120;
        btnImg.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btnImg addTarget:self action:@selector(btnImgChick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnImg];
        [btnImg mas_makeConstraints:^(MASConstraintMaker *make) {
            //宽高是固定的，前面已经算好了
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(height);
            //topTop距离顶部的距离，单行不用考虑太多，多行，还需要计算距离顶部的距离
            make.top.mas_offset(toTop + marginY);
            if (!lastBtn) {  //last为nil 说明是第一个按钮
                make.left.mas_offset(marginX);
            }else{
                //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
                make.left.mas_equalTo(lastBtn.mas_right).mas_offset(gap);
            }
        }];
        lastBtn = btnImg;
        [self.buttonArray addObject:btnImg];
    }
}

- (void)btnImgChick:(UIButton *)sender {
    
    self.imagesBlock ? self.imagesBlock(sender,self.imagesArray) : nil;
}
    


-(void)setImagesArray:(NSMutableArray *)imagesArray
{
    _imagesArray = imagesArray;
    
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx<self.imagesArray.count) {
            
            [button sd_setImageWithURL:[NSURL URLWithString:self.imagesArray[idx]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"1_sdgvxc"]  options:SDWebImageProgressiveDownload];
            
            button.hidden = NO;
            
        }else{
            
            button.hidden = YES;
        }
    }];
    
    
    if (imagesArray.count == 0) {
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(20).priorityMedium();
        }];
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.offset =AdaptedHeight(33);
            
        }];
    }
    
}

#pragma mark - Getter

- (NSMutableArray *)buttonArray
{
    if(!_buttonArray){
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}


@end
