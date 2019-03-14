//
//  KLPublishedEvaluationCell.m
//  mwstreet
//
//  Created by 科pro on 2019/3/13.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPublishedEvaluationCell.h"
#import "UITextView+KLPlaceholder.h"

@implementation KLPublishedEvaluationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}
- (void)configUI {
    
    [self desScoreView];
    [self logScoreView];
    [self serScoreView];
    [self remarksView];
}


- (KLEvaluationScoreView *)desScoreView {
    if (!_desScoreView){
        _desScoreView = [[KLEvaluationScoreView alloc]init];
        _desScoreView.titleLab.text = @"描述相符";
        _desScoreView.starView.tag  = 10;
        [self.contentView addSubview:_desScoreView];
        [_desScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset = 0;
            make.height.offset =AdaptedHeight(28);
            make.top.offset = AdaptedHeight(16);
        }];
    }
    return _desScoreView;
}

- (KLEvaluationScoreView *)logScoreView {
    if (!_logScoreView){
        _logScoreView = [[KLEvaluationScoreView alloc]init];
        _logScoreView.titleLab.text =@"物流服务";
        _logScoreView.starView.tag  = 11;
        [self.contentView addSubview:_logScoreView];
        [_logScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(self.desScoreView);
            make.top.mas_equalTo(self.desScoreView.mas_bottom).offset = AdaptedHeight(10);
        }];
    }
    return _logScoreView;
}

- (KLEvaluationScoreView *)serScoreView {
    if (!_serScoreView){
        _serScoreView = [[KLEvaluationScoreView alloc]init];
        _serScoreView.titleLab.text = @"描述相符";
        _serScoreView.starView.tag  = 12;
        [self.contentView addSubview:_serScoreView];
        [_serScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(self.desScoreView);
            make.top.mas_equalTo(self.logScoreView.mas_bottom).offset = AdaptedHeight(10);
        }];
    }
    return _serScoreView;
}


- (UITextView *)remarksView {
    if (!_remarksView){
        _remarksView = [[UITextView alloc]init];
        _remarksView.font =AdaptedSYSFontSize(14);
        _remarksView.textColor = TitleColor;
        _remarksView.tintColor = MainColor;
        _remarksView.maxInputLength = 300;
        _remarksView.placeholder =@" 还想说点啥？写在这吧 ！";
        _remarksView.placeholderAttributes = @{NSFontAttributeName:AdaptedSYSFontSize(14),NSForegroundColorAttributeName:RGBSigle(208)};
        [_remarksView setLayerCornerRadius:0 borderWidth:0.5f borderColor:LineColor];
        [self.contentView addSubview:_remarksView];
        [_remarksView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset =AdaptedWidth(12);
            make.right.offset =AdaptedWidth(-12);
            make.top.mas_equalTo(self.serScoreView.mas_bottom).offset =AdaptedHeight(18);
            make.bottom.offset =AdaptedHeight(-8);
        }];
    }
    return _remarksView;
}



@end
