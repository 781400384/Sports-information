//
//  Choice_DetailTableViewCell.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/11.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamJudgeListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Choice_DetailTableViewCell : UITableViewCell
@property (nonatomic, strong) TeamJudgeListModel    *  model;
@property (nonatomic, strong) UIImageView    *     headImg;
@property (nonatomic, strong) UILabel        *     nickName;
@property (nonatomic, strong) UILabelSet        *     contentLabel;
@property (nonatomic, strong) UILabel        *     timeLabel;
@property (nonatomic, strong) UIImageView    *     timeImg;
@property (nonatomic, strong) UIView         *     bgView;
@property (nonatomic, strong) UIButton       *     btn;
@end

NS_ASSUME_NONNULL_END
