//
//  PersonalHandle.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "PersonalHandle.h"

@implementation PersonalHandle
/// 获取我的预约
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getMyOrderWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary  *  dic=@{@"token":[UserInfoDefaults userInfo].token};
    
    [HttpTools postWithBasePath:BaseURL Path:API_GET_MY_ORDER params:dic loading:NO success:^(id  _Nonnull json) {
         success(json);
    } failure:^(NSError * _Nonnull error) {
         failed(error);
    }];
//    [HttpTools getWithBasePath:BaseURL Path:API_GET_MY_ORDER params:dic success:^(id  _Nonnull json) {
//        success(json);
//    } failure:^(NSError * _Nonnull error) {
//        failed(error);
//    }];
}
+(void)getUserInfoWithToken:(NSString *)token Success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary  *  dic=@{@"token":token};
    [HttpTools postWithBasePath:BaseURL Path:API_GET_USERINFO params:dic loading:NO success:^(id  _Nonnull json) {
         success(json);
    } failure:^(NSError * _Nonnull error) {
         failed(error);
    }];
//       [HttpTools getWithBasePath:BaseURL Path:API_GET_USERINFO params:dic success:^(id  _Nonnull json) {
//           success(json);
//       } failure:^(NSError * _Nonnull error) {
//           failed(error);
//       }];
}
+(void)editUserInfoWithNickName:(NSString *)nickName birthday:(NSString *)birthday Success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary  *  dic=@{@"token":[UserInfoDefaults userInfo].token,
                           @"nickname":nickName,
                           @"birthday":birthday==nil?@"":birthday
    };
    
    NSLog(@"传入的参数==%@",dic);
    [HttpTools postWithBasePath:BaseURL Path:API_EDIT_USERINFO params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
          
}
@end
