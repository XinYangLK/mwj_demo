//
//  KLStorePetDetailController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/19.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStorePetDetailController.h"
#import "KLStorePetDetailBannerVideoCell.h" //带视频的轮播
#import "KLStoreDetailViewController.h"     //店铺详情
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>


typedef enum : NSUInteger {
    TSBANNERTYPEIMAGE,
    TSBANNERTYPEVIDEO,
} TSBANNERTYPE;

//定义一个Block
typedef void (^RunloopBlock)(void);

@interface KLStorePetDetailController ()
<
UITableViewDelegate,
UITableViewDataSource,
TSVideoPlaybackDelegate,
ZFTableViewCellDelegate
>

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) NSMutableArray *urls;


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
//***  底部按钮 电话联系商家  **/
@property (nonatomic, strong) UIButton * phoneBtn;


@property (nonatomic, assign) TSBANNERTYPE type;

//***  装任务的数组  **/
@property (nonatomic, strong) NSMutableArray *tasks;
//***  最大任务的数  **/
@property (assign, nonatomic) NSUInteger macQueueLength;

@end

@implementation KLStorePetDetailController

//***  轮播图数据源  **/
-(NSArray *)bannerArray
{
    return @[
             //             @"http://img.ptocool.com/video/2018-06-30_RGq4iDnu.mov",
             //             @"http://tb-video.bdstatic.com/tieba-smallvideo-transcode/3612804_e50cb68f52adb3c4c3f6135c0edcc7b0_3.mp4",
             @"http://tb-video.bdstatic.com/tieba-smallvideo-transcode/20985849_722f981a5ce0fc6d2a5a4f40cb0327a5_3.mp4",
             @"http://img.ptocool.com/3332-1518523974126-29",
             @"http://img.ptocool.com/3332-1518523974125-28",
             @"http://img.ptocool.com/3332-1518523974125-27",
             @"http://img.ptocool.com/3332-1518523974124-26"];
}

//***  视频URL存放数组  **/
- (NSMutableArray *)urls {
    if (!_urls){
        _urls = [[NSMutableArray alloc]init];
    }
    return _urls;
}


//***  数据字典初始化  **/
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithObjects:@"全部商品",@"狗粮",@"驱虫",@"零食罐头",@"猫粮",@"磨牙洁齿",@"洗护消毒",@"全部商品",@"狗粮",@"驱虫",@"零食罐头",@"猫粮",@"磨牙洁齿",@"洗护消毒",@"全部商品",@"狗粮",@"驱虫",@"零食罐头",@"猫粮",@"磨牙洁齿",@"洗护消毒",@"全部商品",@"狗粮",@"驱虫",@"零食罐头",@"猫粮",@"磨牙洁齿",@"洗护消毒",@"全部商品",@"狗粮",@"驱虫",@"零食罐头",@"猫粮",@"磨牙洁齿",@"洗护消毒", nil];
    }
    return _dataArray;
}



- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"宠物详情"];
}

#pragma mark - 加载
- (void)viewDidLoad {
    [super viewDidLoad];
    //***  列表加载线程优化  **/
    [self addRunLoopObserver];
    [self threadOptimization];
    
    [self.view addSubview:self.tableView];
    [self phoneBtn];
    
    // 开启多线程 避免界面进入缓慢
    @weakify(self)
    [self addTask:^{
        @strongify(self)
        [self creatVidelPlayer];
    }];
    
}


//***  列表优化 避免滑动视频卡顿 **/
- (void)threadOptimization {
    //***  创建多任务数组  **/
    self.tasks = [NSMutableArray array];
    //***  最大任务量  **/
    self.macQueueLength = 3;
}


- (void)viewWillDisappear:(BOOL)animated {
    //***  暂停目前播放  **/
    [self.player stopCurrentPlayingCell];
    [super viewWillDisappear:animated];
}


#pragma mark - 创建播放器
- (void)creatVidelPlayer {
    
    /// playerManager
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// player的tag值必须在cell里设置
    self.player = [ZFPlayerController playerWithScrollView:self.tableView playerManager:playerManager containerViewTag:100];
    self.player.controlView = self.controlView;
   //***  加入视频源  **/
    NSString *URLString = [[self bannerArray][0] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:URLString];
    [self.urls addObject:url];
    self.player.assetURLs = self.urls;
    
    /// 移动网络依然自动播放
    self.player.WWANAutoPlay = YES;
    /// 1.0是完全消失的时候
    self.player.playerDisapperaPercent = 1.0;
    /// 0.0是刚开始显示的时候
    self.player.playerApperaPercent = 0.0;
    
    @weakify(self)
    /// 找到可播放的cell
    [self.tableView zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
        @strongify(self)
        [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
    }];
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
        [UIViewController attemptRotationToDeviceOrientation];
        self.tableView.scrollsToTop = !isFullScreen;
    };
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.controlView resetControlView];
        [self.player stopCurrentPlayingCell];
    };
    [self.tableView reloadData];

    /// 以下设置滑出屏幕后不停止播放
    self.player.stopWhileNotVisible = NO;
    CGFloat margin = 20;
    CGFloat w = MainWidth/2;
    CGFloat h = w * 9/16;
    CGFloat x = MainWidth - w - margin;
    CGFloat y = AdaptedHeight(102);
    self.player.smallFloatView.frame = CGRectMake(x, y, w, h);
}


#pragma mark -   lazy  UI
- (UIButton *)phoneBtn {
    
    if (!_phoneBtn){
        _phoneBtn = [UIButton createBtnTitle:@"联系商家"
                                  titleColor:RGBSigle(255)
                                        font:kFont_14
                                   imageName:@"dianhuahua-1"
                              backgrounColor:MainColor
                         SSImagePositionType:SSImagePositionTypeLeft
                                     spacing:14
                                      action:^(UIButton * _Nonnull button) {
                                          KLLog(@"联系商家");
                                      }];
        [self.view addSubview:_phoneBtn];
        [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset = 0;
            make.bottom.offset     = (kDevice_Is_iPhoneX) ? -34 : 0;
            make.height.offset     = AdaptedHeight(49);
        }];
    }
    return _phoneBtn;
    
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight - AdaptedHeight(49) - TabbarSafeBottomMargin;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLStorePetDetailBannerVideoCell class]);
        _tableView.mCustomClass([KLPetNamePriceCell class]);
        _tableView.mCustomClass([KLPetDetailMsgCell class]);
        _tableView.mCustomClass([KLPetStoreCell class]);
        _tableView.mCustomClass([UITableViewCell class]);
        _tableView.mCustomClass([KLPetLikeListCell class]);

        /// 停止的时候找出最合适的播放
        @weakify(self)
        _tableView.zf_scrollViewDidStopScrollCallback = ^(NSIndexPath * _Nonnull indexPath) {
            @strongify(self)
            [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
        };
    }
    return _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (section == 0) {
       
        return 1;
        
    }else if(section ==1){
       
        return 6;
        
    }else if (section ==2){
        
        return 1;
        
    }else{
        
        return 10 + 1;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        
        KLStorePetDetailBannerVideoCell *cell = kCellIdentifier(KLStorePetDetailBannerVideoCell);
        cell.video.delegate = self;
        [cell setDelegate:self withIndexPath:indexPath];
        
        @weakify(self)
        [self addTask:^{
            @strongify(self)
            [cell.video setWithIsVideo:TSDETAILTYPEVIDEO andDataArray:[self bannerArray]];
        }];
        
        cell.plaerCellPauseBlock = ^(BOOL plaerStatus) {
            @strongify(self)
            if (plaerStatus) {
                //***  轮播滑出暂停目前播放  **/
                [self.player stopCurrentPlayingCell];
            }else {
                /// 如果没有播放，则点击进详情页会自动播放
                if (!self.player.currentPlayerManager.isPlaying) {
                    [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
                }
            }
        };
        
        return cell;
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            KLPetNamePriceCell *cell = kCellIdentifier(KLPetNamePriceCell);
            cell.titleLab.text =@"博美犬（公）";
            cell.priceLab.text =@"￥3800/只";
            
            return cell;
            
        }else{
            
            KLPetDetailMsgCell * cell = kCellIdentifier(KLPetDetailMsgCell);
            cell.titleLab.text =@[@"年龄：",@"品级：",@"疫苗：",@"驱虫：",@"描述："][indexPath.row-1];
            return cell;
            
        }
        
    }else if(indexPath.section == 2){
        
        KLPetStoreCell *cell = kCellIdentifier(KLPetStoreCell);
        cell.storeImg.image =[UIImage imageNamed:@"banner_2"];
        cell.titleLab.text =@"派多格宠物店";
        cell.distanceLab.text =@"虹口区江湾镇街道-凉城路1335号";
        
        @weakify(self)
        cell.pushStoreBlock = ^(UIButton * _Nonnull sender) {
            @strongify(self)
            KLStoreDetailViewController *vc =[[KLStoreDetailViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
        
    }else{
        
        if (indexPath.row == 0) {
            UITableViewCell *cell = kCellIdentifier(UITableViewCell);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text =@"猜你喜欢";
            cell.textLabel.font =AdaptedSYSFontSize(14);
            cell.textLabel.textColor = RGBSigle(51);
            return cell;
        }
        
        KLPetLikeListCell *cell = kCellIdentifier(KLPetLikeListCell);
        cell.goodsImg   = @"bannnnnrtyyh";
        cell.goodsName  = self.dataArray[indexPath.row -1];
        cell.goodsDes   = @"2针疫苗，已驱虫";
        cell.goodsPrice = @"19800/只";
        return cell;
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
         return AdaptedHeight(282);
        
        
    }else if (indexPath.section == 1){
        
        return AdaptedHeight(45);

    }else if (indexPath.section == 2){
        
        return AdaptedHeight(85);
        
    }else{
        
        if (indexPath.row == 0) {
            
            return AdaptedHeight(42);
        }
     
        return AdaptedHeight(125);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        /// 如果正在播放的index和当前点击的index不同，则停止当前播放的index
        if (self.player.playingIndexPath != indexPath) {
            [self.player stopCurrentPlayingCell];
        }
        /// 如果没有播放，则点击进详情页会自动播放
        if (!self.player.currentPlayerManager.isPlaying) {
            [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
        }
    }else if (indexPath.section == 3){
        
        if (indexPath.row > 0) {
            
            KLStorePetDetailController *vc =[[KLStorePetDetailController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
   
}


// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section ==1) {
        //分割线两端封头
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
            [cell setSeparatorInset:UIEdgeInsetsMake(0,MainWidth, 0, 0)];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsMake(0, MainWidth, 0, 0)];
    }
//    else{
//        //分割线两端封头
//        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
//            [cell setSeparatorInset:UIEdgeInsetsZero];
//        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
//            [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 1) {
        
        return AdaptedHeight(5);
    }
    return CGFLOAT_MIN;
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





#pragma mark - 视频播放相关处理

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
    }
    return _controlView;
}

//***  播放当前cell中的视频  **/
- (void)zf_playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
}

/// play the video
- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop {
    [self.player playTheIndexPath:indexPath scrollToTop:scrollToTop];
    [self.controlView showTitle:nil
                 coverURLString:@"http://img.ptocool.com/3332-1518523974126-29"
                 fullScreenMode:ZFFullScreenModePortrait];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    CGFloat h = MainHeight - StatusBarAndNavigationBarHeight - AdaptedHeight(49) - TabbarSafeBottomMargin;
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, h);
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    if (!parent) {
        self.tableView.delegate = nil;
        [self.player stopCurrentPlayingCell];
    }
}
- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

#pragma mark - UIScrollViewDelegate 列表播放必须实现
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScrollToTop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewWillBeginDragging];
}




#pragma mark - 轮播图点击处理  TSVideoPlaybackDelegate
-(void)videoView:(TSVideoPlayback *)view didSelectItemAtIndexPath:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
}



#pragma mark - <关于RunLoop的代码>

- (void)addTask:(RunloopBlock)task {
    [self.tasks addObject:task];
    if (self.tasks.count > self.macQueueLength) {
        //干掉最开始的任务
        [self.tasks removeObjectAtIndex:0];
    }
}

static void Callback(CFRunLoopObserverRef observer,CFRunLoopActivity activity,void*info){
    
    //取出任务执行
    KLStorePetDetailController *vc = (__bridge KLStorePetDetailController *)info;
    if (vc.tasks.count == 0) {
        return;
    }
    RunloopBlock task = vc.tasks.firstObject;
    task();
    [vc.tasks removeObjectAtIndex:0];
}
//添加Runloop
- (void)addRunLoopObserver{
    //    CFRunLoopGetMain()     拿到主线程的RunLoop
    //    CFRunLoopGetCurrent()  拿到当前的RunLoop
    /**
     * 拿到当前的RunLoop
     * RunLoopRef Ref结尾的代表指针
     */
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义一个上下文
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL,
    };
    //定义一个观察者
    static CFRunLoopObserverRef defaulModeObserver;
    //创建一个观察者
    defaulModeObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopAfterWaiting, YES, 0, &Callback, &context);
    //添加RunLoop到观察者！
    CFRunLoopAddObserver(runloop, defaulModeObserver, kCFRunLoopCommonModes);
    //C语言有Creat , 就需要elease
    CFRelease(defaulModeObserver);
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
