//
//  FootBallBgAlertView.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CodeView;

@protocol AlerViewDelegate <NSObject>
@end
NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnValueBlock)(NSString *  date,NSString  *  time,NSString * phone);
@interface FootBallBgAlertView : UIView
@property (nonatomic, weak) id<AlerViewDelegate> delegate;
@property (nonatomic, copy) ReturnValueBlock   rreturnValueBlock;
- (void)showView;

-(void)dismissAlertView;

-(void)showViewWithImage:(UIImage *)imageName textOne:(NSString  *)textOne textTwo:(NSString *)textTwo;
@end

NS_ASSUME_NONNULL_END
