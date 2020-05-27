//
//  MatchHandle.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "BaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatchHandle : BaseHandle
/// 获取赛事列表
/// @param page <#page description#>
/// @param PageNum <#PageNum description#>
/// @param success <#success description#>
+(void)getMatchListWithPage:(int)page pageNum:(int)PageNum success:(SuccessBlock)success failed:(FailedBlock)failed;
@end

NS_ASSUME_NONNULL_END
