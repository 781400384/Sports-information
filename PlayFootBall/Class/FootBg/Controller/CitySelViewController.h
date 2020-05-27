//
//  CitySelViewController.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^ReturnValueBlock)(NSString *  cityId,NSString  *  cityName);
NS_ASSUME_NONNULL_BEGIN

@interface CitySelViewController : BaseViewController
@property (nonatomic, copy) ReturnValueBlock   rreturnValueBlock;
@end

NS_ASSUME_NONNULL_END
