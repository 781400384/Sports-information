//
//  MainHeaderView.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/10.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnValueBlock)(NSString *  linkUrl);
typedef void (^getTeamDetailBlock)(NSString *  ID);
@interface MainHeaderView : UIView
@property (nonatomic, copy) ReturnValueBlock   rreturnValueBlock;
@property (nonatomic, copy) getTeamDetailBlock   getDetailBlock;
@end

NS_ASSUME_NONNULL_END
