//
//  MainHandle.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/10.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "MainHandle.h"

@implementation MainHandle
/// 获取Banner图
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getBannerWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary  *  dic=@{@"version":[NSString getVersion]};
    [HttpTools getWithBasePath:BaseURL Path:API_GET_BANNER params:dic success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 获取球队联赛列表
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getTeamListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    [HttpTools getWithBasePath:BaseURL Path:API_GET_TEAM_LIST params:nil success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// g获取球队详细列表
/// @param teamid <#teamid description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getTeamDetailListTeamId:(int)teamid success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    NSDictionary * dic=@{@"league_id":[NSNumber numberWithInt:teamid]};
    [HttpTools getWithBasePath:BaseURL Path:API_GET_TEAM_DETAI_LIST params:dic success:^(id  _Nonnull json) {
           success(json);
       } failure:^(NSError * _Nonnull error) {
           failed(error);
       }];
}
/// 获取热门球队列表
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getHotTeamListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    [HttpTools getWithBasePath:BaseURL Path:API_GET_HOT_TEAM params:nil success:^(id  _Nonnull json) {
           success(json);
       } failure:^(NSError * _Nonnull error) {
           failed(error);
       }];
}
/// 获取球队信息
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getTeamInfoWithTeamId:(int)teamId Success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{
        @"team_id":[NSNumber numberWithInt:teamId]
    };
    [HttpTools getWithBasePath:BaseURL Path:API_GET_TEAM_INFO params:dic success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 获取球队评论列表
/// @param teamId <#teamId description#>
/// @param page <#page description#>
/// @param pageNum <#pageNum description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getJudgeListModelWithTeamId:(int)teamId page:(int)page pageNum:(int)pageNum success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"team_id":[NSNumber numberWithInt:teamId],
                         @"page":[NSNumber numberWithInt:page],
                         @"limit":[NSNumber numberWithInt:pageNum]
    };
    [HttpTools getWithBasePath:BaseURL Path:API_GET_TEAM_JUDGE_LIST params:dic success:^(id  _Nonnull json) {
          success(json);
      } failure:^(NSError * _Nonnull error) {
          failed(error);
      }];
}
/// 获取广告
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getAdvWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary  *  dic=@{@"version":[NSString getVersion]};
    [HttpTools getWithBasePath:BaseURL Path:API_GET_ADV params:dic success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
    
}
/// 获取首页赛事
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getMainMatchWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    
    [HttpTools getWithBasePath:BaseURL Path:API_GET_MAIN_MATCH params:nil success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
@end
