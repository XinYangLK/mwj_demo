//
//  KLMyDistributionCenterVC.m
//  mwstreet
//
//  Created by 科pro on 2019/2/1.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyDistributionCenterVC.h"
#import "KLMultipleColumnsTVCell.h"
#import "KLMyDistritionHeaderCell.h"
#import "KLMyDistributionCenterCell.h"

#import "KLRichListManagerController.h" //财富排行榜
#import "KLMyDistritionCustomShareVC.h" //自定义分享语
#import "KLMyDistritionTeamVC.h"        //我的团队
#import "KLMyDistributionFounderVC.h"   //成为创始人
#import "KLMyDistritionQrCodeVC.h"      //二维码
#import "KLMyDistributionJuePromotionVC.h" //爵位晋升
#import "KLMyDistributionProAssistantVC.h" //推广小助手


@interface KLMyDistributionCenterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KLMyDistributionCenterVC

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"分销中心"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}


#pragma mark - 点击的cell 区、行及相对应   items的index
- (void)didSelectItems:(NSIndexPath *)indexPath  itemIndex:(NSInteger)itemIndex {
    
    KLLog(@"----###(%ld,%ld)--##---%ld----###--",indexPath.section,indexPath.row,itemIndex);
    switch (itemIndex) {
        case 0:{//二维码
            KLMyDistritionQrCodeVC *vc =[[KLMyDistritionQrCodeVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{//我的团队
            KLMyDistritionTeamVC *vc =[[KLMyDistritionTeamVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{//财务明细
//            KLMyDistributionFinDetailsVC *vc =[[KLMyDistributionFinDetailsVC alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{//爵位晋升
            KLMyDistributionJuePromotionVC *vc =[[KLMyDistributionJuePromotionVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:{//爵位明细
//            KLMyDistributionJueDetailVC *vc =[[KLMyDistributionJueDetailVC alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:{//成为创始人
            KLMyDistributionFounderVC *vc =[[KLMyDistributionFounderVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:{//财富排行榜
            KLRichListManagerController *vc =[[KLRichListManagerController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:{//自定义分享
            KLMyDistritionCustomShareVC *vc =[[KLMyDistritionCustomShareVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 8:{//推广小助手
            KLMyDistributionProAssistantVC *vc =[[KLMyDistributionProAssistantVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
            
        default:
            break;
    }
    
    
}




#pragma mark - lazy UI

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.separatorStyle  = UITableViewCellSelectionStyleNone;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLMyDistritionHeaderCell class]);
        _tableView.mCustomClass([KLMyDistributionCenterCell class]);

    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 0) {
        
        KLMyDistritionHeaderCell * cell = kCellIdentifier(KLMyDistritionHeaderCell);
        cell.accoutImg   = @"touxiang";
        cell.name        = @"发吧是东方巨iodine";
        cell.salesAmount = @"90.78";
        cell.commission  = @"189.00";
        cell.withAmount  = @"988.90";
        return cell;
        
    }else {
        
       
        KLMyDistributionCenterCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KLMyDistributionCenterCell class])];
        
        cell.imgArray = @[@"erweima",@"wodetuandui",@"caiwumingxi",@"jueweijinsheng",@"jueweimingxi",@"tuijianchuangshiren",@"caifupaihangbang",@"zidingyifenxiang",@"yuiguangxiaozhushou"];
        
        cell.dataArray = @[@"二维码",@"我的团队",@"财务明细",@"爵位晋升",@"爵位明细",@"成为创始人",@"财富排行榜",@"自定义分享",@"推广小助手"];
        
        klWeakSelf;
        cell.tvCellView.ReturnClickItemIndex = ^(NSIndexPath * itemtIP ,NSInteger itemIndex){
            [weakSelf didSelectItems:itemtIP itemIndex:itemIndex];
        };
        
        return cell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 0) {
        
        return AdaptedHeight(215);
        
    }else {
        
        CGFloat cellHt = 0.0;
        NSArray * array = @[@"二维码",@"我的团队",@"财务明细",@"爵位晋升",@"爵位明细",@"成为创始人",@"财富排行榜",@"自定义分享",@"推广小助手"];
        
        if (array.count != 0) {
            KLMultipleColumnsTVCell * cellView = [[KLMultipleColumnsTVCell alloc] init];
            cellView.dataArrayCount = array.count;
            cellHt += cellView.cellHeight;
        }
        return cellHt;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
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
