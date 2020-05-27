//
//  OrderSuccessAlertView.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderSuccessAlertView : UIView
- (instancetype)initWithImage:(UIImage *)imageName textOne:(NSString  *)textOne textTwo:(NSString *)textTwo; ;

- (void)showView;

-(void)dismissAlertView;
@end

NS_ASSUME_NONNULL_END
