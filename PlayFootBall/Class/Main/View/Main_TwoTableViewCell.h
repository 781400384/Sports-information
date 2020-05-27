//
//  Main_TwoTableViewCell.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/9.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FootBallBGModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Main_TwoTableViewCell : UITableViewCell
@property (nonatomic, strong) FootBallBGModel  *     model;
@property (nonatomic, strong) UIImageView      *     bgImage;
@property (nonatomic, strong) UILabel          *     bgName;
@property (nonatomic, strong) UILabel          *     money;
@property (nonatomic, strong) UIImageView      *     locationImage;
@property (nonatomic, strong) UILabel          *     location;
@end

NS_ASSUME_NONNULL_END
