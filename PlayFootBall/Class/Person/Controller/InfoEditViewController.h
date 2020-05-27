//
//  InfoEditViewController.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnValueBlock)(NSString *  data);
@interface InfoEditViewController : BaseViewController
@property (nonatomic, copy) ReturnValueBlock   rreturnValueBlock;
@end

NS_ASSUME_NONNULL_END
