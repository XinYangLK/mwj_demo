//
//  KLShoppingCarTableCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLShoppingCarTableCell.h"
#import "KLNumberButton.h"

@interface KLShoppingCarTableCell ()

@property (nonatomic, strong) KLNumberButton * numberButton;

//***  商品加减操作  **/
//@property (nonatomic, strong) PPNumberButton * numberButton;

@end

@implementation KLShoppingCarTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configerUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = [self.goodsName getLableRectWithMaxWidth:MainWidth-AdaptedWidth(162)];
    
    [self.goodsName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImg.mas_top).offset =AdaptedHeight(-10);
        make.left.mas_equalTo(self.goodsImg.mas_right).offset =AdaptedWidth(34);
        make.right.offset =AdaptedWidth(-10);
        make.height.offset = size.height > AdaptedHeight(45) ? size.height : AdaptedHeight(45);
    }];
}


- (void)setModel:(PPTableViewModel *)model
{
    _model = model;
//    self.numberButton.currentNumber = model.number;
}



#pragma mark ------ 选择按钮响应
- (void)selectBtnChick:(UIButton *)sender {
    _select = !_select;
    UIImage *selectBtnImage = (_select)? [UIImage imageNamed:@"dui"] : [UIImage imageNamed:@"yuan"];
    [_selectBtn setImage:selectBtnImage forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(selectCell:selected:indexPath:)]) {
        [self.delegate selectCell:self selected:_select indexPath:self.indexPath];
    }
}




#pragma mark ------ lazy UI
- (void)configerUI {
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.goodsName];
    [self.contentView addSubview:self.goodsImg];
    [self.contentView addSubview:self.goodsSpec];
    [self.contentView addSubview:self.goodsPrice];
    [self.contentView addSubview:self.numberButton];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.width.height.offset =AdaptedWidth(30);
        make.centerY.offset =0;
    }];
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset =0;
        make.height.offset =AdaptedHeight(80);
        make.width.offset =AdaptedWidth(90);
        make.left.mas_equalTo(self.selectBtn.mas_right).offset =AdaptedWidth(8);
    }];
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImg);
        make.left.mas_equalTo(self.goodsImg.mas_right).offset =AdaptedWidth(34);
        make.right.offset =AdaptedWidth(-10);
        make.height.offset =AdaptedHeight(15);
    }];
    [self.goodsSpec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.goodsName);
        make.height.offset =AdaptedHeight(15);
        make.top.mas_equalTo(self.goodsName.mas_bottom).offset =AdaptedHeight(5);
    }];
    
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset =AdaptedHeight(-20);
        make.left.mas_equalTo(self.goodsImg.mas_right).offset =AdaptedWidth(34);
        make.height.offset =AdaptedHeight(15);
        make.width.offset =AdaptedWidth(100);
    }];
    [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset =AdaptedWidth(-10);
        make.height.offset =AdaptedHeight(25);
        make.width.offset =AdaptedWidth(90);
        make.bottom.offset =AdaptedHeight(-16);
    }];
}


- (UIButton *)selectBtn {
    if (!_selectBtn){
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(selectBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
- (UIImageView *)goodsImg {
    if (!_goodsImg){
        _goodsImg = [[UIImageView alloc]init];
        NSString *img =[NSString stringWithFormat:@"pic_%u",10 + arc4random()%7];
        _goodsImg.image =[UIImage imageNamed:img];
    }
    return _goodsImg;
}
- (UILabel *)goodsName {
    if (!_goodsName){
        _goodsName = [UILabel createLabelTextColor:TitleColor font:kFont_12];
        _goodsName.numberOfLines =2;
        _goodsName.lineSpace =4;
        _goodsName.text =@"我吧比被IE飞日额热切ceiling飞飞飞人覅而菲尔丰日富而菲尔而非i解封";
    }
    return _goodsName;
}

- (UILabel *)goodsSpec {
    if (!_goodsSpec){
        _goodsSpec = [UILabel createLabelTextColor:TextColor font:kFont_10];
        _goodsSpec.text =@"规格：重量5kg";
    }
    return _goodsSpec;
}

- (UILabel *)goodsPrice {
    if (!_goodsPrice){
        _goodsPrice = [UILabel createLabelTextColor:RedColor font:kFont_15];
        _goodsPrice.text =[NSString stringWithFormat:@"￥%u", arc4random()%1000];
    }
    return _goodsPrice;
}



- (KLNumberButton *)numberButton
{
    if (!_numberButton) {
        _numberButton = [[KLNumberButton alloc]init];
        klWeakSelf;
        _numberButton.numberBlock = ^(UILabel * _Nonnull numLab) {
            weakSelf.cellNumBlock ? weakSelf.cellNumBlock(numLab,weakSelf.indexPath) : nil;
        };
    }
    return _numberButton;
}





@end




@implementation PPTableViewModel

@end





//        CGFloat h =AdaptedHeight(25);
//        CGFloat w =AdaptedWidth(90);
//        CGFloat x = MainWidth -AdaptedWidth(10)- w;
//        CGFloat y = AdaptedHeight(110) - AdaptedHeight(40);
//        _numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(x, y, w, h)];
//        _numberButton.delegate = self;
//        // 初始化时隐藏减按钮
//        //设置边框颜色
//        _numberButton.borderColor = [UIColor grayColor];
//        _numberButton.increaseTitle = @"＋";
//        _numberButton.decreaseTitle = @"－";
//        _numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
//
//            NSLog(@"%f",number);
//        };
//        //        _numberButton.decreaseHide = YES;
//        //        _numberButton.increaseImage = [UIImage imageNamed:@"increase_meituan"];
//        //        _numberButton.decreaseImage = [UIImage imageNamed:@"decrease_meituan"];
