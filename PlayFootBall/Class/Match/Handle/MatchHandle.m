//
//  MatchHandle.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "MatchHandle.h"

@implementation MatchHandle
/// 获取赛事列表
/// @param page <#page description#>
/// @param PageNum <#PageNum description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getMatchListWithPage:(int)page pageNum:(int)PageNum success:(SuccessBlock)success failed:(nonnull FailedBlock)failed{
    NSDictionary * dic=@{@"page":[NSNumber numberWithInt:page],
                         @"limit":[NSNumber numberWithInt:PageNum]
    };
    [HttpTools getWithBasePath:BaseURL Path:API_GET_MATCH_LIST params:dic success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
@end
