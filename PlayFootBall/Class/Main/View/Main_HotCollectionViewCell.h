//
//  Main_HotCollectionViewCell.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/10.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotTeamListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Main_HotCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) HotTeamListModel *     model;
@property (nonatomic, strong) UIImageView      *     logoTeamImg;
@property (nonatomic, strong) UILabel          *     teamName;
@property (nonatomic, strong) UIImageView      *     likeImg;
@property (nonatomic, strong) UILabel          *     likeNum;
@property (nonatomic, strong) UILabel          *     teamType;
@end

NS_ASSUME_NONNULL_END
