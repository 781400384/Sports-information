//
//  APIConfig.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/25.
//  Copyright © 2019 Superme. All rights reserved.
//

#ifndef APIConfig_h
#define APIConfig_h

#define  BaseURL          @"http://kcb-api.qianr.com/ball_v1/"
#define  LoginBase        @"https://ubase.qianr.com/api/public/?service=CommonLogin.userLogin"
#define  NET_CACHE           @"NetCache"
#define API_UPLOAD_AVATAR          @"https://ubase.qianr.com/api/public/?service=user.updateAvatar" //上传头像
#define  API_GET_BANNER            @"bad/carousel" //获取Banner
#define  API_GET_ADV               @"bad/ad" //后去广告
#define  API_GET_TEAM_LIST         @"bteam/league-list" //获取联赛列表
#define  API_GET_TEAM_DETAI_LIST   @"bteam/team-list" //获取球队列表
#define  API_GET_HOT_TEAM          @"bteam/hot-team" //获取热门球队列表
#define  API_GET_TEAM_INFO         @"bteam/team-info" //获取球队信息
#define  API_GET_TEAM_JUDGE_LIST   @"bteam/team-comment"//获取球队评论列表
#define  API_GET_CHOICE_LIST       @"bcomment/index-comment"//获取球队支持语录列表
#define  API_PREAISE               @"bfavorite/add-favorite"//点赞
#define  API_SEND_JUDGE            @"bfavorite/add-comment"//发布评论
#define  API_GET_CITY              @"bcity/list"//获取城市列表
#define  API_GET_FOOTBG_LIST       @"bcourt/court-list"//获取球场列表
#define  API_GET_FOOTNG_DETAIL     @"bcourt/court-detail"//获取球场详情
#define  API_GET_TIME_LIST         @"bcourt/appoint-time" //时间段获取
#define  API_ORER_BG               @"bcourt/court-appoint"//预约球场
#define  API_GET_MY_ORDER          @"bcourt/my-appoint"//获取我的预约
#define  API_GET_MATCH_LIST        @"bmatch/match-list" //获取赛事列表
#define  API_GET_MAIN_MATCH        @"bmatch/new-match"//获取首页赛事

#define API_EDIT_USERINFO          @"buser/user-save" //修改个人信息
#define API_GET_USERINFO           @"buser/user-info" //获取用户信息
#endif /* APIConfig_h */
