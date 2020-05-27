//
//  FirstMainViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "FirstMainViewController.h"
#import "Main_OneTableViewCell.h"
#import "Main_TwoTableViewCell.h"
#import "MainHeaderView.h"
#import "MatchListModel.h"
#import "MainHandle.h"
#import "FootBGHandle.h"
#import "FootBallBGModel.h"
#import "WebDetailViewController.h"
#import "Choice_DetailViewController.h"
#import "FootBgDetailViewController.h"
#define CYCLE_HEIGHT    150*KScaleW
@interface FirstMainViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView               *            tableView;
@property (nonatomic, strong) UILabel                     *            choiceLabelOne;
@property (nonatomic, strong) UIImageView                 *            choiceImgOne;
@property (nonatomic, strong) NSMutableArray              *            matchList;
@property (nonatomic, strong) NSMutableArray              *            bgList;
@end

@implementation FirstMainViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      [self.tableView shouldAddHeaderRefresh:YES];
      __weak typeof(self)weakSelf = self;
      self.tableView.headerRefreshBlock = ^{
          [[NSNotificationCenter defaultCenter] postNotificationName:RefreshNotification object:weakSelf userInfo:nil];
          [weakSelf getMatch];
      };
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushChoice:) name:ChoicePushNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushMatch:) name:MatchPushNotification object:nil];
    [self getMatch];
   
}
-(void)pushChoice:(NSNotification *)pushChoice{
      __weak typeof(self) weakSelf = self;
    [weakSelf.tabBarController setSelectedIndex:2];
}
-(void)pushMatch:(NSNotification *)pushMatch{
    __weak typeof(self) weakSelf = self;
      [weakSelf.tabBarController setSelectedIndex:1];
}
-(void)getMatch{
    [MainHandle getMainMatchWithSuccess:^(id  _Nonnull obj) {
      NSDictionary * dic=(NSDictionary *)obj;
                    if ([dic[@"code"] intValue]==1) {
                self.matchList=[MatchListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
                NSUserDefaults  *  defaults=[NSUserDefaults standardUserDefaults];
                if([[defaults valueForKey:@"cityId"] intValue]==0){
                [self loadDataWithID:1];
                }else{
                [self loadDataWithID:[[defaults valueForKey:@"cityId"] intValue]];
                           }
                    }
                    
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)loadDataWithID:(int)ID{
    [FootBGHandle getFootBGListWithcityId:ID success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if([dic[@"code"] intValue]==1){
            self.bgList=[FootBallBGModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self.tableView reloadData];
        }
        [self.tableView endRefreshing];
    } failed:^(id  _Nonnull obj) {
        
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2) {
        FootBgDetailViewController   *  vc=[[FootBgDetailViewController alloc]init];
        FootBallBGModel * model=self.bgList[indexPath.row];
        vc.bgId=model.id;
        [self.navigationController pushViewController:vc animated:NO];
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   if (indexPath.section==1) {
           return 117*KScaleH;
    }else  if (indexPath.section==2) {
        return 209.5*KScaleH;
    }else{
        return 0;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==1){
        if (self.matchList.count>3) {
            return 3;
        }else{
             return self.matchList.count;
        }
    }else if(section==2){
        if (self.bgList.count>10) {
            return 10;
        }else{
            return self.bgList.count;
        }
    }else{
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        MainHeaderView   *  header=[[MainHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 999*KScaleH)];
        header.rreturnValueBlock = ^(NSString * _Nonnull linkUrl) {
            WebDetailViewController   *  vc=[[WebDetailViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
            vc.linkUrl=linkUrl;
        };
        header.getDetailBlock = ^(NSString * _Nonnull ID) {
            Choice_DetailViewController  *  vc=[[Choice_DetailViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
            vc.teamId=ID;
        };
        return header;
    }
    if (section==2) {
        UIView  *   bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43.5*KScaleH)];
        bgView.backgroundColor=[UIColor whiteColor];
        bgView.userInteractionEnabled=YES;
        __weak typeof(self) weakSelf = self;
        UITapGestureRecognizer   *    main=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            
            [weakSelf.tabBarController setSelectedIndex:3];
            
          
        }];
        [bgView  addGestureRecognizer:main];
        _choiceLabelOne=[[UILabel alloc]initWithFrame:CGRectMake(13*KScaleW, 23.5*KScaleH,80*KScaleW, 15.5*KScaleH)];
        _choiceLabelOne.textAlignment=NSTextAlignmentCenter;
        _choiceLabelOne.text=@"玩球去";
        _choiceLabelOne.font=APP_BOLD_FONT(16.0);
        _choiceLabelOne.textColor=[UIColor colorWithHexString:@"#63717E"];
        _choiceImgOne=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_next_vc"]];
        _choiceImgOne.frame=CGRectMake(self.choiceLabelOne.right+16.5*KScaleW, 26.5*KScaleH, 11*KScaleH, 11*KScaleH);
        _choiceImgOne.clipsToBounds=YES;
        _choiceImgOne.contentMode=UIViewContentModeScaleAspectFill;
        [bgView addSubview:_choiceLabelOne];
        [bgView addSubview:_choiceImgOne];
        return bgView;
    }
        return nil;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 999*KScaleH;
    }else if(section==2){
        return 43.5*KScaleH;
    }else{
        return 0;
        
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell   *  cell;
    switch (indexPath.section) {
        case 1:{
           Main_OneTableViewCell * cellOne = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (!cellOne) {
                      cellOne= [[Main_OneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
                   }
            cellOne.selectionStyle=UITableViewCellSelectionStyleNone;
            cellOne.model=self.matchList[indexPath.row];
            return cellOne;
            
        }
            break;
        case 2:{
           Main_TwoTableViewCell * cellTwo = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            if (!cellTwo) {
                cellTwo= [[Main_TwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
                    }
                cellTwo.selectionStyle=UITableViewCellSelectionStyleNone;
            cellTwo.model=self.bgList[indexPath.row];
            return cellTwo;
            
        }
        break;
        default:{
            cell = [tableView dequeueReusableCellWithIdentifier:@""];
             if (!cell) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
                        }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
            
        }
            break;
    }
    
    
}
-(BaseTableView *)tableView{
    if (!_tableView) {
        CGFloat tabbar=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
        BaseTableView * tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, SCREEN_WIDTH, SCREEN_HEIGHT-tabbar) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorColor=[UIColor clearColor];
        tableView.backgroundColor=[UIColor whiteColor];;
        [self.view addSubview:tableView];
        _tableView=tableView;
    }
    return _tableView;
}
-(NSMutableArray *)matchList{
    if (!_matchList) {
        _matchList=[NSMutableArray array];
    }
    return _matchList;
}
-(NSMutableArray *)bgList{
    if (!_bgList) {
        _bgList=[NSMutableArray array];
    }
    return _bgList;
}
@end
