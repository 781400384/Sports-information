//
//  CitySelCollectionViewCell.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CitySelCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) CityModel  *  model;
@property (nonatomic, strong) UILabel    *  titleLabel;
@end

NS_ASSUME_NONNULL_END
