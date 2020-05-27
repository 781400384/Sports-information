//
//  MyOrderTableViewCell.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell
-(void)layoutSubviews{
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14*KScaleW);
        make.top.mas_equalTo(11*KScaleH);
        make.height.mas_equalTo(53*KScaleH);
        make.width.mas_equalTo(SCREEN_WIDTH-28*KScaleW);
    }];
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11.5*KScaleW);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    [self.bgView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-11.5*KScaleW);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
}

-(UIImageView  *)bgView{
    if (!_bgView) {
        _bgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"p_bg"]];
        _bgView.contentMode=UIViewContentModeScaleAspectFill;
        _bgView.clipsToBounds=YES;
        [_bgView setRadius:5.0];
    }
    return _bgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=APP_BOLD_FONT(14.0);
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.text=@"23213";
    }
    return _titleLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
          _timeLabel=[[UILabel alloc]init];
          _timeLabel.font=APP_BOLD_FONT(12.0);
          _timeLabel.textAlignment=NSTextAlignmentCenter;
          _timeLabel.textColor=[UIColor whiteColor];
        _timeLabel.text=@"21313";
    }
    return _timeLabel;
}
-(void)setModel:(MyOrderModel *)model{
    _model=model;
    self.titleLabel.text=[NSString stringWithFormat:@"%@", model.court_name];
    self.timeLabel.text=[NSString stringWithFormat:@"预约时间：%@",model.appoint_date];
}
@end
