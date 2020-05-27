//
//  MainHandle.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/10.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "BaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainHandle : BaseHandle
/// 获取Banner图
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getBannerWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取球队ll联赛列表
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getTeamListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取球队详细列表
/// @param teamid <#teamid description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getTeamDetailListTeamId:(int)teamid success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取热门球队列表
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getHotTeamListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取球队信息
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getTeamInfoWithTeamId:(int)teamId Success:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取球队评论列表
/// @param teamId <#teamId description#>
/// @param page <#page description#>
/// @param pageNum <#pageNum description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getJudgeListModelWithTeamId:(int)teamId page:(int)page pageNum:(int)pageNum success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取广告
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getAdvWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取首页赛事
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getMainMatchWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

@end

NS_ASSUME_NONNULL_END
