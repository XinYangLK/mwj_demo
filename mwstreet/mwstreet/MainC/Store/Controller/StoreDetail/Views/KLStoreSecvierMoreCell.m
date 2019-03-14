//
//  KLStoreSecvierMoreCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/1.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreSecvierMoreCell.h"

@interface KLStoreSecvierMoreCell()

@property (nonatomic, strong) UIView *line;

@end

@implementation KLStoreSecvierMoreCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self line];
    }
    return self;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.right.top.offset = 0;
                                     make.height.offset =0.5f;
                                 }];
    }
    return _line;
}


@end
