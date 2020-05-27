//
//  InfoEditViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "InfoEditViewController.h"

@interface InfoEditViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField   *    tf;
@property (nonatomic, strong) UILabel       *    notiLabel;
@property (nonatomic, strong) UILabel       *    numLabel;
@end

@implementation InfoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"编辑昵称";
    self.naviView.rightTitleLabel.text=@"确定";
    self.naviView.rightTitleLabel.font=APP_BOLD_FONT(12.0);
    self.naviView.rightTitleLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
    [self setupUI];
}

-(void)rightTitleLabelTap{
    if ([self.tf.text isEmpty]) {
        self.notiLabel.hidden=NO;
        return;
    }
    if (self.rreturnValueBlock) {
        self.rreturnValueBlock(self.tf.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setupUI{
      UITextField  *  tf=[[UITextField alloc]initWithFrame:CGRectMake(13*KScaleW,self.naviView.bottom+25*KScaleH, SCREEN_WIDTH-24*KScaleW, 40*KScaleH)];
          tf.backgroundColor=[UIColor whiteColor];
          tf.layer.borderColor=[UIColor colorWithHexString:@"#EFEFF0"].CGColor;
          tf.layer.borderWidth=0.5*KScaleW;
          tf.delegate=self;
          [tf setRadius:5*KScaleW];
          [self.view addSubview:tf];
          tf.placeholder=@"请设置你的昵称";
    UIView  *  leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 23*KScaleW, 40*KScaleH)];
    leftView.backgroundColor=[UIColor whiteColor];
    tf.leftView=leftView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    self.tf=tf;
    
    self.notiLabel=[[UILabel alloc]initWithFrame:CGRectMake(13*KScaleW, tf.bottom+11*KScaleH, tf.width/2, 11*KScaleH)];
    self.notiLabel.textColor=[UIColor colorWithHexString:@"#CDD3D9"];
    self.notiLabel.font=APP_NORMAL_FONT(11.0);
    self.notiLabel.text=@"输入你的昵称，昵称不能为空";
    self.notiLabel.textAlignment=NSTextAlignmentLeft;
    self.notiLabel.hidden=YES;
    [self.view addSubview:self.notiLabel];
    
    self.numLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.notiLabel.right, tf.bottom+29*KScaleH, tf.width/2, 11*KScaleH)];
       self.numLabel.textColor=[UIColor colorWithHexString:@"#CDD3D9"];
       self.numLabel.font=APP_NORMAL_FONT(11.0);
       self.numLabel.text=@"00/15";
       self.numLabel.textAlignment=NSTextAlignmentRight;
       [self.view addSubview:self.numLabel];
    
}
-(void)textViewDidChange:(UITextView *)textView{
    
    NSString *lang = textView.textInputMode.primaryLanguage;//键盘输入模式
    static NSInteger length = 0;
    if ([lang isEqualToString:@"zh-Hans"]){
        UITextRange *selectedRange = [textView markedTextRange];
        if (!selectedRange) {//没有有高亮
            length = textView.text.length;
        }else{
            
        }
    }else{
        length = textView.text.length;
    }
    
      self.numLabel.text=[NSString stringWithFormat:@"%ld/15",15-(long)length];
    if (length > 15 ) {
        [self.view toast:@"最多输入15个字"];
    }
}

@end
