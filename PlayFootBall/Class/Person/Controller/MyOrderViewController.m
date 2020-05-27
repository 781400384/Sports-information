//
//  MyOrderViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderModel.h"
#import "PersonalHandle.h"
#import "PersonInfoViewController.h"
@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView     *      tableView;
@property (nonatomic, strong) NSMutableArray    *      dataList;
@property (nonatomic, strong) UIImageView       *       emptyImage;
@property (nonatomic, strong) UILabel           *       emptyLabel;
@property (nonatomic, strong) UILabel           *       emptyLabel1;

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"我的球场预约";
    UITapGestureRecognizer  *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
           [self.navigationController popViewControllerAnimated:YES];
       }];
       [self.naviView.naviTitleLabel addGestureRecognizer:tap];
    [self.tableView shouldAddHeaderRefresh:YES];
    __weak typeof(self)weakSelf = self;
    self.tableView.headerRefreshBlock = ^{
        [weakSelf loadData];
     
    };
    [self loadData];
     [self setUpEmpty];
}
-(void)loadData{
    [PersonalHandle getMyOrderWithSuccess:^(id  _Nonnull obj) {
        
       
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"dic==%@",obj);
        if ([dic[@"code"] intValue]==1) {
            self.dataList=[MyOrderModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            if (self.dataList.count==0) {
                           self.emptyImage.hidden=NO;
                           self.emptyLabel.hidden=NO;
                           self.emptyLabel1.hidden=NO;
                                  }else{
                           self.emptyImage.hidden=YES;
                           self.emptyLabel.hidden=YES;
                                      self.emptyLabel1.hidden=YES;
                                     
                                  }
            [self.tableView reloadData];
        }
        [self.tableView endRefreshing];
    } failed:^(id  _Nonnull obj) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    return 0.01;
        
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.dataList[indexPath.row];
  
    return cell;
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
        tableView.rowHeight = 74*KScaleH;
        tableView.tableFooterView = [UIView new];
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=[UIColor clearColor];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

-(void)setUpEmpty{
    self.emptyImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"p_empty"]];
    self.emptyImage.frame=CGRectMake((SCREEN_WIDTH-75*KScaleW)/2, 253*KScaleH, 75*KScaleW, 75*KScaleW);
    self.emptyImage.contentMode=UIViewContentModeScaleAspectFill;
    self.emptyImage.clipsToBounds=YES;
    self.emptyImage.hidden=YES;
    [self.view addSubview:self.emptyImage];
    
    self.emptyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.emptyImage.bottom+20.5*KScaleH, SCREEN_WIDTH, 13*KScaleH)];
    self.emptyLabel.textAlignment=NSTextAlignmentCenter;
    self.emptyLabel.font=APP_NORMAL_FONT(14.0);
    self.emptyLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
    self.emptyLabel.text=@"当前无球场预约哦~";
     self.emptyLabel.hidden=YES;
    [self.view addSubview:self.emptyLabel];
    
    self.emptyLabel1=[[UILabel alloc]initWithFrame:CGRectMake(0, self.emptyLabel.bottom+10.5*KScaleH, SCREEN_WIDTH, 13*KScaleH)];
    self.emptyLabel1.textAlignment=NSTextAlignmentCenter;
    self.emptyLabel1.font=APP_NORMAL_FONT(14.0);
    self.emptyLabel1.textColor=[UIColor colorWithHexString:@"#63717E"];
     self.emptyLabel1.hidden=YES;
    [self.view addSubview:self.emptyLabel1];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"快去球场看看吧"];
    NSRange range1 = [[str string] rangeOfString:@"快去"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#63717E"] range:range1];
    NSRange range2 = [[str string] rangeOfString:@"球场"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#21C648"] range:range2];
    NSRange range3 = [[str string] rangeOfString:@"看看吧"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#63717E"] range:range3];
     self.emptyLabel1.attributedText=str;
    self.emptyLabel1.userInteractionEnabled=YES;
     __weak typeof(self) weakSelf = self;
    UITapGestureRecognizer    *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
         [weakSelf.tabBarController setSelectedIndex:3];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.emptyLabel1 addGestureRecognizer:tap];
   
    
}

@end
