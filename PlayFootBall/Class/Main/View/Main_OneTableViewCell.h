//
//  Main_OneTableViewCell.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/9.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Main_OneTableViewCell : UITableViewCell
@property (nonatomic, strong) MatchListModel   *     model;
@property (nonatomic, strong) UIImageView      *     bgImage;
@property (nonatomic, strong) UILabel          *     teamOne;
@property (nonatomic, strong) UILabel          *     teamTwo;
@property (nonatomic, strong) UILabel          *     pointOne;
@property (nonatomic, strong) UILabel          *     pointTwo;
@property (nonatomic, strong) UILabel          *     teamType;
@property (nonatomic, strong) UILabel          *     matchTime;
@property (nonatomic, strong) UIImageView      *     pointBgImage;
@end

NS_ASSUME_NONNULL_END
