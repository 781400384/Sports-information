//
//  Choice_MainTableViewCell.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/11.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FootBallTeamListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Choice_MainTableViewCell : UITableViewCell
@property (nonatomic, strong)FootBallTeamListModel   *  model;
@property (nonatomic, strong) UILabel      *      indexLabel;
@property (nonatomic, strong) UIImageView  *      logoImg;
@property (nonatomic, strong) UILabel      *      teamName;
@property (nonatomic, strong) UIImageView  *      praiseImg;
@property (nonatomic, strong) UILabel      *      praiseNum;
@property (nonatomic, strong) UIView       *      lineView;
@end

NS_ASSUME_NONNULL_END
