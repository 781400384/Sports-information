//
//  MatchMainViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "MatchMainViewController.h"
#import "Main_OneTableViewCell.h"
#import "MatchListModel.h"
#import "MatchHandle.h"
@interface MatchMainViewController ()<UITableViewDelegate,BaseTableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView     *      tableView;
@property (nonatomic, strong) NSMutableArray    *      dataList;
@property (nonatomic, assign) int                       page;
@end

@implementation MatchMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.leftItemButton.hidden=YES;
    self.naviView.naviTitleLabel.text=@"热门赛事";
    
     CGFloat y = IS_X ? NAVI_SUBVIEW_Y_iphoneX : NAVI_SUBVIEW_Y_Normal;
    self.naviView.naviTitleLabel.frame=CGRectMake(13, y, SCREEN_WIDTH- self.naviView.leftItemButton.width*2-10*2, self.naviView.height-y);
       self.page = 1;
       [self loadData];
       [self.tableView shouldAddHeaderRefresh:YES];
       [self.tableView shouldAddFooterRefresh:YES];
       __weak typeof(self)weakSelf = self;
       self.tableView.headerRefreshBlock = ^{
           
           weakSelf.page = 1;
           [weakSelf loadData];
       };
       self.tableView.footerRefreshBlock = ^{
         
           weakSelf.page++;
           [weakSelf loadData];
           
           
       };
}
-(void)loadData{
    [MatchHandle getMatchListWithPage:self.page pageNum:10 success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
               NSLog(@"dic==%@",dic);
               if ([dic[@"code"] intValue]==1) {
                   if (self.page==1) {
                       self.dataList=[MatchListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
                   }else{
                        [self.dataList addObjectsFromArray:[MatchListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
                   }
                  
               }
                [self.tableView reloadData];
                [self.tableView endRefreshing];
    } failed:^(id  _Nonnull obj) {
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
           return 118*KScaleH;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.dataList.count;
   
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
 
           Main_OneTableViewCell * cellOne = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (!cellOne) {
            cellOne= [[Main_OneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
                   }
            cellOne.selectionStyle=UITableViewCellSelectionStyleNone;
    cellOne.model=self.dataList[indexPath.row];
            return cellOne;
}
-(BaseTableView *)tableView{
    if (!_tableView) {
        CGFloat tabbar=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
        BaseTableView * tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-tabbar-self.naviView.bottom) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorColor=[UIColor clearColor];
        tableView.backgroundColor=[UIColor whiteColor];;
        [self.view addSubview:tableView];
        _tableView=tableView;
    }
    return _tableView;
}

@end
