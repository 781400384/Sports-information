//
//  PersonalHandle.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "BaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalHandle : BaseHandle
/// 获取我的预约
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getMyOrderWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

+(void)getUserInfoWithToken:(NSString *)token Success:(SuccessBlock)success failed:(FailedBlock)failed;

+(void)editUserInfoWithNickName:(NSString *)nickName birthday:(NSString *)birthday Success:(SuccessBlock)success failed:(FailedBlock)failed;
@end

NS_ASSUME_NONNULL_END
