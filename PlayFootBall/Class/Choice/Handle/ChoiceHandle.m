//
//  ChoiceHandle.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/10.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "ChoiceHandle.h"

@implementation ChoiceHandle
/// 获取球队语录支持列表
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getChoiceListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    [HttpTools getWithBasePath:BaseURL Path:API_GET_CHOICE_LIST params:nil success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 点赞
/// @param teamId <#teamId description#>
/// @param success <#success description#>
/// @param failed <#fialed description#>
+(void)prasieWithTeamId:(int)teamId success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    
    NSDictionary * dic=@{
        @"team_id":[NSNumber numberWithInt:teamId],
        @"token":[UserInfoDefaults userInfo].token
    };
    NSLog(@"prama==%@ ",dic);
    [HttpTools postWithBasePath:BaseURL Path:API_PREAISE params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 发布评论
/// @param teamId <#teamId description#>
/// @param content <#content description#>
/// @param success <#success description#>
/// @param failed <#fialed description#>
+(void)sendJudgeWithTeamId:(int)teamId content:(NSString *)content success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"token":[UserInfoDefaults userInfo].token,
                         @"team_id":[NSNumber numberWithInt:teamId],
                         @"content":content
    };
    [HttpTools postWithBasePath:BaseURL Path:API_SEND_JUDGE params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
@end
