//
//  CitySelViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "CitySelViewController.h"
#import "CitySelCollectionViewCell.h"
#import "CityModel.h"
#import "FootBGHandle.h"
static NSString   *  const cellID=@"cellID";
@interface CitySelViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView            *            collectionView;
@property (nonatomic, strong) NSMutableArray              *            dataList;
@end

@implementation CitySelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"选择城市";
    UITapGestureRecognizer  *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.naviView.naviTitleLabel addGestureRecognizer:tap];
    [self.collectionView registerClass:[CitySelCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self loadData];
}
-(void)loadData{
    [FootBGHandle getCityWithSuccess:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
            self.dataList=[CityModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self.collectionView reloadData];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        return CGSizeMake( (SCREEN_WIDTH - 85*KScaleW)/4, 34*KScaleH );
}

#pragma mark - delegate & dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataList.count;
   
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
     NSUserDefaults  *  defaults=[NSUserDefaults standardUserDefaults];
  
    CityModel   *  model=self.dataList[indexPath.row];
    if (self.rreturnValueBlock) {
        self.rreturnValueBlock(model.id, model.name);
        [defaults setObject:model.name forKey:@"cityName"];
        [defaults setObject:model.id forKey:@"cityId"];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
    CitySelCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.layer.borderWidth=0.5*KScaleW;
    cell.layer.borderColor=[UIColor colorWithHexString:@"#EFEFF0"].CGColor;
    [cell setRadius:5*KScaleW];
    cell.model=self.dataList[indexPath.row];
       return  cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(11*KScaleH, 17*KScaleW, 11*KScaleH, 17*KScaleW );
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 17*KScaleW;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 22*KScaleH;

}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        CGFloat tabbar=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
        UICollectionViewFlowLayout *stretchyLayout= [UICollectionViewFlowLayout new];
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.naviView.bottom-tabbar) collectionViewLayout:stretchyLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
@end
