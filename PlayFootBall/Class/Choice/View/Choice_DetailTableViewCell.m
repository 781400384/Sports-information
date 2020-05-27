//
//  Choice_DetailTableViewCell.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/11.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "Choice_DetailTableViewCell.h"

@implementation Choice_DetailTableViewCell

-(void)layoutSubviews{
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*KScaleW);
        make.top.mas_equalTo(11*KScaleH);
        make.width.mas_equalTo(SCREEN_WIDTH-26*KScaleH);
        make.height.mas_equalTo(self.height-22*KScaleH);
    }];
    [self.bgView addSubview:self.headImg];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22.5*KScaleW);
        make.top.mas_equalTo(16.5*KScaleH);
        make.width.height.mas_equalTo(18*KScaleW);
    }];
    [self.bgView addSubview:self.nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImg.mas_right).offset(7.5*KScaleH);
        make.top.mas_equalTo(19.5*KScaleH);
    }];
    [self.bgView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22.5*KScaleW);
        make.width.mas_equalTo(self.bgView.width-25*KScaleW);
//        make.height.mas_equalTo(60*KScaleH);
        make.top.mas_equalTo(self.headImg.mas_bottom).offset(26*KScaleH);
    }];
    [self.bgView addSubview:self.timeImg];
    [self.timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-22.5*KScaleH);
        make.top.mas_equalTo(19.5*KScaleH);
    }];
    [self.bgView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeImg.mas_left).offset(-11*KScaleW);
        make.top.mas_equalTo(19.5*KScaleH);
    }];
    [self.bgView addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeLabel.mas_left).offset(-11*KScaleW);
        make.centerY.mas_equalTo(self.timeLabel.mas_centerY);
        make.width.mas_equalTo(43.5*KScaleW);
        make.height.mas_equalTo(11.5*KScaleH);
    }];
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=[UIColor whiteColor];
        _bgView.layer.borderWidth=0.5*KScaleW;
        _bgView.layer.borderColor=[UIColor colorWithHexString:@"#EFEFF0"].CGColor;
        [_bgView setRadius:5*KScaleW];
    }
    return _bgView;
}
-(UIImageView *)headImg{
    if (!_headImg) {
        _headImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"choice_head_example"]];
        _headImg.contentMode=UIViewContentModeScaleAspectFill;
        _headImg.clipsToBounds=YES;
        [_headImg setRadius:9*KScaleW];
    }
    return _headImg;
}
-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc]init];
        _nickName.textAlignment=NSTextAlignmentCenter;
        _nickName.font=APP_NORMAL_FONT(12.0);
        _nickName.textColor=[UIColor colorWithHexString:@"#63717E"];
    }
    return _nickName;
}
-(UILabelSet *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabelSet alloc]init];
//        _contentLabel.textAlignment=NSTextAlignmentLeft;
        _contentLabel.numberOfLines=0;
        _contentLabel.font=APP_NORMAL_FONT(12.0);
        _contentLabel.textColor=[UIColor colorWithHexString:@"#0B2137"];
    }
    return _contentLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        _timeLabel.font=APP_NORMAL_FONT(12.0);
        _timeLabel.textColor=[UIColor colorWithHexString:@"#CDD3D9"];
    }
    return _timeLabel;
}
-(UIImageView *)timeImg{
    if (!_timeImg) {
        _timeImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"choice_time"]];
        _timeImg.contentMode=UIViewContentModeScaleAspectFit;
        _timeImg.clipsToBounds=YES;
    }
    return _timeImg;
}
-(UIButton  *)btn{
    if (!_btn) {
        _btn=[[UIButton alloc]init];
        [_btn setTitle:@"举报" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor colorWithHexString:@"#CDD3D9"] forState:UIControlStateNormal];
        _btn.titleLabel.font=APP_NORMAL_FONT(12.0);
        _btn.backgroundColor=[UIColor whiteColor];
    }
    return _btn;
}
-(void)setModel:(TeamJudgeListModel *)model{
    _model=model;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@"choice_head_example"]];
    self.nickName.text=model.nickname;
    self.contentLabel.text=model.content;
    self.timeLabel.text=model.comment_time;
}
@end
