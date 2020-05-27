//
//  FootBGHandle.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "BaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface FootBGHandle : BaseHandle
/// 获取城市列表
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getCityWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取i球场列表
/// @param cityId <#cityId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getFootBGListWithcityId:(int)cityId success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取球场详情
/// @param BgId <#BgId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getFootBgDetailWithBgId:(int)BgId success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 时间段获取
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getTimeListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

/// 预约球场
/// @param timeId <#timeId description#>
/// @param bgId <#bgId description#>
/// @param date <#date description#>
/// @param phone <#phone description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)orderWithTimeId:(int)timeId bgId:(int)bgId date:(NSString *)date phone:(NSString *)phone success:(SuccessBlock)success failed:(FailedBlock)failed;
@end

NS_ASSUME_NONNULL_END
