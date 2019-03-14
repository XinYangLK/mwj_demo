//
//  KLStoreGoodsSpecController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/31.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreGoodsSpecController.h"
#import <SKUDataFilter/ORSKUDataFilter.h>
#import "KLAttributeModel.h" //商品规格 model
#import "KLPropertyCollectionCell.h"   //商品规格cell
#import "KLPropertyCollectionHeader.h" //商品规格header
#import "KLPropertyCollectionFooter.h" //商品规格footer
#import "KLCountFooterView.h"          //底部数量操作view

#define  Padding  10

@interface KLStoreGoodsSpecController ()
<
ORSKUDataFilterDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
//数据源
@property (nonatomic, strong) NSArray          * dataSource;
//sku数据
@property (nonatomic, strong) NSArray          * skuData;;
//items记录选中
@property (nonatomic, strong) NSMutableArray <NSIndexPath *>*selectedIndexPaths;

//skug过滤器
@property (nonatomic, strong) ORSKUDataFilter  * filter;
//商品图片
@property (strong, nonatomic) UIImageView      * goodsImageView;
//商品价格
@property (strong, nonatomic) UILabel          * priceLab;
//商品库存
@property (strong, nonatomic) UILabel          * stockLab;
//商品规格选择详情
@property (strong, nonatomic) UILabel          * specLab;
//分割线
@property (strong, nonatomic) UIView           * line;
//属性列表
@property (strong, nonatomic) UICollectionView * collectionView;
//加入购物车
@property (strong, nonatomic) UIButton         * addCartBtn;
//立即购买
@property (strong, nonatomic) UIButton         * buyGoodsBtn;


/**  商品属性模型   */
@property (strong, nonatomic) KLAttributeModel * attrModel;
/** 已选商品属性id  */
@property (nonatomic, copy)   NSString         * spec_id;
/** 选择商品的数量  */
@property (nonatomic, copy)   NSString         * quantity;
/** 选择商品的属性描述  */
@property (nonatomic, copy)   NSString         * specification;
/**  所选属性最大数量   */
@property (nonatomic, assign) NSInteger          maxQuantity;
/**  已选商品属性模型   */
@property (strong, nonatomic) Attribute        * choosedAttribute;
/** 选择提示语  */
@property (nonatomic, copy) NSString           * noteSpec;
@end

@implementation KLStoreGoodsSpecController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self fetchGoodsAttributesData];
}
#pragma mark - 响应方法
//***  加入购物车  **/
- (void)addCartBtnClick:(UIButton *)sender {
    
    KLLog(@"加入购物车");
    if ([self.specLab.text isEqual:@"请选择 属性"]) {
        [EasyTextView showText:@"请选择 完整属性"];
        return;
    }
    //***  选择商品的属性描述  **/
    [self finishChooseAttribute];
    
    if (self.storeId == 73) {
        [EasyTextView showText:@"此商品不能加入购物车！"];
        return;
    }
    
    if ([self.specification isEqual:@""]) {// 未选择商品属性，给予提示
        NSString * msg = [NSString stringWithFormat:@"请选择 %@ ", _noteSpec];
        [EasyTextView showText:msg];
        return;
    }
    
    //***  加入购物车  **/
    [self addCartGoodsIsBuyNow:NO];
}

//***  立即购买  **/
- (void)buyNowBtnClick:(UIButton *)sender {
    

     //***  选择商品的属性描述  **/
    [self finishChooseAttribute];
    
    if ([_specification isEqual:@""]) {// 未选择商品属性，给予提示

        NSString * msg = [NSString stringWithFormat:@"请选择 %@ ", _noteSpec];
        [EasyTextView showText:msg];
        return;
    }
    [self dismissFeatureViewControllerWithTag:1];
//    [self addCartGoodsIsBuyNow:YES];
}



//***  加入购物车  **/
- (void)addCartGoodsIsBuyNow:(BOOL)isBuyNow {
   
    KLLog(@"加入购物车");
}

//***  选择商品的属性描述  **/
- (void)finishChooseAttribute {
    
    self.spec_id = [NSString stringWithFormat:@"%ld",(long)self.choosedAttribute.spec_id];
    
    NSMutableArray *specArray = @[].mutableCopy;
    for (AttributeInfo *info in self.choosedAttribute.info) {
        NSString *tempStr = [NSString stringWithFormat:@"%@:%@", info.tabName, info.tabValue];
        [specArray addObject:tempStr];
    }
    
    KLLog(@"----%@--%@",self.spec_id,
          ([NSString isBlankString:self.quantity] ? @"1" : self.quantity));
    self.specification = [specArray componentsJoinedByString:@" "];
}



#pragma mark - 退出当前界面
- (void)dismissFeatureViewControllerWithTag:(NSInteger)tag {
    
    klWeakSelf;
    [self dismissViewControllerAnimated:YES completion:^{
        NSDictionary * dic =[NSDictionary dictionary];
        weakSelf.attributeInfoBlock ?  weakSelf.attributeInfoBlock(dic) : nil;
 
//        if (_selectedArr.count == self.dataSource.count) {//当选择全属性才传递出去
//
//            dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//
//                NSDictionary *paDict = @{
//                                         @"Tag" : [NSString stringWithFormat:@"%zd",tag],
//                                         @"goods_id" : self.goodsId,
//                                         @"Array" : _selectedArr
//                                         };
//                NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:paDict];
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"goods_proprety_noti" object:nil userInfo:dict];
//
//            });
//        }
//        UIWindow *widow = [UIApplication sharedApplication].keyWindow;
//        widow.backgroundColor = [UIColor whiteColor];
    }];
}




#pragma mark - 网络请求数据

- (void)fetchGoodsAttributesData {
    
    NSDictionary *productlistDic = [NSDictionary new];
    
    if (![self.goodsId isEqual:@"402"]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"productSpec1" ofType:@"json"];
        NSString *productlistStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
        productlistDic = [productlistStr mj_JSONObject];
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"productSpec2" ofType:@"json"];
        NSString *productlistStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
        productlistDic = [productlistStr mj_JSONObject];
    }
    //***  数据 model  **/
    self.attrModel = [KLAttributeModel mj_objectWithKeyValues:productlistDic[@"data"]];
    
    //***  规格数据  **/
    self.dataSource = productlistDic[@"data"][@"spec"];
    
    //组合选择提示语 + sku 商品信息数组
    [self setNoteSpecSkuData];
    
    // UI 初始化加载
    [self refreshAttributesView];
    
}

// 组合选择提示语 + sku 商品信息数组
- (void)setNoteSpecSkuData{
    
    // 组合选择提示语
    NSMutableArray *noteSpecArr = @[].mutableCopy;
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [noteSpecArr addObject:obj[@"key"]];
    }];
    self.noteSpec = [noteSpecArr componentsJoinedByString:@" "];
    
    // sku 商品信息数组
    NSMutableArray *skuArray = @[].mutableCopy;
    [self.attrModel.list enumerateObjectsUsingBlock:^(Attribute * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
        dic[@"contition"] = obj.spec;
        dic[@"price"] = [NSString stringWithFormat:@"%.2f", obj.price];
        dic[@"store"] = obj.stock;
        dic[@"model"] = obj;
        [skuArray addObject:dic];
    }];
    self.skuData = skuArray;
}

// UI 初始化加载
- (void)refreshAttributesView {
    
    //初始化选择 记录 index
    self.selectedIndexPaths = [NSMutableArray array];
    //初始化 sku 算法
    self.filter = [[ORSKUDataFilter alloc] initWithDataSource:self];
    //布局UI
    [self setupSubViews];
}


#pragma mark -- UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource[section][@"value"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KLPropertyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLPropertyCollectionCell class]) forIndexPath:indexPath];
    
    //***  属性赋值  **/
    NSArray *data = self.dataSource[indexPath.section][@"value"];
    cell.propertyLab.text = data[indexPath.row];
    
    if ([self.filter.availableIndexPathsSet containsObject:indexPath]) {
        //当前可选属性 颜色
        [cell setLayerCornerRadius:5 borderWidth:1 borderColor:LineColor];
        cell.contentView.backgroundColor = MainColor;
        cell.propertyLab.textColor = TitleColor;
        
    }else {
         //当前不可选属性 颜色
        [cell setLayerCornerRadius:5 borderWidth:1 borderColor:LineColor];
        cell.contentView.backgroundColor = LineColor;
        cell.propertyLab.textColor = TextColor;
    }
    
    if ([self.filter.selectedIndexPaths containsObject:indexPath]) {
         //当前选中属性 颜色
        [cell setLayerCornerRadius:5 borderWidth:1 borderColor:MainColor];
        cell.contentView.backgroundColor = MainColor;
        cell.propertyLab.textColor = MainColor;
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
//    klWeakSelf;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
       //***  属性头名称  **/
        KLPropertyCollectionHeader *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([KLPropertyCollectionHeader class]) forIndexPath:indexPath];
        view.headerNameLab.text = _dataSource[indexPath.section][@"key"];
        return view;
        
    } else {
        
        if (indexPath.section == self.dataSource.count - 1) {
            
            KLCountFooterView *countView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([KLCountFooterView class]) forIndexPath:indexPath];
            
            countView.maxValue = self.maxQuantity;
            @weakify(self)
            countView.changeNumCellBlock = ^(CGFloat number) {//选择商品数量
                @strongify(self)
                self.quantity = [NSString stringWithFormat:@"%.0f", number];
            };
            return countView;
        }
        
        KLPropertyCollectionFooter *line = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([KLPropertyCollectionFooter class]) forIndexPath:indexPath];
        
        return line;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.filter didSelectedPropertyWithIndexPath:indexPath];
    [collectionView reloadData];
    [self action_complete];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *data  = self.dataSource[indexPath.section][@"value"];
    NSString *text = data[indexPath.row];
    CGFloat width  = [NSString calculateRowWidth:text withHeight:20 font:kScreenWidthRatio * 12];
    return CGSizeMake(width + Padding * 4, AdaptedHeight(25));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
   
    return UIEdgeInsetsMake(0, Padding, 0, Padding);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
   
    return CGSizeMake(ScreenWidth, 44);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
   
    if (section == self.dataSource.count - 1) {
        
        return CGSizeMake(ScreenWidth, 60);
    }
    return CGSizeMake(ScreenWidth - Padding * 2, 11);
    
}



#pragma mark -- ORSKUDataFilterDataSource
- (NSInteger)numberOfSectionsForPropertiesInFilter:(ORSKUDataFilter *)filter {
    return self.dataSource.count;
}

- (NSArray *)filter:(ORSKUDataFilter *)filter propertiesInSection:(NSInteger)section {
    
    return self.dataSource[section][@"value"];
}

- (NSInteger)numberOfConditionsInFilter:(ORSKUDataFilter *)filter {
    
    return self.skuData.count;
}

- (NSArray *)filter:(ORSKUDataFilter *)filter conditionForRow:(NSInteger)row {
    
    NSString *condition = self.skuData[row][@"contition"];
    return [condition componentsSeparatedByString:@","];
}

- (id)filter:(ORSKUDataFilter *)filter resultOfConditionForRow:(NSInteger)row {
    
    NSDictionary *dic = self.skuData[row];
    return @{@"price": dic[@"price"],
             @"store": dic[@"store"],
             @"model": dic[@"model"]
             };
}


- (void)action_complete {
    
    NSDictionary *dic = self.filter.currentResult;
    if (dic == nil) {
        NSLog(@"请选择完整 属性");
//        if (_goodsModel.goodsInfo.store_id == 72) {
//            self.priceLab.text = [NSString stringWithFormat:@"%.2f", _goodsModel.goodsInfo.price];
//        } else {
//             self.priceLab.text = [NSString stringWithFormat:@"￥%.2f", _goodsModel.goodsInfo.price];
//        }
//        self.stockLab.text = [NSString stringWithFormat:@"库存%ld件", _goodsModel.storeInfo.goodsCount];
//        self.stockLab.text = @"请选择 属性";

        return;
    }
    
    Attribute *attribute = dic[@"model"];
//    if (_goodsModel.goodsInfo.store_id == 72) {
//        self.priceLab.text = [NSString stringWithFormat:@"%@", dic[@"price"]];
//    } else {
//        self.priceLab.text = [NSString stringWithFormat:@"￥%@", dic[@"price"]];
//    }
    self.stockLab.text = [NSString stringWithFormat:@"库存%@件",dic[@"store"]];
    self.specLab.text = [NSString stringWithFormat:@"已选择 %@", attribute.spec];
   
    klWeakSelf;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"gipjd_1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
           
            weakSelf.goodsImageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                weakSelf.goodsImageView.alpha = 1.0f;
            }];
            
        } else {
            
            weakSelf.goodsImageView.alpha = 1.0f;
        }
    }];
    
    // 重置最大选择数量
    self.maxQuantity = [attribute.stock integerValue];
    self.choosedAttribute = attribute;
}



#pragma mark - lazy UI

- (void)setupSubViews {
    
    [self.view addSubview:self.goodsImageView];
    [self.view addSubview:self.priceLab];
    [self.view addSubview:self.stockLab];
    [self.view addSubview:self.specLab];
    [self.view addSubview:self.line];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.addCartBtn];
    [self.view addSubview:self.buyGoodsBtn];
    
    klWeakSelf;
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"gipjd_1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            weakSelf.goodsImageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                weakSelf.goodsImageView.alpha = 1.0f;
            }];
        } else {
            weakSelf.goodsImageView.alpha = 1.0f;
        }
    }];
    
    //    self.quantity = @"1";
    //
    //    self.maxQuantity = self.goodsModel.storeInfo.goodsCount;
    //    self.stockLab.text = [NSString stringWithFormat:@"库存%ld件", _goodsModel.storeInfo.goodsCount];
    //    if (_goodsModel.goodsInfo.store_id == 72) {
    //        self.priceLab.text = [NSString stringWithFormat:@"%.2f", _goodsModel.goodsInfo.price];
    //    } else {
    //        self.priceLab.text = [NSString stringWithFormat:@"￥%.2f", _goodsModel.goodsInfo.price];
    //    }
}


#pragma mark - UI 布局
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top).offset(-Padding * 2);
        make.left.equalTo(self.view).offset(Padding);
        make.width.height.offset(AdaptedHeight(90));
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top).offset(Padding);
        make.left.equalTo(self.goodsImageView.mas_right).offset(Padding);
    }];
    
    [self.stockLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.priceLab.mas_bottom).offset(5);
        make.left.equalTo(self.priceLab).offset(0);
    }];
    
    [self.specLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.stockLab.mas_bottom).offset(5);
        make.left.equalTo(self.priceLab).offset(0);
    }];
    
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(AdaptedHeight(15));
        make.left.equalTo(self.view).offset(Padding);
        make.right.equalTo(self.view.mas_right).offset(-Padding);
        make.height.offset(1);
    }];
    
    if (self.fromBuyNow) {
        
        [self.buyGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self.view.mas_right).offset(0);
            make.top.offset(MainHeight/2-AdaptedHeight(44)-TabbarSafeBottomMargin);
            make.height.offset(AdaptedHeight(44));
            make.width.offset(MainWidth);
        }];
        
    } else {
        
        
        [self.buyGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self.view.mas_right).offset(0);
            make.top.offset(MainHeight/2 -AdaptedHeight(44) -TabbarSafeBottomMargin);
            make.height.offset(AdaptedHeight(44));
            make.width.offset(MainWidth / 2);
        }];
        
       
        [self.addCartBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self.buyGoodsBtn.mas_left);
            make.width.height.top.mas_equalTo(self.buyGoodsBtn);
        }];
    }
    
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.line.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.buyGoodsBtn.mas_top).offset(0);
    }];
    
    
    
}

- (UIImageView *)goodsImageView {
    
    if (!_goodsImageView){
        _goodsImageView = [[UIImageView alloc]init];
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
        _goodsImageView.clipsToBounds = YES;
        [_goodsImageView setLayerCornerRadius:5 borderWidth:5 borderColor:[UIColor whiteColor]];
    }
    return _goodsImageView;
}

- (UILabel *)priceLab {
    
    if (!_priceLab){
        _priceLab = [UILabel createLabelTextColor:RedColor font:kFont_14];
    }
    return _priceLab;
}

- (UILabel *)stockLab {
    
    if (!_stockLab){
        _stockLab = [UILabel createLabelTextColor:TitleColor font:kFont_13];
    }
    return _stockLab;
}

- (UILabel *)specLab {
    
    if (!_specLab){
        _specLab = [UILabel createLabelTextColor:TitleColor font:kFont_13];
    }
    return _specLab;
}

- (UIView *)line {
    
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor = LineColor;
    }
    return _line;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView){
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[KLPropertyCollectionCell class]
            forCellWithReuseIdentifier:NSStringFromClass([KLPropertyCollectionCell class])];
        [_collectionView registerClass:[KLPropertyCollectionHeader class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:NSStringFromClass([KLPropertyCollectionHeader class])];
        [_collectionView registerClass:[KLPropertyCollectionFooter class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:NSStringFromClass([KLPropertyCollectionFooter class])];
        [_collectionView registerClass:[KLCountFooterView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:NSStringFromClass([KLCountFooterView class])];
        [_collectionView reloadData];
        [_collectionView setContentInset:UIEdgeInsetsMake(0, 0, 44, 0)];
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                      animated:YES
                                scrollPosition:UICollectionViewScrollPositionNone];
    }
    return _collectionView;
}

- (UIButton *)addCartBtn {
    
    if (!_addCartBtn){
        _addCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addCartBtn setBackgroundColor:RedColor];
        _addCartBtn.titleLabel.font = kFont_14;
        [_addCartBtn addTarget:self action:@selector(addCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCartBtn;
}

- (UIButton *)buyGoodsBtn {
    
    if (!_buyGoodsBtn){
        _buyGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyGoodsBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyGoodsBtn setBackgroundColor:MainColor];
        _buyGoodsBtn.titleLabel.font = kFont_14;
        [_buyGoodsBtn addTarget:self action:@selector(buyNowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyGoodsBtn;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
