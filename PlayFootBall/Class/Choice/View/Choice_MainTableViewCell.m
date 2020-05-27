//
//  Choice_MainTableViewCell.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/11.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "Choice_MainTableViewCell.h"

@implementation Choice_MainTableViewCell

-(void)layoutSubviews{
    [self addSubview:self.indexLabel];
    [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26*KScaleW);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self addSubview:self.logoImg];
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.indexLabel.mas_right).offset(25.5*KScaleW);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.width.mas_equalTo(29*KScaleW);
    }];
    [self addSubview:self.teamName];
    [self.teamName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoImg.mas_right).offset(21.5*KScaleW);
       make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self addSubview:self.praiseImg];
    [self.praiseImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-94.5*KScaleW);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self addSubview:self.praiseNum];
    [self.praiseNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.praiseImg.mas_right).offset(12*KScaleW);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*KScaleW);
        make.width.mas_equalTo(SCREEN_WIDTH-26*KScaleW);
        make.height.mas_equalTo(0.5*KScaleH);
    }];
}
-(UILabel *)indexLabel{
    if (!_indexLabel) {
        _indexLabel=[[UILabel alloc]init];
        _indexLabel.textAlignment=NSTextAlignmentCenter;
        _indexLabel.font=APP_NORMAL_FONT(14.0);
       
    }
    return _indexLabel;
}
-(UIImageView *)logoImg{
    if (!_logoImg) {
        _logoImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_exampleTwo"]];
        _logoImg.clipsToBounds=YES;
        _logoImg.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _logoImg;
}
-(UILabel *)teamName{
    if (!_teamName) {
         _teamName=[[UILabel alloc]init];
         _teamName.textAlignment=NSTextAlignmentCenter;
         _teamName.font=APP_BOLD_FONT(14.0);
        _teamName.textColor=[UIColor colorWithHexString:@"#0B2137"];
        _teamName.text=@"测试数据";
    }
    return _teamName;
}
-(UIImageView *)praiseImg{
    if (!_praiseImg) {
        _praiseImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_praise_heart"]];
        _praiseImg.clipsToBounds=YES;
        _praiseImg.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _praiseImg;
}
-(UILabel *)praiseNum{
    if (!_praiseNum) {
         _praiseNum=[[UILabel alloc]init];
         _praiseNum.textAlignment=NSTextAlignmentCenter;
         _praiseNum.font=APP_NORMAL_FONT(12.0);
         _praiseNum.textColor=[UIColor colorWithHexString:@"#63717E"];
        _praiseNum.text=@"1321";
    }
    return _praiseNum;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=[UIColor colorWithHexString:@"#EFEFF0"];
    }
    return _lineView;
}
-(void)setModel:(FootBallTeamListModel *)model{
    _model=model;
    [self.logoImg sd_setImageWithURL:[NSURL URLWithString:model.team_logo] placeholderImage:[UIImage imageNamed:@"main_exampleTwo"]];
    self.teamName.text=model.name;
    self.praiseNum.text=model.total_amount;
}
@end
