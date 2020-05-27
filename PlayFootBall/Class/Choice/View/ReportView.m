//
//  ReportView.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/20.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "ReportView.h"
@interface ReportView()

@property (nonatomic, strong) UIView   *   alertView;
@property (nonatomic, strong) UIButton *   nor;
@property (nonatomic,strong) UIButton *repulse_cancel_button;//取消
@property (nonatomic,strong) UIButton *repulse_makeSure_button;//打回
@end
@implementation ReportView
-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.alertView=[[UIView alloc]init];
        self.alertView.frame = CGRectMake(45.5*KScaleW,(SCREEN_HEIGHT-183*KScaleH)/2, SCREEN_WIDTH-91*KScaleW, 183*KScaleH);
        [self.alertView setRadius:5*KScaleW];
        self.alertView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.alertView];
        
        NSArray  *  array=@[@"低俗色情",@"内容不实",@"涉嫌违法",@"其他问题"];
        for (int i=0; i<array.count; i++) {
            UIButton  *  btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(21*KScaleW+(i%2)*132*KScaleW, 19*KScaleH+(i/2)*43*KScaleH, 110*KScaleW, 32*KScaleH);
            [btn setTitle:array[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"#63717E"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"#21C648"] forState:UIControlStateSelected];
            btn.tag=100+i;
            btn.titleLabel.font=APP_NORMAL_FONT(12.0);
            btn.layer.borderWidth=0.5*KScaleW;
            [btn setRadius:5.0*KScaleW];
            btn.layer.borderColor=[UIColor colorWithHexString:@"#63717E"].CGColor;
            btn.backgroundColor=[UIColor whiteColor];
            [self.alertView addSubview:btn];
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            if (i==2) {
                self.nor=btn;
            }
        }
        UILabel   *  notice=[[UILabel alloc]initWithFrame:CGRectMake(0, self.nor.bottom+14*KScaleH, self.alertView.width, 11*KScaleH)];
        notice.textAlignment=NSTextAlignmentCenter;
        notice.font=APP_NORMAL_FONT(11.0);
        notice.textColor=[UIColor colorWithHexString:@"#CDD3D9"];
        notice.text=@"我们将在12小时内，处理您举报的问题";
        [self.alertView addSubview:notice];
        //取消
        self.repulse_cancel_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.alertView addSubview:self.repulse_cancel_button];
        self.repulse_cancel_button.layer.borderWidth=0.5*KScaleW;
        self.repulse_cancel_button.layer.borderColor=[UIColor colorWithHexString:@"#EFEFF0"].CGColor;
        [self.repulse_cancel_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(49*KScaleH);
            make.width.mas_equalTo(142*KScaleW);
            
            
        }];
        self.repulse_cancel_button.backgroundColor = [UIColor whiteColor];
        [self.repulse_cancel_button setTitle:@"关闭" forState:UIControlStateNormal];
        [self.repulse_cancel_button setTitleColor:[UIColor colorWithHexString:@"#63717E"] forState:UIControlStateNormal];
        self.repulse_cancel_button.titleLabel.font = APP_NORMAL_FONT(12);
        [self.repulse_cancel_button addTarget:self action:@selector(evaluate_cancel_buttonAction) forControlEvents:UIControlEventTouchUpInside];
        //确定
        self.repulse_makeSure_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.alertView addSubview:self.repulse_makeSure_button];
        self.repulse_makeSure_button.layer.borderWidth=0.5*KScaleW;
           self.repulse_makeSure_button.layer.borderColor=[UIColor colorWithHexString:@"#EFEFF0"].CGColor;
        [self.repulse_makeSure_button mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.left.mas_equalTo(0);
           make.height.mas_equalTo(49*KScaleH);
           make.width.mas_equalTo(142*KScaleW);
        }];
        self.repulse_makeSure_button.backgroundColor = [UIColor whiteColor];
        [self.repulse_makeSure_button setTitle:@"提交" forState:UIControlStateNormal];
        [self.repulse_makeSure_button setTitleColor:[UIColor colorWithHexString:@"#0B2137"] forState:UIControlStateNormal];
        self.repulse_makeSure_button.titleLabel.font = APP_NORMAL_FONT(12);
        [self.repulse_makeSure_button addTarget:self action:@selector(evaluate_makeSure_buttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    return self;
}
-(void)evaluate_cancel_buttonAction{
    [self dismissAlertView];
     
}
-(void)evaluate_makeSure_buttonAction{
    [self dismissAlertView];
    [self toast:@"提交成功"];
}
-(void)click:(UIButton *)sender{
    for (int i=0; i<4; i++) {
        if (sender.tag==100+i) {
            sender.selected=YES;
            sender.layer.borderColor=[UIColor colorWithHexString:@"#21C648"].CGColor;
           
            continue;
        }
         UIButton  *  btn=(UIButton *)[self viewWithTag:i+100];
        btn.selected=NO;
        btn.layer.borderColor=[UIColor colorWithHexString:@"#63717E"].CGColor;
    }
   
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
