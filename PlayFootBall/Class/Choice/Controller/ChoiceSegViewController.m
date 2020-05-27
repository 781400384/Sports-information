//
//  ChoiceSegViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/16.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "ChoiceSegViewController.h"
#import "FootBallTeamDetailListModel.h"
#import "ChoiceViewController.h"
#import "MainHandle.h"
@interface ChoiceSegViewController ()
@property (nonatomic, strong) NSMutableArray    *      titleList;

@end

@implementation ChoiceSegViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    [self loadData];
   
}
-(void)setupUI{
    [self setUpAllChildViewController];
        
        [self setUpDisplayStyle:^(UIColor *__autoreleasing *titleScrollViewBgColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIColor *__autoreleasing *proColor, UIFont *__autoreleasing *titleFont, CGFloat *titleButtonWidth, BOOL *isShowPregressView, BOOL *isOpenStretch, BOOL *isOpenShade) {
            *titleScrollViewBgColor = [UIColor whiteColor]; //标题View背景色（默认标题背景色为白色）
            *norColor = [UIColor colorWithHexString:@"#CDD3D9"];            //标题未选中颜色（默认未选中状态下字体颜色为黑色）
            *selColor = [UIColor colorWithHexString:@"#21C648"];              //标题选中颜色（默认选中状态下字体颜色为红色）
            *proColor = [UIColor colorWithHexString:@"#21C648"];              //滚动条颜色（默认为标题选中颜色）
            *titleFont = [UIFont boldSystemFontOfSize:12.0];      //字体尺寸 (默认fontSize为15)
            
            *titleButtonWidth = 62.5;                        //标题按钮的宽度（有默认值）
            
            /*
             以下BOOL值默认都为NO
             */
            *isShowPregressView = YES;                      //是否开启标题下部Pregress指示器
            *isOpenStretch = YES;                           //是否开启指示器拉伸效果
            *isOpenShade = YES;                             //是否开启字体渐变
        }];
}
#pragma mark - 添加所有子控制器
- (void)setUpAllChildViewController
{
    for (NSInteger i = 0; i < self.titleList.count; i++) {
        FootBallTeamDetailListModel   *  model=self.titleList[i];
      ChoiceViewController *vc = [ChoiceViewController new];
        vc.title = model.name;
        vc.ID=model.id;
      
        [self addChildViewController:vc];
    }
    
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
-(NSMutableArray *)titleList{
    if (!_titleList) {
        _titleList=[NSMutableArray array];
    }
    return _titleList;
}


@end
