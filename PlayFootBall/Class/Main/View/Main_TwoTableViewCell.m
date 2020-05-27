//
//  Main_TwoTableViewCell.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/9.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "Main_TwoTableViewCell.h"

@implementation Main_TwoTableViewCell

-(void)layoutSubviews{
    [self addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*KScaleW);
        make.top.mas_equalTo(10.5*KScaleH);
        make.width.mas_equalTo(SCREEN_WIDTH-26*KScaleH);
        make.height.mas_equalTo(188.5*KScaleH);
    }];
    [self.bgImage addSubview:self.bgName];
    [self.bgName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6*KScaleW);
        make.bottom.mas_equalTo(-14*KScaleH);
    }];
    [self.bgImage addSubview:self.location];
    [self.location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-6*KScaleW);
        make.bottom.mas_equalTo(-14.5*KScaleH);
    }];
    [self.bgImage addSubview:self.locationImage];
    [self.locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.location.mas_left).offset(-4.5*KScaleW);
        make.bottom.mas_equalTo(-14.5*KScaleH);
    }];
    [self.bgImage addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.location.mas_top).offset(-13.5*KScaleH);
        make.right.mas_equalTo(-6*KScaleW);
    }];
}
-(UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_example"]];
        _bgImage.clipsToBounds=YES;
        _bgImage.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _bgImage;
}
-(UILabel *)bgName{
    if (!_bgName) {
        _bgName=[[UILabel alloc]init];
        _bgName.font=APP_BOLD_FONT(14.0);
        _bgName.textColor=[UIColor whiteColor];
        _bgName.textAlignment=NSTextAlignmentCenter;
        _bgName.text=@"b测试数据";
    }
    return _bgName;
}
-(UILabel *)money{
    if (!_money) {
        _money=[[UILabel alloc]init];
        _money.textColor=[UIColor whiteColor];
        _money.textAlignment=NSTextAlignmentCenter;
        _money.font=APP_BOLD_FONT(12.0);
        _money.text=@"10000元/小时";
    }
    return _money;
}
-(UIImageView *)locationImage{
    if (!_locationImage) {
        _locationImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_location"]];
        _locationImage.contentMode=UIViewContentModeScaleAspectFit;
        _locationImage.clipsToBounds=YES;
    }
    return _locationImage;
}
-(UILabel *)location{
    if (!_location) {
        _location=[[UILabel alloc]init];
        _location.textColor=[UIColor whiteColor];
        _location.font=APP_BOLD_FONT(12.0);
        _location.textAlignment=NSTextAlignmentCenter;
        _location.text=@"北京";
    }
    return _location;
}
-(void)setModel:(FootBallBGModel *)model{
    _model=model;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.img_small] placeholderImage:[UIImage imageNamed:@"main_example"]];
    self.bgName.text=model.name;
    self.location.text=model.city_name;
    self.money.text=model.cost;
}
@end
