//
//  ChoiceListModel.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/10.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChoiceListModel : NSObject
@property (nonatomic, copy) NSString    *    id;
@property (nonatomic, copy) NSString    *    content;
@property (nonatomic, copy) NSString    *    head_img;
@property (nonatomic, copy) NSString    *    nickname;
@property (nonatomic, copy) NSString    *    created_at;
@property (nonatomic, copy) NSString    *    updated_at;
@property (nonatomic, copy) NSString    *    team_name;
@property (nonatomic, copy) NSString    *    team_logo;
@property (nonatomic, copy) NSString    *    team_id;
@end

NS_ASSUME_NONNULL_END
