//
//  Main_OneTableViewCell.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/9.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "Main_OneTableViewCell.h"

@implementation Main_OneTableViewCell

-(void)layoutSubviews{
    [self addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10.5*KScaleH);
        make.width.mas_equalTo(SCREEN_WIDTH-26*KScaleW);
        make.height.mas_equalTo(96*KScaleH);
        make.left.mas_equalTo(13*KScaleW);
    }];
    [self.bgImage addSubview:self.teamOne];
    [self.teamOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*KScaleW);
//        make.top.mas_equalTo(41.5*KScaleW);
         make.centerY.mas_equalTo(self.bgImage.mas_centerY);
        make.width.mas_equalTo(112.5*KScaleW);
        make.height.mas_equalTo(14*KScaleH);
    }];
    [self.bgImage addSubview:self.teamTwo];
    [self.teamTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13*KScaleW);
//        make.top.mas_equalTo(41.5*KScaleW);
         make.centerY.mas_equalTo(self.bgImage.mas_centerY);
        make.width.mas_equalTo(112.5*KScaleW);
        make.height.mas_equalTo(14*KScaleH);
    }];
    [self.bgImage addSubview:self.teamType];
    [self.teamType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15*KScaleH);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [self.bgImage addSubview:self.pointBgImage];
    [self.pointBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
         make.centerY.mas_equalTo(self.bgImage.mas_centerY);
//        make.top.mas_equalTo(self.teamType.mas_bottom).offset(10.5*KScaleH);
        make.width.mas_equalTo(2*KScaleW);
        make.height.mas_equalTo(10*KScaleH);
    }];
    [self.bgImage addSubview:self.pointOne];
    [self.pointOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.pointBgImage.mas_left).offset(-23.5*KScaleH);
        make.centerY.mas_equalTo(self.bgImage.mas_centerY);
    }];
    [self.bgImage addSubview:self.pointTwo];
    [self.pointTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pointBgImage.mas_right).offset(23.5*KScaleH);
       make.centerY.mas_equalTo(self.bgImage.mas_centerY);
    }];
    [self.bgImage addSubview:self.matchTime];
    [self.matchTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-14.5*KScaleH);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(59*KScaleW);
        make.height.mas_equalTo(15*KScaleH);
    }];
}
-(UIImageView  *)bgImage{
    if (!_bgImage) {
        _bgImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_hot_match_bg"]];
        _bgImage.clipsToBounds=YES;
        _bgImage.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _bgImage;
}
-(UILabel *)teamOne{
    if (!_teamOne) {
        _teamOne=[[UILabel alloc]init];
        _teamOne.textColor=[UIColor whiteColor];
        _teamOne.text=@"测试数据";
        _teamOne.font=APP_BOLD_FONT(14.0);
        _teamOne.textAlignment=NSTextAlignmentCenter;
    }
    return _teamOne;
}
-(UILabel *)teamTwo{
    if (!_teamTwo) {
        _teamTwo=[[UILabel alloc]init];
        _teamTwo.textColor=[UIColor whiteColor];
        _teamTwo.text=@"测试数据";
        _teamTwo.font=APP_BOLD_FONT(14.0);
        _teamTwo.textAlignment=NSTextAlignmentCenter;
    }
    return _teamTwo;
}
-(UILabel *)pointOne{
    if (!_pointOne) {
       _pointOne=[[UILabel alloc]init];
       _pointOne.textColor=[UIColor whiteColor];
        _pointOne.text=@"1";
       _pointOne.font=APP_BOLD_FONT(22.0);
       _pointOne.textAlignment=NSTextAlignmentCenter;
    }
    return _pointOne;
}
-(UILabel *)pointTwo{
    if (!_pointTwo) {
       _pointTwo=[[UILabel alloc]init];
       _pointTwo.textColor=[UIColor whiteColor];
       _pointTwo.text=@"2";
       _pointTwo.font=APP_BOLD_FONT(22.0);
       _pointTwo.textAlignment=NSTextAlignmentCenter;
    }
    return _pointTwo;
}
-(UILabel *)teamType{
    if (!_teamType) {
        _teamType=[[UILabel alloc]init];
        _teamType.textColor=[UIColor whiteColor];
        _teamType.font=APP_NORMAL_FONT(12.0);
        _teamType.text=@"测试";
        _teamType.textAlignment=NSTextAlignmentCenter;
    }
    return _teamType;
}
-(UILabel *)matchTime{
    if (!_matchTime) {
        _matchTime=[[UILabel alloc]init];
        _matchTime.textColor=[UIColor whiteColor];
        _matchTime.font=APP_NORMAL_FONT(12.0);
        _matchTime.textAlignment=NSTextAlignmentCenter;
        _matchTime.backgroundColor=RGBA(32, 166, 63, 1);
        [_matchTime setRadius:7.5*KScaleH];
        _matchTime.text=@"60:90";
    }
    return _matchTime;
}
-(UIImageView *)pointBgImage{
    if (!_pointBgImage) {
        _pointBgImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_hot_match_point_bg"]];
        _pointBgImage.clipsToBounds=YES;
        _pointBgImage.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _pointBgImage;
}
-(void)setModel:(MatchListModel *)model{
    _model=model;
    self.teamOne.text=model.main_team;
    self.teamTwo.text=model.guest_team;
    self.pointOne.text=model.main_team_mark;
    self.pointTwo.text=model.guest_team_mark;
    self.teamType.text=model.league_name;
    self.matchTime.text=model.status;
}
@end
