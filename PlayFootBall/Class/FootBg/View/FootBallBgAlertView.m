//
//  FootBallBgAlertView.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "FootBallBgAlertView.h"
#import "SinglePickerView.h"
#import "CXDatePickerView.h"
#import "TimeModel.h"
#import "FootBGHandle.h"
@interface FootBallBgAlertView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView           *   alertView;
@property (nonatomic, strong) UITextField      *   dateTF;
@property (nonatomic, strong) UITextField      *   timeTF;
@property (nonatomic, strong) UITextField      *   phoneTF;
@property (nonatomic, strong) NSMutableArray   *   dataList;
@property (nonatomic, copy)   NSString         *   timeId;
@property (nonatomic, strong) UILabel          *   noticeLabel1;
@property (nonatomic, strong) UILabel          *   noticeLabel2;
@property (nonatomic, strong) UILabel          *   noticeLabel3;
@property (nonatomic, strong) UIImageView      *   noti1;
@property (nonatomic, strong) UIImageView      *   noti2;
@property (nonatomic, strong) UIImageView      *   noti3;

@property (nonatomic, strong) UIView           *   succAlertView;
@end


@implementation FootBallBgAlertView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
//        self.userInteractionEnabled=YES;
//        UITapGestureRecognizer   *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
//            [self dismissAlertView];
//        }];
        UIButton * close=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH- 22*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, 14*KScaleW, 14*KScaleW)];
            [close setBackgroundImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
             [close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:close];
           
//        [self addGestureRecognizer:tap];
        self.frame = [UIScreen mainScreen].bounds;
        self.alertView=[[UIView alloc]init];
        self.alertView.frame = CGRectMake(45.5*KScaleW,(SCREEN_HEIGHT-289*KScaleH)/2, 284*KScaleW, 289*KScaleH);
        [self.alertView setRadius:5*KScaleW];
        self.alertView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.alertView];
        [self loadData];
    }
    return self;
}
-(void)close{
    [self dismissAlertView];
}
-(void)loadData{
    [FootBGHandle getTimeListWithSuccess:^(id  _Nonnull obj) {
        NSDictionary  *  dic=(NSDictionary *)obj;
        NSLog(@"%@",dic);
        if ([dic[@"code"] intValue]==1) {
            self.dataList=[TimeModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self setUpUI];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)setUpUI{
    
    
    UIImageView  *  rightImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_date"]];
    rightImage.frame=CGRectMake(0, 0, 36*KScaleH, 36*KScaleH);
    rightImage.contentMode=UIViewContentModeScaleAspectFit;
    rightImage.clipsToBounds=YES;
    
    for (int i=0; i<3; i++) {
        UILabel   *   label=[[UILabel alloc]initWithFrame:CGRectMake(12*KScaleW, 18*KScaleH+68*KScaleH*i,64*KScaleW, 10.5*KScaleH)];
        label.textAlignment=NSTextAlignmentLeft;
        label.font=APP_NORMAL_FONT(11.0);
        label.textColor=[UIColor colorWithHexString:@"#63717E"];
        label.text=@[@"预约日期",@"预约时间",@"联系电话"][i];
        [self.alertView addSubview:label];
        
        UITextField  *  tf=[[UITextField alloc]initWithFrame:CGRectMake(12*KScaleW, label.bottom+10.5*KScaleH, self.alertView.width-24*KScaleW, 36*KScaleH)];
        tf.backgroundColor=[UIColor whiteColor];
        tf.layer.borderColor=[UIColor colorWithHexString:@"#EFEFF0"].CGColor;
        tf.layer.borderWidth=0.5*KScaleW;
        tf.delegate=self;
        [tf setRadius:5*KScaleW];
        [self.alertView addSubview:tf];
        UIImageView  *  leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"p_left"]];
        NSString  *   array=@[@"请选择预约日期",@"请选择预约时间段",@"请填写联系电话"][i];
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:array];
        [placeholder addAttribute:NSFontAttributeName
                         value:[UIFont boldSystemFontOfSize:11.0]
                         range:NSMakeRange(0, array.length)];
         tf.attributedPlaceholder = placeholder;
        tf.leftView=leftView;
        tf.leftViewMode=UITextFieldViewModeAlways;
         tf.font = APP_BOLD_FONT(11.0);
        UILabel * noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.alertView.width/2-18*KScaleW, 18*KScaleH+68*KScaleH*i,self.alertView.width/2-18*KScaleW, 10.5*KScaleH)];
               noticeLabel.textAlignment=NSTextAlignmentRight;
               noticeLabel.text=@[@"请选择预约日期",@"请选择预约时间段",@"先填写正确的联系方式"][i];
               noticeLabel.textColor=[UIColor colorWithHexString:@"#0b2137"];
               noticeLabel.font=APP_NORMAL_FONT(11.0);
               [self.alertView addSubview:noticeLabel];
        noticeLabel.hidden=YES;
        
               UIImageView   *   notiImg=[[UIImageView alloc]initWithFrame:CGRectMake(noticeLabel.right+0.5*KScaleW,noticeLabel.centerY-3*KScaleW, 6*KScaleW, 6*KScaleW)];
               notiImg.image=[UIImage imageNamed:@"bg_notiImg"];
               notiImg.contentMode=UIViewContentModeScaleAspectFit;
               notiImg.clipsToBounds=YES;
               [self.alertView addSubview:notiImg];
        notiImg.hidden=YES;
        if (i==0) {
            self.dateTF=tf;
            tf.rightView=rightImage;
            tf.rightViewMode = UITextFieldViewModeAlways;
            self.noticeLabel1=noticeLabel;
            self.noti1=notiImg;
        }else if(i==1){
            self.timeTF=tf;
            self.noticeLabel2=noticeLabel;
            self.noti2=notiImg;
        }else{
            self.phoneTF=tf;
            tf.keyboardType=UIKeyboardTypePhonePad;
            tf.clearButtonMode=UITextFieldViewModeWhileEditing;
            self.noticeLabel3=noticeLabel;
                      self.noti3=notiImg;
        }
      
    }
    
    UIButton  *    orderBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.alertView.width-111*KScaleW)/2, self.phoneTF.bottom+22*KScaleH, 111*KScaleW, 33*KScaleH)];
    orderBtn.backgroundColor=[UIColor whiteColor];
    [orderBtn setRadius:5*KScaleW];
    [orderBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    orderBtn.layer.borderWidth=0.5*KScaleW;
    orderBtn.layer.borderColor=[UIColor colorWithHexString:@"#EFEFF0"].CGColor;
    orderBtn.titleLabel.font=APP_NORMAL_FONT(12.0);
    [orderBtn setTitleColor:[UIColor colorWithHexString:@"#0B2137"] forState:UIControlStateNormal];
    [self.alertView addSubview:orderBtn];
    [orderBtn addTarget:self action:@selector(submitOrder) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)submitOrder{
    
    if ([self.dateTF.text isEmpty]) {
        self.noticeLabel1.hidden=NO;
        self.noti1.hidden=NO;
        return;
    }
    if ([self.timeTF.text isEmpty]) {
           self.noticeLabel2.hidden=NO;
           self.noti2.hidden=NO;
           return;
       }
    if (![self.phoneTF.text validPhoneNumber]) {
           self.noticeLabel3.hidden=NO;
           self.noti3.hidden=NO;
           return;
       }
    
    if (self.rreturnValueBlock) {
           self.rreturnValueBlock(self.dateTF.text, self.timeId,self.phoneTF.text);
       }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.dateTF) {
    self.noticeLabel1.hidden=YES;
    self.noti1.hidden=YES;
              
        
        CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            self.dateTF.text=dateString;
           }];
           datepicker.dateLabelColor = [UIColor colorWithHexString:@"#0b2137"];//年-月-日-时-分 颜色
           datepicker.datePickerColor = [UIColor colorWithHexString:@"#444444"];//滚轮日期颜色
           datepicker.doneButtonColor = [UIColor colorWithHexString:@"#20a63f "];//确定按钮的颜色
           datepicker.cancelButtonColor = [UIColor colorWithHexString:@"#cdd3d9"];
           datepicker.yearLabelColor=[UIColor colorWithHexString:@"#ebebeb"];
        [datepicker show];
         return NO;
    }
    if (textField==self.timeTF) {
        self.noticeLabel2.hidden=YES;
        self.noti2.hidden=YES;
      SinglePickerView    *     singleVC2=[[SinglePickerView alloc]initWithComponentDataArray:[self.dataList valueForKey:@"value"] title:@"选择每周起始日"];
        singleVC2.getPickerValue = ^(NSString * _Nullable compoentString, NSInteger i) {
            self.timeTF.text=compoentString;
            self.timeId=[self.dataList[i] valueForKey:@"id"];
        };
        [self addSubview:singleVC2];
        return NO;
    }
    if (textField==self.phoneTF) {
         self.noticeLabel3.hidden=YES;
           self.noti3.hidden=YES;
        return YES;
    }
    return YES;;
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
-(void)showViewWithImage:(UIImage *)imageName textOne:(NSString *)textOne textTwo:(NSString *)textTwo{
    [self.alertView removeFromSuperview];
    self.succAlertView=[[UIView alloc]init];
             self.succAlertView.frame = CGRectMake((SCREEN_WIDTH-268*KScaleW)/2,(SCREEN_HEIGHT-238.5*KScaleH)/2, 268*KScaleW, 238.5*KScaleH);
             [self.succAlertView setRadius:5*KScaleW];
             self.succAlertView.backgroundColor = [UIColor whiteColor];
             [self addSubview:self.succAlertView];
    
    UIImageView    *  image=[[UIImageView alloc]initWithImage:imageName];
    image.frame=CGRectMake((self.succAlertView.width-75*KScaleW)/2, 46*KScaleH, 75*KScaleW, 75*KScaleW);
    image.contentMode=UIViewContentModeScaleAspectFill;
    image.clipsToBounds=YES;
    [self.succAlertView addSubview:image];
    
    UILabel  *  labelOne=[[UILabel alloc]initWithFrame:CGRectMake(0, image.bottom+22*KScaleH, self.succAlertView.width, 13*KScaleH)];
    labelOne.textColor=[UIColor colorWithHexString:@"#0B2137"];
    labelOne.textAlignment=NSTextAlignmentCenter;
    labelOne.font=APP_NORMAL_FONT(14.0);
    labelOne.text=textOne;
    [self.succAlertView addSubview:labelOne];
    
    UILabel  *  labelTwo=[[UILabel alloc]initWithFrame:CGRectMake(0, labelOne.bottom+23*KScaleH, self.succAlertView.width, 13*KScaleH)];
           labelTwo.textColor=[UIColor colorWithHexString:@"#0B2137"];
           labelTwo.textAlignment=NSTextAlignmentCenter;
           labelTwo.font=APP_NORMAL_FONT(14.0);
           labelTwo.text=textTwo;
           [self.succAlertView addSubview:labelTwo];
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
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}
@end
