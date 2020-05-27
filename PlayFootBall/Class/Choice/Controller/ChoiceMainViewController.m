//
//  ChoiceMainViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "ChoiceMainViewController.h"
#import "FootBallTeamDetailListModel.h"
#import "ChoiceViewController.h"
#import "MainHandle.h"

@interface ChoiceMainViewController ()
@property (nonatomic, strong) NSMutableArray    *      titleList;


@end

@implementation ChoiceMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.hidden=YES;
//    [self loadData];
}

-(void)loadData{
    [MainHandle getTeamListWithSuccess:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
           self.titleList=[FootBallTeamDetailListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self setupUI];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}

-(void)setupUI{
   

}
-(NSMutableArray *)titleList{
    if (!_titleList) {
        _titleList=[NSMutableArray array];
    }
    return _titleList;
}


@end
