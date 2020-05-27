//
//  ChoiceViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/16.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "ChoiceViewController.h"
#import "Choice_MainTableViewCell.h"
#import "Choice_DetailViewController.h"
#import "FootBallTeamDetailListModel.h"
#import "FootBallTeamListModel.h"
#import "MainHandle.h"
@interface ChoiceViewController ()<UITableViewDelegate,BaseTableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView     *      tableView;
@property (nonatomic, strong) NSMutableArray    *      teamList;

@end

@implementation ChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.hidden=YES;
    [self loadDataWithId:[self.ID intValue]];
    [self.tableView shouldAddHeaderRefresh:YES];
     __weak typeof(self) weakSelf = self;
    self.tableView.headerRefreshBlock = ^{
    [weakSelf loadDataWithId:[weakSelf.ID intValue]];
    };
}

-(void)loadDataWithId:(int)Id{
    [MainHandle getTeamDetailListTeamId:Id success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
        self.teamList=[FootBallTeamListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        [self.tableView reloadData];
        [self.tableView endRefreshing];
        }
        
        
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
           return 71.5*KScaleH;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.teamList.count;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Choice_DetailViewController   *  vc=[[Choice_DetailViewController alloc]init];
    FootBallTeamListModel * model=self.teamList[indexPath.row];
    vc.teamId=model.id;
    [self.navigationController pushViewController:vc animated:NO];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
 
           Choice_MainTableViewCell * cellOne = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (!cellOne) {
            cellOne= [[Choice_MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
                   }
            cellOne.selectionStyle=UITableViewCellSelectionStyleNone;
            cellOne.indexLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
          if (indexPath.row==0||indexPath.row==1||indexPath.row==2) {
           cellOne.indexLabel.textColor=[UIColor colorWithHexString:@"#21C648"];
           }else{
            cellOne.indexLabel.textColor=[UIColor colorWithHexString:@"#CDD3D9"];
            }
    cellOne.model=self.teamList[indexPath.row];
            return cellOne;
}

-(BaseTableView *)tableView{
    if (!_tableView) {
        CGFloat  tabbar=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
        BaseTableView * tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-tabbar) style:UITableViewStylePlain];
                  tableView.delegate = self;
                  tableView.dataSource = self;
                  tableView.separatorColor=[UIColor clearColor];
                  tableView.backgroundColor=[UIColor whiteColor];;
                  [self.view addSubview:tableView];
                  _tableView=tableView;
    }
    return _tableView;
}
-(NSMutableArray *)teamList{
    if (!_teamList) {
        _teamList=[NSMutableArray array];
    }
    return _teamList;
}
@end
