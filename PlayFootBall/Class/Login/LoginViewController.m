//
//  LoginViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginHandle.h"
#import "UserInfoModel.h"
@interface LoginViewController ()<WXApiDelegate>
@property (nonatomic, strong) NSDictionary    *  dictionary;
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
       
}
- (void)viewDidLoad {
    [super viewDidLoad];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXLoginNoti:) name:WXLoginNotification object:nil];
      self.naviView.hidden=YES;
        UIImageView *  bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
         if (IS_X) {
             bgImg.image=[UIImage imageNamed:@"login_bg_x"];
         }else{
             bgImg.image=[UIImage imageNamed:@"login_bg"];
             
         }
         bgImg.clipsToBounds=YES;
         bgImg.contentMode=UIViewContentModeScaleToFill;
         bgImg.userInteractionEnabled=YES;
         [self.view addSubview:bgImg];
         
         [LoginHandle getVersionWithSuccess:^(id  _Nonnull obj) {
             NSDictionary * dic=(NSDictionary *)obj;
             if ([dic[@"code"] intValue]==1) {
                 if ([dic[@"data"][@"version"] isEqualToString:[NSString getVersion]]) {
                        UIButton  *    customerBtn=[[UIButton alloc]initWithFrame:CGRectMake(67.5*KScaleW,526*KScaleH, SCREEN_WIDTH-135*KScaleW, 45*KScaleH)];
                        customerBtn.backgroundColor=[UIColor colorWithHexString:@"#CDD3D9"];
                        customerBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14*KScaleW];
                        [customerBtn setTitle:@"游客登录" forState:UIControlStateNormal];
                        [customerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [customerBtn setRadius:5*KScaleH];
                        [customerBtn addTarget:self action:@selector(customerLogin) forControlEvents:UIControlEventTouchUpInside];
                        [bgImg addSubview:customerBtn];
                 }else{
                     UIButton  *    wxBtn=[[UIButton alloc]initWithFrame:CGRectMake(67.5*KScaleW, 526*KScaleH, SCREEN_WIDTH-135*KScaleW, 45*KScaleH)];
                                      [wxBtn setBackgroundImage:[UIImage imageNamed:@"login_wx"] forState:UIControlStateNormal];
                                         wxBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14*KScaleW];
                                         [wxBtn setTitle:@"微信登录" forState:UIControlStateNormal];
                                         [wxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                         [wxBtn addTarget:self action:@selector(wxLogin) forControlEvents:UIControlEventTouchUpInside];
                                         [bgImg addSubview:wxBtn];
                   
                 }
             }
         } failed:^(id  _Nonnull obj) {
             
         }];
        
         
         
         UIButton * close=[[UIButton alloc]initWithFrame:CGRectMake(22*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, 14*KScaleW, 14*KScaleW)];
          [close setBackgroundImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
           [close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
          [bgImg addSubview:close];
}

-(void)wxLogin{
   
    SendAuthReq * req=[[SendAuthReq alloc]init];
    req.scope=@"snsapi_userinfo";
    req.state=@"ClassSchedule";
      [WXApi sendAuthReq:req
          viewController:self
                delegate:self
              completion:nil];
   
}
-(void)WXLoginNoti:(NSNotification *)wxLogin{
 
  __weak typeof(self)weakSelf = self;
    NSDictionary * code=[wxLogin userInfo];
    NSString * str=[code objectForKey:@"code"];
    [LoginHandle loginWithCode:str bundle_name:[NSString getBundleIdentifier] version:[NSString getVersion] sys:@"1" channel:@"appstore" identification:@"0" type:@"phone" uuid:[NSString getDeviceUUID] success:^(id  _Nonnull obj) {
              NSDictionary * dic=(NSDictionary *)obj;
              if ([dic[@"code"] intValue]==1) {
                  self.dictionary=dic;
                  [self saveModel];
                  weakSelf.loginSuccessBlock();
               
              }
          } failed:^(id  _Nonnull obj) {
                  
              [self.view toast:@"登录失败"];
          }];
}
-(void)customerLogin{
     __weak typeof(self)weakSelf = self;
    [LoginHandle loginWithCode:[self getRandomStr] bundle_name:[NSString getBundleIdentifier] version:[NSString getVersion] sys:@"1" channel:@"appstore" identification:@"1" type:@"phone" uuid:[NSString getDeviceUUID] success:^(id  _Nonnull obj) {
           NSDictionary * dic=(NSDictionary *)obj;
           if ([dic[@"code"] intValue]==1) {
               self.dictionary=dic;
               [self saveModel];
               weakSelf.loginSuccessBlock();
                
           }
           NSLog(@"obj==%@",obj);
       } failed:^(id  _Nonnull obj) {
               
           [self.view toast:@"登录失败"];
       }];
}
-(void)saveModel{
    UserInfoModel  *  model=[UserInfoModel mj_objectWithKeyValues:self.dictionary[@"data"]];
                [UserInfoDefaults  saveUserInfo:model];
    
     
}
-(void)close{
     [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSString *)getRandomStr
{
    char data[10];
    
    for (int x=0;x < 10;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    NSString *randomStr = [[NSString alloc] initWithBytes:data length:10 encoding:NSUTF8StringEncoding];


    NSString *string = [NSString stringWithFormat:@"%@",randomStr];


    NSLog(@"获取随机字符串 %@",string);


    return string;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)dealloc{
    //用第二种创建方法错误的移除
    //移除名为tongzhi的那个通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
