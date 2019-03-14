//
//  KLPublishedEvaluationController.m
//  mwstreet
//
//  Created by 科pro on 2019/3/13.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPublishedEvaluationController.h"
#import "KLEditPhotoView.h"
#import "KLEvaluationDetailCell.h"
#import "KLPublishedEvaluationCell.h"

@interface KLPublishedEvaluationController ()<
UITableViewDelegate,
UITableViewDataSource,
KLEditPhotoViewDelegate,
StarRatingViewDelegate,
UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KLEditPhotoView * editPhotoView;
@property (nonatomic, strong) UIButton * submitBtn;

//***  描述相符  **/
@property (nonatomic, assign) float desScore;
//***  物流服务  **/
@property (nonatomic, assign) float logScore;
//***  服务态度  **/
@property (nonatomic, assign) float serScore;
//***  评价内容  **/
@property (nonatomic, strong) NSString * contentStr;

@end

@implementation KLPublishedEvaluationController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"评价"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.tableView];
    [self submitBtn];
}

//***  发布请求  **/
- (void)releaseEvaluationData {
    
    
    
    KLLog(@"------%lf \n------%lf \n------%lf \n------%@",self.desScore,self.logScore,self.serScore,self.contentStr);
    
}


#pragma mark -   lazy  UI
- (UIButton *)submitBtn {
    
    if (!_submitBtn){
        @weakify(self)
        _submitBtn = [UIButton createBtnTitle:@"发布"
                                   titleColor:RGBSigle(255)
                                         font:kFont_14
                                    imageName:@""
                               backgrounColor:MainColor
                                       action:^(UIButton * _Nonnull button) {
                                           @strongify(self)
                                           [self releaseEvaluationData];
                                       }];
        [self.view addSubview:_submitBtn];
        [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset = 0;
            make.bottom.offset     = -TabbarSafeBottomMargin;
            make.height.offset     = AdaptedHeight(49);
        }];
    }
    return _submitBtn;
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight -StatusBarAndNavigationBarHeight - AdaptedHeight(49);
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        KLEditPhotoView *editPhotoView = [KLEditPhotoView editPhotoView];
        editPhotoView.pageIndex = 9;
        editPhotoView.titleStr =@"上传照片(8张以内)";
        editPhotoView.frame = CGRectMake(0, 0, MainWidth, AdaptedHeight(300));
        editPhotoView.delegate = self;
        self.editPhotoView = editPhotoView;
        _tableView.tableFooterView = self.editPhotoView;
        _tableView.mCustomClass([KLEvaluationDetailGoodsCell class]);
        _tableView.mCustomClass([KLPublishedEvaluationCell class]);
    }
    return _tableView;
}

#pragma mark - 上传图片
- (void)editPhotoViewToOpenAblum:(KLEditPhotoView *)editView {
    
    //edit:照片需要裁剪:传YES,不需要裁剪传NO(默认NO)
    [self showCanEdit:YES photo:^(UIImage *photo) {
        
        [editView addOneImage:photo];
        
    }];
}
- (void)fetchPhotosNumber:(NSInteger)picCount editView:(KLEditPhotoView *)editView{
    NSLog(@"===%ld===\n==%@",picCount,[editView fetchPhotos]);
}
- (void)previewPhotosBtn:(UIButton *)sender img:(UIImage *)img editView:(KLEditPhotoView *)editView block:(PreviewBlock)photosBlock{
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:[editView fetchPhotos]];
    [self lookImageArray:array index:sender.tag-46];
}

#pragma mark - 加载图片浏览器
//*** 将图片数组加入图片浏览器  **/
- (void)lookImageArray:(NSMutableArray *)imageArray index:(NSInteger)index{
    NSMutableArray *items = @[].mutableCopy;
    
    for (int i = 0; i < imageArray.count; i++) {
        
        KSPhotoItem *item =[KSPhotoItem itemWithSourceView:nil image:imageArray[i]];
        [items addObject:item];
    }
    [self ks_photoBrowser:items index:index];
}
//*** 加载图片浏览器  **/
- (void)ks_photoBrowser:(NSMutableArray *)itemsArray index:(NSInteger)index{
    
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:itemsArray selectedIndex:index];
    browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleRotation;
    browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlur;
    browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
    browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleDot;
    browser.bounces = YES;
    [browser showFromViewController:self];
}

#pragma mark - 评分获取delegate方法
- (void)starRatingView:(SYStarRatingView *)view score:(float)score {

    switch (view.tag) {
        case 10:{
            self.desScore = score;
        }
            break;
        case 11:{
            self.logScore = score;
        }
            break;
        case 12:{
            self.serScore = score;
        }
            break;
            
        default:
            break;
    }
}
#pragma mark ------ 获取备注
- (void)textViewDidChange:(UITextView *)textView{
    
    self.contentStr = textView.text;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        KLEvaluationDetailGoodsCell * cell = kCellIdentifier(KLEvaluationDetailGoodsCell);
        cell.goodName = @"新款嘟贝贝 全拆洗狗床蓝色 S 70*58*38CM";
        cell.priceLab.text =@"￥138.00";
        return cell;
        
    }else {
       
        KLPublishedEvaluationCell *cell = kCellIdentifier(KLPublishedEvaluationCell);
        cell.desScoreView.starView.delegate = self;
        cell.logScoreView.starView.delegate = self;
        cell.serScoreView.starView.delegate = self;
        cell.remarksView.delegate = self;
        return cell;
        
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return AdaptedHeight(110);
        
    }else{
        
        return AdaptedHeight(264);
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? CGFLOAT_MIN : AdaptedHeight(5);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    if (!headerView) {
        headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
    }
    headerView.contentView.backgroundColor =SpacColor;
    return headerView;
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerCell"];
    if (!footerView) {
        footerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"footerCell"];
    }
    return footerView;
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
