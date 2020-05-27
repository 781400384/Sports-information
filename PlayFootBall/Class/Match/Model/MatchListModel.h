//
//  MatchListModel.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MatchListModel : NSObject
@property (nonatomic, copy) NSString     *   id;
@property (nonatomic, copy) NSString     *   match_time;
@property (nonatomic, copy) NSString     *   main_team_mark;
@property (nonatomic, copy) NSString     *   guest_team_mark;
@property (nonatomic, copy) NSString     *   status_id;
@property (nonatomic, copy) NSString     *   league_name;
@property (nonatomic, copy) NSString     *   main_team;
@property (nonatomic, copy) NSString     *   guest_team;
@property (nonatomic, copy) NSString     *   status;
@end

NS_ASSUME_NONNULL_END
