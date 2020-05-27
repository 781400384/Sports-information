//
//  FootBackgroundViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/10.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "FootBackgroundViewController.h"
#import "Main_TwoTableViewCell.h"
#import "CitySelViewController.h"
#import "FootBGHandle.h"
#import "FootBallBGModel.h"
#import "FootBgDetailViewController.h"
@interface FootBackgroundViewController ()<UITableViewDelegate,BaseTableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView     *      tableView;
@property (nonatomic, strong) NSMutableArray    *      dataList;
@property (nonatomic, strong) UIImageView       *       emptyImage;
@property (nonatomic, strong) UILabel           *       emptyLabel;
@end

@implementation FootBackgroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.leftItemButton.hidden=YES;
    self.naviView.naviTitleLabel.text=@"球场玩球";
     CGFloat y = IS_X ? NAVI_SUBVIEW_Y_iphoneX : NAVI_SUBVIEW_Y_Normal;
    self.naviView.naviTitleLabel.frame=CGRectMake(13, y, SCREEN_WIDTH- self.naviView.leftItemButton.width*2-10*2, self.naviView.height-y);
    [self tableView];
    [self.naviView.rightItemButton setImage:[UIImage imageNamed:@"bg_Down"] forState:UIControlStateNormal];
    self.naviView.rightItemButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20*KScaleW, 0, 0);
    self.naviView.rightItemButton.imageEdgeInsets = UIEdgeInsetsMake(0,46*KScaleW, 0, 0);
    [self.naviView.rightItemButton setTitleColor:[UIColor colorWithHexString:@"#63717E"] forState:UIControlStateNormal];
    [self.naviView.rightItemButton addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    self.naviView.rightItemButton.titleLabel.font=APP_NORMAL_FONT(12.0);
    
    NSUserDefaults  *  defaults=[NSUserDefaults standardUserDefaults];
    NSLog(@"城市aID%d",[[defaults valueForKey:@"cityId"] intValue]);
    if([[defaults valueForKey:@"cityId"] intValue]==0){
        [self.naviView.rightItemButton setTitle:@"北京" forState:UIControlStateNormal];
        [self loadDataWithID:1];
    }else{
          [self.naviView.rightItemButton setTitle:[defaults valueForKey:@"cityName"] forState:UIControlStateNormal];
         [self loadDataWithID:[[defaults valueForKey:@"cityId"] intValue]];
    }
    [self.tableView shouldAddHeaderRefresh:YES];
         __weak typeof(self)weakSelf = self;
         self.tableView.headerRefreshBlock = ^{

             if([[defaults valueForKey:@"cityId"] intValue]==0){
                 [weakSelf.naviView.rightItemButton setTitle:@"北京" forState:UIControlStateNormal];
                 [weakSelf loadDataWithID:1];
             }else{
                   [weakSelf.naviView.rightItemButton setTitle:[defaults valueForKey:@"cityName"] forState:UIControlStateNormal];
                  [weakSelf loadDataWithID:[[defaults valueForKey:@"cityId"] intValue]];
             }
          
         };
    
    
    
     [self setUpEmpty];
}
-(void)rightBtn{
    CitySelViewController  *  vc=[[CitySelViewController alloc]init];
    vc.rreturnValueBlock = ^(NSString *cityId, NSString *cityName) {
        [self.naviView.rightItemButton setTitle:cityName forState:UIControlStateNormal];
        [self loadDataWithID:[cityId intValue]];
    };
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)loadDataWithID:(int)ID{
    [FootBGHandle getFootBGListWithcityId:ID success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if([dic[@"code"] intValue]==1){
            self.dataList=[FootBallBGModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self.tableView reloadData];
             if (self.dataList.count==0) {
                self.emptyImage.hidden=NO;
                self.emptyLabel.hidden=NO;
                       }else{
                self.emptyImage.hidden=YES;
                self.emptyLabel.hidden=YES;
                          
                       }
            
        }
        [self.tableView endRefreshing];
    } failed:^(id  _Nonnull obj) {
         NSLog(@"abc===%@",obj);
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FootBgDetailViewController   *  vc=[[FootBgDetailViewController alloc]init];
    FootBallBGModel * model=self.dataList[indexPath.row];
    vc.bgId=model.id;
    [self.navigationController pushViewController:vc animated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
          return 209.5*KScaleH;
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
   
 
           Main_TwoTableViewCell * cellOne = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (!cellOne) {
            cellOne= [[Main_TwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
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

-(void)setUpEmpty{
    self.emptyImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_empty"]];
    self.emptyImage.frame=CGRectMake(150*KScaleW, 226*KScaleH, SCREEN_WIDTH-300*KScaleW, SCREEN_WIDTH-300*KScaleW);
    self.emptyImage.contentMode=UIViewContentModeScaleAspectFill;
    self.emptyImage.clipsToBounds=YES;
    self.emptyImage.hidden=YES;
    [self.view addSubview:self.emptyImage];
    
    self.emptyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.emptyImage.bottom+45*KScaleH, SCREEN_WIDTH, 13*KScaleH)];
    self.emptyLabel.textAlignment=NSTextAlignmentCenter;
    self.emptyLabel.font=APP_NORMAL_FONT(14.0);
    self.emptyLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
    self.emptyLabel.text=@"这里还没有球场哦~";
     self.emptyLabel.hidden=YES;
    [self.view addSubview:self.emptyLabel];
    
   
    
}

@end
