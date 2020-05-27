//
//  FootBGHandle.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "FootBGHandle.h"

@implementation FootBGHandle
/// H获取城市列表
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getCityWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    [HttpTools getWithBasePath:BaseURL Path:API_GET_CITY params:nil success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 获取球场列表
/// @param cityId <#cityId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getFootBGListWithcityId:(int)cityId success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{
        @"city_id":[NSNumber numberWithInt:cityId]
    };
    [HttpTools getWithBasePath:BaseURL Path:API_GET_FOOTBG_LIST params:dic success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 获取球场详情
/// @param BgId <#BgId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getFootBgDetailWithBgId:(int)BgId success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"court_id":[NSNumber numberWithInt:BgId]};
    [HttpTools getWithBasePath:BaseURL Path:API_GET_FOOTNG_DETAIL params:dic success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 时间段获取
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getTimeListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    [HttpTools getWithBasePath:BaseURL Path:API_GET_TIME_LIST params:nil success:^(id  _Nonnull json) {
         success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
+(void)orderWithTimeId:(int)timeId bgId:(int)bgId date:(NSString *)date phone:(NSString *)phone success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{
        @"period_id":[NSNumber numberWithInt:timeId],
        @"token":[UserInfoDefaults userInfo].token,
        @"court_id":[NSNumber numberWithInt:bgId],
        @"phone":phone,
        @"appointDate":date
    };
    NSLog(@"餐胡==%@",dic);
    [HttpTools postWithBasePath:BaseURL Path:API_ORER_BG params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
@end
