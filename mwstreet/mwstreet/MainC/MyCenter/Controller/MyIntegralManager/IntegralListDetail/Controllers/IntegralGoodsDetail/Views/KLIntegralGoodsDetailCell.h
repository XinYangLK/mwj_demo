//
//  KLIntegralGoodsDetailCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ExchangeBtnChick)(UIButton * sender);

@interface KLIntegralGoodsDetailCell : UITableViewCell

//***  商品名称  **/
@property (nonatomic, strong) UILabel * titleLab;
//***  需要萌豆数量  **/
@property (nonatomic, strong) UILabel * numLab;
//***  兑换按钮  **/
@property (nonatomic, strong) UIButton * exchangeBtn;
//***  兑换回调  **/
@property (nonatomic,copy) ExchangeBtnChick exchangeBtnChick;
@end







@interface KLIntegralGoodsWebCell : UITableViewCell

//***  商品详情web  **/
@property (nonatomic, strong) WKWebView *webView;


@end



NS_ASSUME_NONNULL_END
