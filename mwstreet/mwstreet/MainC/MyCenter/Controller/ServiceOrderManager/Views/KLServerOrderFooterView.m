//
//  KLServerOrderFooterView.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLServerOrderFooterView.h"

@implementation KLServerOrderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        [self configUI];
    }
    return self;
}

- (void)setRightText:(NSString *)rightText {
    _rightText = rightText;
    [self.rightBtn setTitle:_rightText forState:UIControlStateNormal];
}


- (void)setLeftText:(NSString *)leftText {
    _leftText = leftText;
    [self.leftBtn setTitle:_leftText forState:UIControlStateNormal];
    
}


#pragma mark - lazy -- UI
- (void)configUI {
   
    [self rightBtn];
    [self leftBtn];
}

- (UIButton *)rightBtn {
    if (!_rightBtn){
         @weakify(self)
        _rightBtn = [UIButton zj_buttonWithTitle:self.rightText
                                      titleColor:RedColor
                                        norImage:nil
                                   selectedImage:nil
                                       backColor:[UIColor whiteColor]
                                        fontSize:12
                                          isBold:NO
                                     borderWidth:1
                                     borderColor:RedColor
                                    cornerRadius:5
                                         supView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.right.offset   = AdaptedWidth(-11);
                                         make.width.offset   = AdaptedWidth(65);
                                         make.height.offset  = AdaptedHeight(25);
                                         make.centerY.offset = 0;
                                     } touchUp:^(id sender) {
                                         @strongify(self)
                                         self.footerBtnBlock ? self.footerBtnBlock(sender,self.indexPath) : nil;                                         
                                     }];
    }
    return _rightBtn;
}



- (UIButton *)leftBtn {
    if (!_leftBtn){
         @weakify(self)
        _leftBtn = [UIButton zj_buttonWithTitle:self.leftText
                                     titleColor:TextColor
                                       norImage:nil
                                  selectedImage:nil
                                      backColor:[UIColor whiteColor]
                                       fontSize:12
                                         isBold:NO
                                    borderWidth:1
                                    borderColor:TextColor
                                   cornerRadius:5
                                        supView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.right.mas_equalTo(self.rightBtn.mas_left).offset = AdaptedWidth(-18);
                                        make.width.height.centerY.mas_equalTo(self.rightBtn);
                                    } touchUp:^(id sender) {@strongify(self)
                                        self.footerBtnBlock ? self.footerBtnBlock(sender,self.indexPath) : nil;
                                    }];
    }
    return _leftBtn;
}

@end
