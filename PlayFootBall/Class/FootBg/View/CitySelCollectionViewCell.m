//
//  CitySelCollectionViewCell.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "CitySelCollectionViewCell.h"

@implementation CitySelCollectionViewCell
-(void)layoutSubviews{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.font=APP_NORMAL_FONT(14.0);
        _titleLabel.textColor=[UIColor colorWithHexString:@"#0B2137"];
    }
    return _titleLabel;
}
-(void)setModel:(CityModel *)model{
    _model=model;
    self.titleLabel.text=model.name;
}
@end
