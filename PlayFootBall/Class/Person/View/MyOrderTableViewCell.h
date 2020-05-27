//
//  MyOrderTableViewCell.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyOrderTableViewCell : UITableViewCell
@property (nonatomic, strong) MyOrderModel   *   model;
@property (nonatomic, strong) UIImageView     *  bgView;
@property (nonatomic, strong) UILabel    *  timeLabel;
@property (nonatomic, strong) UILabel    *   titleLabel;
@end

NS_ASSUME_NONNULL_END
