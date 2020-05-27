//
//  ChoiceHandle.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/10.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "BaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChoiceHandle : BaseHandle

/// 获取球队支持语录l列表
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getChoiceListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

/// 点赞
/// @param teamId <#teamId description#>
/// @param success <#success description#>
/// @param fialed <#fialed description#>
+(void)prasieWithTeamId:(int)teamId success:(SuccessBlock)success failed:(FailedBlock)fialed;
/// 发布评论
/// @param teamId <#teamId description#>
/// @param content <#content description#>
/// @param success <#success description#>
/// @param failed <#fialed description#>
+(void)sendJudgeWithTeamId:(int)teamId content:(NSString *)content success:(SuccessBlock)success failed:(FailedBlock)failed;


@end

NS_ASSUME_NONNULL_END
