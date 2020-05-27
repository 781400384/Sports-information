//
//  OrderSuccessAlertView.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "OrderSuccessAlertView.h"
@interface OrderSuccessAlertView()
@property (nonatomic, strong) UIView           *   alertView;
@end
@implementation OrderSuccessAlertView
-(instancetype)initWithImage:(UIImage *)imageName textOne:(NSString *)textOne textTwo:(NSString *)textTwo{
    if (self) {
           self.userInteractionEnabled=YES;
           UITapGestureRecognizer   *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
               [self dismissAlertView];
           }];
           [self addGestureRecognizer:tap];
           self.frame = [UIScreen mainScreen].bounds;
          self.alertView=[[UIView alloc]init];
                 self.alertView.frame = CGRectMake((SCREEN_WIDTH-268*KScaleW)/2,(SCREEN_HEIGHT-238.5*KScaleH)/2, 268*KScaleW, 238.5*KScaleH);
                 [self.alertView setRadius:5*KScaleW];
                 self.alertView.backgroundColor = [UIColor whiteColor];
                 [self addSubview:self.alertView];
        
        UIImageView    *  image=[[UIImageView alloc]initWithImage:imageName];
        image.frame=CGRectMake((self.alertView.width-75*KScaleW)/2, 46*KScaleH, 75*KScaleW, 75*KScaleW);
        image.contentMode=UIViewContentModeScaleAspectFill;
        image.clipsToBounds=YES;
        [self.alertView addSubview:image];
        
        UILabel  *  labelOne=[[UILabel alloc]initWithFrame:CGRectMake(0, image.bottom+22*KScaleH, self.alertView.width, 13*KScaleH)];
        labelOne.textColor=[UIColor colorWithHexString:@"#0B2137"];
        labelOne.textAlignment=NSTextAlignmentCenter;
        labelOne.font=APP_NORMAL_FONT(14.0);
        labelOne.text=textOne;
        [self.alertView addSubview:labelOne];
        
        UILabel  *  labelTwo=[[UILabel alloc]initWithFrame:CGRectMake(0, labelOne.bottom+23*KScaleH, self.alertView.width, 13*KScaleH)];
               labelTwo.textColor=[UIColor colorWithHexString:@"#0B2137"];
               labelTwo.textAlignment=NSTextAlignmentCenter;
               labelTwo.font=APP_NORMAL_FONT(14.0);
               labelTwo.text=textTwo;
               [self.alertView addSubview:labelTwo];
        
        
        
         
       }
       return self;
}

- (void)showView {
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissAlertView {
    [UIView animateWithDuration:.2 animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.08
                         animations:^{
                             self.alertView.transform = CGAffineTransformMakeScale(0.25, 0.25);
                         }completion:^(BOOL finish){
                             [self removeFromSuperview];
                         }];
    }];
}
@end
