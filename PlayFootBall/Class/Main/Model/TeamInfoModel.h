//
//  TeamInfoModel.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/10.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamInfoModel : NSObject
@property (nonatomic, copy) NSString     *   name;
@property (nonatomic, copy) NSString     *   team_logo;
@property (nonatomic, copy) NSString     *   establish_time;
@property (nonatomic, copy) NSString     *   main_name;
@property (nonatomic, copy) NSString     *   total_amount;
@property (nonatomic, copy) NSString     *   league_name;
@property (nonatomic, copy) NSString     *   city_name;
@end

NS_ASSUME_NONNULL_END
