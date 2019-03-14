//
//  KLMyDistributionCenterCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/1.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyDistributionCenterCell.h"

@implementation KLMyDistributionCenterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.tvCellView];
        [self.tvCellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

- (KLMultipleColumnsTVCell *)tvCellView {
    if (!_tvCellView){
        _tvCellView = [[KLMultipleColumnsTVCell alloc]init];
    }
    return _tvCellView;
}


-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    self.tvCellView.indexPath = self.indexPath;
    self.tvCellView.dataArray = _dataArray;
}

- (void)setImgArray:(NSArray *)imgArray {
    
    _imgArray = imgArray;
    self.tvCellView.imgArray = _imgArray;
}


@end
