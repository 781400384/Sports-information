//
//  Main_HotCollectionViewCell.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/10.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "Main_HotCollectionViewCell.h"

@implementation Main_HotCollectionViewCell
-(void)layoutSubviews{
    [self addSubview:self.logoTeamImg];
    [self.logoTeamImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(36*KScaleW);
        make.left.mas_equalTo(17*KScaleW);
        make.top.mas_equalTo(27*KScaleH);
    }];
    [self addSubview:self.teamName];
    [self.teamName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoTeamImg.mas_right).offset(16.5*KScaleW);
        make.top.mas_equalTo(26*KScaleH);
    }];
    [self addSubview:self.likeImg];
    [self.likeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoTeamImg.mas_right).offset(16.5*KScaleW);
        make.top.mas_equalTo(self.teamName.mas_bottom).offset(13.5*KScaleH);
    }];
    [self addSubview:self.likeNum];
    [self.likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.likeImg.mas_right).offset(5.5*KScaleW);
        make.centerY.mas_equalTo(self.likeImg.mas_centerY);
    }];
    [self addSubview:self.teamType];
    [self.teamType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-6.5*KScaleW);
        make.bottom.mas_equalTo(-3.5*KScaleH);
        make.width.mas_equalTo(28.5*KScaleW);
        make.height.mas_equalTo(12*KScaleH);
    }];
}
-(UIImageView *)logoTeamImg{
    if (!_logoTeamImg) {
        _logoTeamImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_exampleTwo"]];
        _logoTeamImg.clipsToBounds=YES;
        _logoTeamImg.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _logoTeamImg;
}
-(UILabel *)teamName{
    if (!_teamName) {
        _teamName=[[UILabel alloc]init];
        _teamName.textAlignment=NSTextAlignmentCenter;
        _teamName.textColor=[UIColor colorWithHexString:@"#0B2137"];
        _teamName.font=APP_NORMAL_FONT(14.0);
        _teamName.text=@"AC测试数据";
    }
    return _teamName;
}
-(UIImageView *)likeImg{
    if (!_likeImg) {
        _likeImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_praise_heart"]];
        _likeImg.clipsToBounds=YES;
        _likeImg.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _likeImg;
}
-(UILabel *)likeNum{
    if (!_likeNum) {
        _likeNum=[[UILabel alloc]init];
        _likeNum.textAlignment=NSTextAlignmentCenter;
        _likeNum.font=APP_NORMAL_FONT(12.0);
        _likeNum.textColor=[UIColor colorWithHexString:@"#63717E"];
        _likeNum.text=@"123213";
    }
    return _likeNum;
}
-(UILabel *)teamType{
    if (!_teamType) {
        _teamType=[[UILabel alloc]init];
        _teamType.backgroundColor=[UIColor colorWithHexString:@"#21C648"];
        _teamType.font=APP_NORMAL_FONT(10.0);
        _teamType.textColor=[UIColor whiteColor];
        _teamType.textAlignment=NSTextAlignmentCenter;
        _teamType.text=@"西甲";
        [_teamType setRadius:3*KScaleH];
    }
    return _teamType;
}
-(void)setModel:(HotTeamListModel *)model{
    _model=model;
    [self.logoTeamImg sd_setImageWithURL:[NSURL URLWithString:model.team_logo] placeholderImage:[UIImage imageNamed:@"main_exampleTwo"]];
    self.teamName.text=model.team_name;
    self.likeNum.text=model.total_amount;
    self.teamType.text=model.league_name;
}
@end
