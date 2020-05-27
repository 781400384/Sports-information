//
//  MainHeaderView.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/10.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "MainHeaderView.h"
#import "Main_HotCollectionViewCell.h"
#import "MainHandle.h"
#import "BannerModel.h"
#import "ChoiceHandle.h"
#import "ChoiceListModel.h"
#import "HotTeamListModel.h"
static NSString   *  const cellID=@"cellID";
@interface MainHeaderView()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray              *            bannerList;
@property (nonatomic, strong) SDCycleScrollView           *            cycleScrollView;
@property (nonatomic, strong) UILabel                     *            choiceLabelOne;
@property (nonatomic, strong) UILabel                     *            choiceLabelTwo;
@property (nonatomic, strong) UILabel                     *            choiceLabelThree;
@property (nonatomic,strong) UIScrollView                 *            judgeScrollView;
@property (nonatomic, strong) UIImageView                 *            choiceImgOne;
@property (nonatomic, strong) UIImageView                 *            choiceImgTwo;
@property (nonatomic, strong) UIImageView                 *            choiceImgThree;
@property (nonatomic, strong) UICollectionView            *            collectionView;


@property (nonatomic, strong) NSMutableArray              *            choiceContentList;
@property (nonatomic, strong) NSMutableArray              *            hotTeamList;
@end
@implementation MainHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
        [self getBanner];
        [self getContentList];
        [self getHotTeamList];
        
        [self.collectionView registerClass:[Main_HotCollectionViewCell class] forCellWithReuseIdentifier:cellID];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:RefreshNotification object:nil];
    }
    return self;
}
-(void)refresh:(NSNotification *)refresh{
    [self getBanner];
    [self getContentList];
    [self getHotTeamList];
    NSLog(@"123");
}
#pragma mark - 轮播图数据处理
-(void)getBanner{
    [MainHandle getBannerWithSuccess:^(id  _Nonnull obj) {
        
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
             self.bannerList=[BannerModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            NSMutableArray *bannerUrlArray = [NSMutableArray array];
            for (BannerModel *model in self.bannerList) {
                [bannerUrlArray addObject:[NSString stringWithFormat:@"%@",model.img]];
                self.cycleScrollView.imageURLStringsGroup = bannerUrlArray;
            }
                
           
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}


#pragma mark - UI设定
-(void)setupUI{
    [self cycleView];
    [self choiceLabelOne];
    
    self.choiceLabelOne.userInteractionEnabled=YES;
    
    UITapGestureRecognizer  *  tapOne=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
          [[NSNotificationCenter defaultCenter] postNotificationName:ChoicePushNotification object:self userInfo:nil];
    }];
    [self.choiceLabelOne addGestureRecognizer:tapOne];
    
    self.choiceLabelTwo.userInteractionEnabled=YES;
       
       UITapGestureRecognizer  *  tapTwo=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ChoicePushNotification object:self userInfo:nil];
       }];
       [self.choiceLabelTwo addGestureRecognizer:tapTwo];
    self.choiceLabelThree.userInteractionEnabled=YES;
          
          UITapGestureRecognizer  *  tapThree=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
               [[NSNotificationCenter defaultCenter] postNotificationName:MatchPushNotification object:self userInfo:nil];
          }];
          [self.choiceLabelThree addGestureRecognizer:tapThree];
    
    
    self.choiceLabelOne.frame=CGRectMake(13*KScaleW, self.cycleScrollView.bottom+45.5*KScaleH, 80*KScaleW, 15.5*KScaleH);
    [self choiceImgOne];
    
    
    self.choiceImgOne.userInteractionEnabled=YES;
    UITapGestureRecognizer  *  imgOne=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                 [[NSNotificationCenter defaultCenter] postNotificationName:ChoicePushNotification object:self userInfo:nil];
            }];
            [self.choiceImgOne addGestureRecognizer:imgOne];
    self.choiceImgTwo.userInteractionEnabled=YES;
       UITapGestureRecognizer  *  imgTwo=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:ChoicePushNotification object:self userInfo:nil];
               }];
               [self.choiceImgTwo addGestureRecognizer:imgTwo];
    self.choiceImgThree.userInteractionEnabled=YES;
       UITapGestureRecognizer  *  imgThree=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                   [[NSNotificationCenter defaultCenter] postNotificationName:MatchPushNotification object:self userInfo:nil];
               }];
               [self.choiceImgThree addGestureRecognizer:imgThree];
    
    
    
    self.choiceImgOne.frame=CGRectMake(self.choiceLabelOne.right+16.5*KScaleW, self.cycleScrollView.bottom+48.5*KScaleH, 11*KScaleH, 11*KScaleH);
    UIView   *  bgView=[[UIView alloc]initWithFrame:CGRectMake(0, _choiceLabelOne.bottom+16*KScaleH, SCREEN_WIDTH, 90*KScaleH)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    self.judgeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, bgView.width, bgView.height)];
    self.judgeScrollView.backgroundColor = [UIColor whiteColor];
    self.judgeScrollView.showsHorizontalScrollIndicator = NO;
    [bgView addSubview:self.judgeScrollView];

    
    [self choiceLabelTwo];
       self.choiceLabelTwo.frame=CGRectMake(13*KScaleW, bgView.bottom+46*KScaleH, 80*KScaleW, 15.5*KScaleH);
       [self choiceImgTwo];
       self.choiceImgTwo.frame=CGRectMake(self.choiceLabelTwo.right+16.5*KScaleW, bgView.bottom+49*KScaleH, 11*KScaleH, 11*KScaleH);
    
    
    
         UICollectionViewFlowLayout *stretchyLayout= [UICollectionViewFlowLayout new];
                      
            _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, self.choiceLabelTwo.bottom+7.5*KScaleH, SCREEN_WIDTH, 365*KScaleH) collectionViewLayout:stretchyLayout];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
                      _collectionView.alwaysBounceVertical = YES;
                      _collectionView.showsVerticalScrollIndicator = NO;
                      _collectionView.backgroundColor = [UIColor whiteColor];
                      [self addSubview:_collectionView];
    
    UIImageView    *    advBg=[[UIImageView alloc]init];
       
             advBg.frame=CGRectMake(13*KScaleW, _collectionView.bottom+19*KScaleH, SCREEN_WIDTH-26*KScaleW, 136*KScaleH);
             advBg.contentMode=UIViewContentModeScaleAspectFill;
    advBg.userInteractionEnabled=YES;
   
             advBg.clipsToBounds=YES;
             [self addSubview:advBg];
    [MainHandle getAdvWithSuccess:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
            [advBg sd_setImageWithURL:[NSURL URLWithString:dic[@"data"][@"img"]] placeholderImage:[UIImage imageNamed:@"main_example"]];
            UITapGestureRecognizer  *  advTap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                   if (self.rreturnValueBlock) {
                          self.rreturnValueBlock(dic[@"data"][@"link_url"]);
                      }
               }];
               [advBg addGestureRecognizer:advTap];
        }
        
    } failed:^(id  _Nonnull obj) {
        
    }];
    
    [self choiceLabelThree];
       self.choiceLabelThree.frame=CGRectMake(13*KScaleW, advBg.bottom+42.5*KScaleH, 80*KScaleW, 15.5*KScaleH);
       [self choiceImgThree];
       self.choiceImgThree.frame=CGRectMake(self.choiceLabelThree.right+16.5*KScaleW, advBg.bottom+45*KScaleH, 11*KScaleH, 11*KScaleH);
    
    
}
#pragma mark - 获取底部广告

#pragma mark - 获取热门球队
-(void)getHotTeamList{
    [MainHandle getHotTeamListWithSuccess:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
            self.hotTeamList=[HotTeamListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self.collectionView reloadData];
            
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
#pragma mark - 支持语录数据处理

-(void)getContentList{
    [ChoiceHandle  getChoiceListWithSuccess:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
            self.choiceContentList=[ChoiceListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            self.judgeScrollView.contentSize = CGSizeMake(151*KScaleW*self.choiceContentList.count, 0);
            [self setUpChoiceContent];
            
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}


-(void)setUpChoiceContent{
    for (int i=0; i<self.choiceContentList.count; i++) {
        
        ChoiceListModel  *  model=self.choiceContentList[i];
           UIButton   *  btn=[[UIButton alloc]initWithFrame:CGRectMake(13*KScaleW+151*KScaleW*i, 0, 129*KScaleW, 90*KScaleH)];
           [btn setRadius:5*KScaleH];
           btn.backgroundColor=[UIColor whiteColor];
           btn.layer.borderColor=[UIColor colorWithHexString:@"#EFEFF0"].CGColor;
        [btn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
           btn.layer.borderWidth=0.5*KScaleW;
           [self.judgeScrollView addSubview:btn];
           
           UILabelSet  *  contentLabel=[[UILabelSet alloc]initWithFrame:CGRectMake(6.5*KScaleW, 6.5*KScaleH, btn.width-13*KScaleW, 50*KScaleH)];
           contentLabel.numberOfLines=0;
//        contentLabel.
//           contentLabel.textAlignment=NSTextAlignmentLeft;
           contentLabel.font=APP_NORMAL_FONT(13.0);
           contentLabel.text=model.content;
           contentLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
           [btn addSubview:contentLabel];
           
           UIImageView   *  logoImage=[[UIImageView alloc]init];
           [logoImage sd_setImageWithURL:[NSURL URLWithString:model.team_logo] placeholderImage:[UIImage imageNamed:@"main_exampleOne"]];
           logoImage.frame=CGRectMake(6.5*KScaleW, btn.height-19*KScaleH, 13*KScaleW, 13*KScaleH);
           logoImage.contentMode=UIViewContentModeScaleAspectFit;
           [btn addSubview:logoImage];
           UILabel *  teamName=[[UILabel alloc]initWithFrame:CGRectMake(24*KScaleW, btn.height-18*KScaleH, btn.width-24*KScaleW, 11.5*KScaleH)];
           teamName.textAlignment=NSTextAlignmentLeft;
           teamName.font=APP_NORMAL_FONT(12.0);
           teamName.text=model.team_name;
           teamName.textColor=[UIColor colorWithHexString:@"#0B2137"];
           [btn addSubview:teamName];
       }
}

-(void)push:(UIButton *)sender{
    ChoiceListModel  *  model=self.choiceContentList[sender.tag];
    if (self.getDetailBlock) {
           self.getDetailBlock(model.team_id);
       }
}
#pragma mark - Banner

-(void)cycleView{
    
    _cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(13*KScaleW, 9*KScaleH, SCREEN_WIDTH-26*KScaleW, 171.3*KScaleH) delegate:self placeholderImage:[UIImage imageNamed:@"2.jpg"]];
    _cycleScrollView.currentPageDotColor=APP_NAVI_COLOR;
    _cycleScrollView.autoScrollTimeInterval = 3.0;
    [_cycleScrollView setRadius:5*KScaleW];
    _cycleScrollView.contentMode = UIViewContentModeScaleToFill;
    _cycleScrollView.clipsToBounds = YES;
    [self addSubview:_cycleScrollView];
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
    printf("---点击了第%ld张图片\n",(long)index);
    BannerModel  *  model=self.bannerList[index];
    if (self.rreturnValueBlock) {
        self.rreturnValueBlock(model.link_url);
    }
}
#pragma mark  - UI控件初始化
-(UILabel *)choiceLabelOne{
    if (!_choiceLabelOne) {
        _choiceLabelOne=[[UILabel alloc]init];
        _choiceLabelOne.textAlignment=NSTextAlignmentCenter;
        _choiceLabelOne.text=@"支持语录";
        _choiceLabelOne.font=APP_BOLD_FONT(16.0);
        _choiceLabelOne.textColor=[UIColor colorWithHexString:@"#63717E"];
        [self addSubview:_choiceLabelOne];
    }
    return _choiceLabelOne;
}
-(UIImageView *)choiceImgOne{
    if (!_choiceImgOne) {
        _choiceImgOne=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_next_vc"]];
        _choiceImgOne.clipsToBounds=YES;
        _choiceImgOne.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_choiceImgOne];
    }
    return _choiceImgOne;
}
-(UILabel *)choiceLabelTwo{
    if (!_choiceLabelTwo) {
        _choiceLabelTwo=[[UILabel alloc]init];
        _choiceLabelTwo.textAlignment=NSTextAlignmentCenter;
        _choiceLabelTwo.text=@"最热球队";
        _choiceLabelTwo.font=APP_BOLD_FONT(16.0);
        _choiceLabelTwo.textColor=[UIColor colorWithHexString:@"#63717E"];
        [self addSubview:_choiceLabelTwo];
    }
    return _choiceLabelTwo;
}
-(UIImageView *)choiceImgTwo{
    if (!_choiceImgTwo) {
        _choiceImgTwo=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_next_vc"]];
        _choiceImgTwo.clipsToBounds=YES;
        _choiceImgTwo.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_choiceImgTwo];
    }
    return _choiceImgTwo;
}
-(UILabel *)choiceLabelThree{
    if (!_choiceLabelThree) {
        _choiceLabelThree=[[UILabel alloc]init];
        _choiceLabelThree.textAlignment=NSTextAlignmentCenter;
        _choiceLabelThree.text=@"热门赛事";
        _choiceLabelThree.font=APP_BOLD_FONT(16.0);
        _choiceLabelThree.textColor=[UIColor colorWithHexString:@"#63717E"];
        [self addSubview:_choiceLabelThree];
    }
    return _choiceLabelThree;
}
-(UIImageView *)choiceImgThree{
    if (!_choiceImgThree) {
        _choiceImgThree=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_next_vc"]];
        _choiceImgThree.clipsToBounds=YES;
        _choiceImgThree.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_choiceImgThree];
    }
    return _choiceImgThree;
}
#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
        
        return CGSizeMake( (SCREEN_WIDTH - 48*KScaleW)/2, 97*KScaleH );
  
    
}

#pragma mark - delegate & dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    if (self.hotTeamList.count>6) {
        return 6;
    }else{
        return self.hotTeamList.count;
    }
   
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    HotTeamListModel  *  model=self.hotTeamList[indexPath.row];
    if (self.getDetailBlock) {
        self.getDetailBlock(model.id);
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
        Main_HotCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
    cell.layer.borderWidth=0.5*KScaleW;
    cell.layer.borderColor=[UIColor colorWithHexString:@"#EFEFF0"].CGColor;
    [cell setRadius:5*KScaleW];
    cell.model=self.hotTeamList[indexPath.row];
       return  cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(11*KScaleH, 13*KScaleW, 11*KScaleH, 13*KScaleW );
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 22*KScaleW;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 22*KScaleH;

}

#pragma mark - banner图数据源处理

-(NSMutableArray  *)bannerList{
    if (!_bannerList) {
        _bannerList=[NSMutableArray array];
    }
    return _bannerList;
}
-(NSMutableArray *)choiceContentList{
    if (!_choiceContentList) {
        _choiceContentList=[ NSMutableArray array];
    }
    return _choiceContentList;
}
-(NSMutableArray *)hotTeamList{
    if (!_hotTeamList) {
        _hotTeamList=[NSMutableArray array];
    }
    return _hotTeamList;
}
@end
