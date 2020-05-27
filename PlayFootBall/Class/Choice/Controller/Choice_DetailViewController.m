//
//  Choice_DetailViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/11.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "Choice_DetailViewController.h"
#import "Choice_DetailTableViewCell.h"
#import "MainHandle.h"
#import "TeamJudgeListModel.h"
#import "ChoiceHandle.h"
#import "YTTextViewAlertView.h"
#import "LoginViewController.h"
#import "ReportView.h"
@interface Choice_DetailViewController ()<UITableViewDelegate,BaseTableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView     *      tableView;
@property (nonatomic, strong) NSMutableArray    *      dataList;
@property (nonatomic, strong) NSDictionary      *      infoDic;
@property (nonatomic, assign) int                       page;
@property (nonatomic, strong) UIImageView       *       emptyImage;
@property (nonatomic, strong) UILabel           *       emptyLabel;
@property (nonatomic, strong) UIButton          *       emptyBtn;
@end

@implementation Choice_DetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView.mj_header beginRefreshing];
    self.page=1;
    [self getTeamInfo];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.naviView.naviTitleLabel.text=@"支持语录";
    UITapGestureRecognizer  *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
           [self.navigationController popViewControllerAnimated:YES];
       }];
       [self.naviView.naviTitleLabel addGestureRecognizer:tap];
//      self.page=1;
//      [self getTeamInfo];
      [self.tableView shouldAddHeaderRefresh:YES];
      [self.tableView shouldAddFooterRefresh:YES];
    NSLog(@"%@",self.teamId);
    __weak typeof(self)weakSelf = self;
//    [self.tableView.mj_header isRefreshing];
    self.tableView.headerRefreshBlock = ^{
        
        weakSelf.page = 1;
        [weakSelf getTeamInfo];
    };
    self.tableView.footerRefreshBlock = ^{
            
              weakSelf.page++;
              [weakSelf getTeamInfo];
          };
          [self setUpEmpty];
   
}

-(void)loadData{
    [MainHandle getJudgeListModelWithTeamId:[self.teamId intValue] page:self.page pageNum:20 success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"dic==%@",dic);
        if ([dic[@"code"] intValue]==1) {
            
            if (self.page==1) {
                self.dataList=[TeamJudgeListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            }else{
                 [self.dataList addObjectsFromArray:[TeamJudgeListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
            }
            if (self.dataList.count==0) {
                self.emptyImage.hidden=NO;
                self.emptyLabel.hidden=NO;
                self.emptyBtn.hidden=NO;
            }else{
                self.emptyImage.hidden=YES;
                self.emptyLabel.hidden=YES;
                self.emptyBtn.hidden=YES;
            }
           [self.tableView reloadData];
             [self.tableView endRefreshing];
        }
         
         
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)getTeamInfo{
    [MainHandle getTeamInfoWithTeamId:[self.teamId intValue] Success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
            [self loadData];
            self.infoDic=dic;
        }
        
    } failed:^(id  _Nonnull obj) {
        
    }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView  *  headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 194*KScaleH)];
    headerView.backgroundColor=[UIColor whiteColor];
    
    UIImageView   *   logo=[[UIImageView  alloc] initWithFrame:CGRectMake(35*KScaleW, 35.5*KScaleH, 75*KScaleW, 75*KScaleW)];
    [logo sd_setImageWithURL:[NSURL URLWithString:self.infoDic[@"data"][@"team_logo"]] placeholderImage:[UIImage imageNamed:@""]];
    logo.clipsToBounds=YES;
    logo.contentMode=UIViewContentModeScaleAspectFit;
    [headerView addSubview:logo];
    
    UILabel *  teamLabel=[[UILabel alloc]initWithFrame:CGRectMake(logo.right+35*KScaleW, 33*KScaleH, SCREEN_WIDTH-logo.right-35*KScaleW, 15.5*KScaleH)];
    teamLabel.textAlignment=NSTextAlignmentLeft;
    teamLabel.font=APP_BOLD_FONT(16.0);
    teamLabel.textColor=[UIColor colorWithHexString:@"#0B2137"];
    teamLabel.text=self.infoDic[@"data"][@"name"];
    [headerView addSubview:teamLabel];
    
    UILabel *  timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(logo.right+35*KScaleW, teamLabel.bottom+30.5*KScaleH, 120*KScaleW, 11.5*KScaleH)];
      timeLabel.textAlignment=NSTextAlignmentLeft;
      timeLabel.font=APP_NORMAL_FONT(12.0);
      timeLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
      timeLabel.text=[NSString stringWithFormat:@"成立：%@", self.infoDic[@"data"][@"establish_time"]];
      [headerView addSubview:timeLabel];
    
    UILabel *  cityLabel=[[UILabel alloc]initWithFrame:CGRectMake(timeLabel.right, teamLabel.bottom+30.5*KScaleH, 100*KScaleH, 11.5*KScaleH)];
        cityLabel.textAlignment=NSTextAlignmentLeft;
        cityLabel.font=APP_NORMAL_FONT(12.0);
        cityLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
        cityLabel.text=[NSString stringWithFormat:@"城市：%@", self.infoDic[@"data"][@"city_name"]];
        [headerView addSubview:cityLabel];
    
    UILabel *  bgGroundLabel=[[UILabel alloc]initWithFrame:CGRectMake(logo.right+35*KScaleW, timeLabel.bottom+10.5*KScaleH, SCREEN_WIDTH-logo.right-35*KScaleW, 11.5*KScaleH)];
           bgGroundLabel.textAlignment=NSTextAlignmentLeft;
           bgGroundLabel.font=APP_NORMAL_FONT(12.0);
           bgGroundLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
           bgGroundLabel.text=[NSString stringWithFormat:@"主场：%@", self.infoDic[@"data"][@"league_name"]];
           [headerView addSubview:bgGroundLabel];
    
    
    
    UIButton  *  likeBtn=[[UIButton alloc]initWithFrame:CGRectMake(13*KScaleW, bgGroundLabel.bottom+33.5*KScaleH, SCREEN_WIDTH-26*KScaleW, 37*KScaleH)];
    [likeBtn setRadius:5*KScaleW];
    [likeBtn setBackgroundColor:[UIColor colorWithHexString:@"#EA363F"]];
    [likeBtn setImage:[UIImage imageNamed:@"choice_praise"] forState:UIControlStateNormal];
    likeBtn.titleLabel.font=APP_BOLD_FONT(12.0);
    [likeBtn setTitle:[NSString stringWithFormat:@"喜欢（%@）",self.infoDic[@"data"][@"total_amount"]] forState:UIControlStateNormal];
    [headerView addSubview:likeBtn];
    [likeBtn addTarget:self action:@selector(praise) forControlEvents:UIControlEventTouchUpInside];
    likeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10*KScaleW, 0, 0);
    likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0,10*KScaleW, 0, 0);
    
    return headerView;
   
}
-(void)praise{
    if ([UserInfoDefaults isLogin]) {
    [self prasePost];
           YTTextViewAlertView *alertView = [YTTextViewAlertView new];
            [alertView show];
            alertView.max_textCont_label.text=@"100/100";
            alertView.repulse_content_textView.text=@"喜欢他就说出来...";
               alertView.ytAlertViewMakeSureBlock = ^(NSString *repulse_evaluate_str) {
                   if ([repulse_evaluate_str isEqualToString:@"喜欢他就说出来..."]||[repulse_evaluate_str isEmpty]) {
                       [self.view toast:@"请输入评论内容"];
                       return ;
                   }
                   [self loadData];
                   
                   [ChoiceHandle sendJudgeWithTeamId:[self.teamId intValue] content:repulse_evaluate_str success:^(id  _Nonnull obj) {
                       NSDictionary * dic=(NSDictionary *)obj;
                       if ([dic[@"code"] intValue]==1) {
                           [self.view toast:@"评论成功"];
                           [self loadData];
                       }else{
                       }
                   } failed:^(id  _Nonnull obj) {
                       
                   }];
                   
               };
               
               alertView.ytAlertViewCloseBlock = ^{
                   [self loadData];
               };
        
    }else{
        [self jumpLogin];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    return 194*KScaleH;
        
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Choice_DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[Choice_DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
     cell.model=self.dataList[indexPath.row];
    [cell.btn addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)showAlert{
    ReportView   *  alert=[[ReportView alloc]init];
    [alert showView];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
}



#pragma mark - lazy

- (BaseTableView *)tableView {

    if (!_tableView) {
        BaseTableView * tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.naviView.bottom) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 150*KScaleH;
        tableView.tableFooterView = [UIView new];
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=[UIColor clearColor];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray *)dataList {

    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


-(void)prasePost{
    
   
    [ChoiceHandle prasieWithTeamId:[self.teamId intValue] success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        
        NSLog(@"点赞返回%@",dic);
        if ([dic[@"code"] intValue]==1) {
        }else{
            [self.view toast:@"点赞失败"];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}

-(void)setUpEmpty{
    self.emptyImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choice_empty"]];
    self.emptyImage.frame=CGRectMake(150*KScaleW, 311.5*KScaleH, SCREEN_WIDTH-300*KScaleW, SCREEN_WIDTH-300*KScaleW);
    self.emptyImage.contentMode=UIViewContentModeScaleAspectFill;
    self.emptyImage.clipsToBounds=YES;
    self.emptyImage.hidden=YES;
    [self.view addSubview:self.emptyImage];
    
    self.emptyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.emptyImage.bottom+20.5*KScaleH, SCREEN_WIDTH, 13*KScaleH)];
    self.emptyLabel.textAlignment=NSTextAlignmentCenter;
    self.emptyLabel.font=APP_NORMAL_FONT(14.0);
    self.emptyLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
    self.emptyLabel.text=@"没有人踊跃发言";
     self.emptyLabel.hidden=YES;
    [self.view addSubview:self.emptyLabel];
    
    self.emptyBtn=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-67*KScaleW)/2, self.emptyLabel.bottom+47.5*KScaleH, 67*KScaleW, 23*KScaleH)];
    self.emptyBtn.layer.borderWidth=1*KScaleW;
    self.emptyBtn.layer.borderColor=[UIColor colorWithHexString:@"#EA363F"].CGColor;
    self.emptyBtn.backgroundColor=[UIColor whiteColor];
    [self.emptyBtn setTitle:@"我先来" forState:UIControlStateNormal];
    self.emptyBtn.titleLabel.font=APP_NORMAL_FONT(12.0);
      self.emptyBtn.hidden=YES;
    [self.emptyBtn setRadius:11.5*KScaleH];
    [self.emptyBtn setTitleColor:[UIColor colorWithHexString:@"#EA363F"] forState:UIControlStateNormal];
    [self.emptyBtn addTarget:self action:@selector(praise) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.emptyBtn];
    
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
