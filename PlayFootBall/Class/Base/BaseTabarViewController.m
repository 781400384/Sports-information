//
//  BaseTabarViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "BaseTabarViewController.h"
#import "FirstMainViewController.h"
#import "ChoiceMainViewController.h"
#import "MatchMainViewController.h"
#import "PersonMainViewController.h"
#import "FootBackgroundViewController.h"
#import "ChoiceSegViewController.h"
@interface BaseTabarViewController ()

@end

@implementation BaseTabarViewController

+(void)initialize
{
    //设置未选中的TabBarItem的字体颜色、大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12*KScaleW];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#CDD3D9"];
    //设置选中了的TabBarItem的字体颜色、大小
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12*KScaleW];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#21C648"];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat tabbar_height = IS_X ? TABBAR_HEIGHT_X : TABBAR_HEIGHT;
    UIView *TabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tabbar_height)];
    TabBarView.backgroundColor = [UIColor whiteColor];

    [self.tabBar addSubview:TabBarView];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
  
  
  
    [self setUpAllChildVc];
}
- (void)setUpAllChildVc
{
    [self setupChildVc:[[FirstMainViewController alloc] init] title:@"首页" image:@"main_nor" selectedImage:@"main_sel"];
    [self setupChildVc:[[MatchMainViewController alloc] init] title:@"赛事" image:@"match_nor" selectedImage:@"match_sel"];
    [self setupChildVc:[[ChoiceSegViewController alloc] init] title:@"支持墙" image:@"choice_nor" selectedImage:@"choice_sel"];
    [self setupChildVc:[[FootBackgroundViewController alloc] init] title:@"球场" image:@"backGround_nor" selectedImage:@"backGround_sel"];
    [self setupChildVc:[[PersonMainViewController alloc] init] title:@"我的" image:@"personal_nor" selectedImage:@"personal_sel"];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.title = title;
    if (image || selectedImage) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        UIImage *selectImage = [UIImage imageNamed:selectedImage];
        vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    
   BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
   
    [self addChildViewController:nav];
}


@end
