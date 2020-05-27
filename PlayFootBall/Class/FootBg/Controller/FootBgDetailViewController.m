//
//  FootBgDetailViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "FootBgDetailViewController.h"
#import "FootBGHandle.h"
#import "FootBallBgAlertView.h"
#import "FootBallBgAlertView.h"
#import "OrderSuccessAlertView.h"
#import "FootBGHandle.h"
#import "LoginViewController.h"
@interface FootBgDetailViewController ()<SDCycleScrollViewDelegate,AlerViewDelegate>
@property (nonatomic, strong) SDCycleScrollView           *            cycleScrollView;
@property (nonatomic, strong) NSDictionary                *            infoDic;
@property (nonatomic, strong) NSMutableArray              *            bannerList;
@end

@implementation FootBgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"球场玩球";
    UITapGestureRecognizer  *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
           [self.navigationController popViewControllerAnimated:YES];
       }];
       [self.naviView.naviTitleLabel addGestureRecognizer:tap];
    [self loadData];
}
-(void)loadData{
    [FootBGHandle getFootBgDetailWithBgId:[self.bgId intValue] success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
            self.bannerList=dic[@"data"][@"img_big_list"];
            self.infoDic=dic;
            [self setUpUI];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)setUpUI{
     [self cycleView];
    
    
    UILabel  *  titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(13*KScaleW, _cycleScrollView.bottom+22*KScaleH, SCREEN_WIDTH-13*KScaleW, 15.5*KScaleH)];
    titleLabel.font=APP_BOLD_FONT(16.0);
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.text=self.infoDic[@"data"][@"name"];
    titleLabel.textColor=[UIColor colorWithHexString:@"#0B2137"];
    [self.view addSubview:titleLabel];
    
    UIImageView   *   infoImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_info"]];
    infoImg.contentMode=UIViewContentModeScaleAspectFit;
    infoImg.clipsToBounds=YES;
    infoImg.frame=CGRectMake(13*KScaleW, titleLabel.bottom+22.5*KScaleH, 13*KScaleW, 13*KScaleW);
    [self.view addSubview:infoImg];
    
    UILabel       *   infoLabel=[[UILabel alloc]initWithFrame:CGRectMake(infoImg.right+10*KScaleW, titleLabel.bottom+21.5*KScaleH, SCREEN_WIDTH-infoImg.right-10*KScaleW, 13.5*KScaleH)];
    infoLabel.font=APP_BOLD_FONT(14.0);
    infoLabel.text=@"场地信息";
    infoLabel.textAlignment=NSTextAlignmentLeft;
    infoLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
    [self.view addSubview:infoLabel];
    
    UILabel   *    timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(13*KScaleW, infoLabel.bottom+26*KScaleH, SCREEN_WIDTH-13*KScaleW, 11.5*KScaleH)];
    timeLabel.font=APP_NORMAL_FONT(12.0);
    timeLabel.textAlignment=NSTextAlignmentLeft;
    timeLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
    timeLabel.text=[NSString stringWithFormat:@"开放时间：  %@",self.infoDic[@"data"][@"open_time"]];
    [self.view addSubview:timeLabel];
    
    UILabel   *    adressLabel=[[UILabel alloc]initWithFrame:CGRectMake(13*KScaleW, timeLabel.bottom+15.5*KScaleH, SCREEN_WIDTH-13*KScaleW, 11.5*KScaleH)];
    adressLabel.font=APP_NORMAL_FONT(12.0);
    adressLabel.textAlignment=NSTextAlignmentLeft;
    adressLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
    adressLabel.text=[NSString stringWithFormat:@"详细地址：  %@",self.infoDic[@"data"][@"address"]];
    [self.view addSubview:adressLabel];
    
    UILabel   *    moneyLabel=[[UILabel alloc]initWithFrame:CGRectMake(13*KScaleW, adressLabel.bottom+15.5*KScaleH, SCREEN_WIDTH-13*KScaleW, 11.5*KScaleH)];
    moneyLabel.font=APP_NORMAL_FONT(12.0);
    moneyLabel.textAlignment=NSTextAlignmentLeft;
    moneyLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
    moneyLabel.text=[NSString stringWithFormat:@"场地费用：  %@",self.infoDic[@"data"][@"cost"]];
    [self.view addSubview:moneyLabel];
    
    UIView  *  lineView=[[UIView alloc]initWithFrame:CGRectMake(13*KScaleW, moneyLabel.bottom+22*KScaleH, SCREEN_WIDTH-26*KScaleW, 0.5*KScaleH)];
    lineView.backgroundColor=[UIColor colorWithHexString:@"#EFEFF0"];
    [self.view addSubview:lineView];
    
    
    UIImageView   *   contactImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_phone_nor"]];
    contactImg.contentMode=UIViewContentModeScaleAspectFit;
    contactImg.clipsToBounds=YES;
    contactImg.frame=CGRectMake(13*KScaleW, lineView.bottom+22.5*KScaleH, 13*KScaleW, 13*KScaleW);
    [self.view addSubview:contactImg];
       
       UILabel       *   contactLabel=[[UILabel alloc]initWithFrame:CGRectMake(infoImg.right+10*KScaleW, lineView.bottom+21.5*KScaleH, SCREEN_WIDTH-infoImg.right-10*KScaleW, 13.5*KScaleH)];
       contactLabel.font=APP_BOLD_FONT(14.0);
       contactLabel.text=@"联系方式";
       contactLabel.textAlignment=NSTextAlignmentLeft;
       contactLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
       [self.view addSubview:contactLabel];
    
    
    UILabel   *    phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(13*KScaleW, contactLabel.bottom+26*KScaleH, SCREEN_WIDTH-13*KScaleW, 11.5*KScaleH)];
      phoneLabel.font=APP_NORMAL_FONT(12.0);
      phoneLabel.textAlignment=NSTextAlignmentLeft;
    phoneLabel.userInteractionEnabled=YES;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"联系方式：  %@",self.infoDic[@"data"][@"contact_type"]]];
    NSRange range1 = [[str string] rangeOfString:@"联系方式：  "];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#63717E"] range:range1];
    NSRange range2 = [[str string] rangeOfString:self.infoDic[@"data"][@"contact_type"]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#21C648"] range:range2];
      phoneLabel.attributedText=str;
      [self.view addSubview:phoneLabel];
    
    
    UITapGestureRecognizer   *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.infoDic[@"data"][@"contact_type"]]]];
       
    }];
    [phoneLabel addGestureRecognizer:tap];
    
    
      
      UILabel   *    nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(13*KScaleW, phoneLabel.bottom+15.5*KScaleH, SCREEN_WIDTH-13*KScaleW, 11.5*KScaleH)];
      nameLabel.font=APP_NORMAL_FONT(12.0);
      nameLabel.textAlignment=NSTextAlignmentLeft;
      nameLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
      nameLabel.text=[NSString stringWithFormat:@"联系人：     %@",self.infoDic[@"data"][@"contact_person"]];
      [self.view addSubview:nameLabel];
    
    UIButton  *  orderBtn=[[UIButton alloc]initWithFrame:CGRectMake(13*KScaleW, SCREEN_HEIGHT-59*KScaleH, SCREEN_WIDTH-26*KScaleW, 37*KScaleH)];
    [self.view addSubview:orderBtn];
    [orderBtn setTitle:@"场地预约" forState:UIControlStateNormal];
    [orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    orderBtn.titleLabel.font=APP_BOLD_FONT(14.0);
    [orderBtn setBackgroundImage:[UIImage imageNamed:@"bg_order_btn"] forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(orderClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)cycleView{
    
    _cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(13*KScaleW, self.naviView.bottom+9*KScaleH, SCREEN_WIDTH-26*KScaleW, 171.3*KScaleH) delegate:self placeholderImage:[UIImage imageNamed:@"2.jpg"]];
    _cycleScrollView.currentPageDotColor=APP_NAVI_COLOR;
    _cycleScrollView.imageURLStringsGroup=self.bannerList;
    _cycleScrollView.autoScrollTimeInterval = 3.0;
    _cycleScrollView.contentMode = UIViewContentModeScaleToFill;
    _cycleScrollView.clipsToBounds = YES;
    [self.view addSubview:_cycleScrollView];
}
-(void)orderClick{
    if ([UserInfoDefaults isLogin]) {
        FootBallBgAlertView  *   alert=[[FootBallBgAlertView alloc]init];
           alert.rreturnValueBlock = ^(NSString * _Nonnull date, NSString * _Nonnull time, NSString * _Nonnull phone) {
                  [FootBGHandle orderWithTimeId:[time intValue] bgId:[self.bgId intValue] date:date phone:phone success:^(id  _Nonnull obj) {
                       NSDictionary * dic=(NSDictionary *)obj;
                if ([dic[@"code"] intValue]==1) {
                   [alert showViewWithImage:[UIImage imageNamed:@"bg_success"] textOne:@"预约成功!" textTwo:@"稍后工作人员会主动联系您"];
                       }else  if ([dic[@"code"] intValue]==1){
                    [alert showViewWithImage:[UIImage imageNamed:@"bg_have"] textOne:@"已预约该时段" textTwo:@"无需重复预约"];
                       }else{
//                            [self.view toast:dic[@"msg"]];
                            [self.view toast:@"预约失败"];
                       }
                   } failed:^(id  _Nonnull obj) {
               
                   }];
           };
           alert.delegate=self;
           [alert showView];
    }else{
        [self jumpLogin];
    }
    
   
}
-(void)jumpLogin{
    LoginViewController  *  vc=[[LoginViewController alloc]init];
       __weak __typeof(self)weakSelf = self;
//        BaseNavigationViewController *loginNav = [[BaseNavigationViewController alloc]initWithRootViewController:vc];
       vc.loginSuccessBlock = ^{
           [self dismissViewControllerAnimated:YES completion:^{
                   
                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       
                       [weakSelf loadData];
                        [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotification object:weakSelf userInfo:nil];
                   });
               }];
               
           };
      [self.navigationController presentViewController:vc animated:YES completion:nil];
}
@end
