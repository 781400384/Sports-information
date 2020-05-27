//
//  PersonInfoViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/12.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "InfoEditViewController.h"
#import "CXDatePickerView.h"
#import "LCActionAlertView.h"
#import "LoginHandle.h"
#import "PersonalHandle.h"
@interface PersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>{
    UIImageView    *   headImage;
}
@property (nonatomic, copy)   NSArray               *            dataList;
@property (nonatomic, strong) UITableView           *            tableView;
@property (nonatomic, strong) NSMutableArray        *            contentList;
@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"资料编辑";
    self.dataList=@[@"",@"资料设置",@"昵称",@"出生日期"];
    [self getUser];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return 4;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"userCenterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
  
    cell.textLabel.text = self.dataList[indexPath.row];
    cell.detailTextLabel.font=APP_NORMAL_FONT(11.0);
    cell.detailTextLabel.textColor=[UIColor colorWithHexString:@"#63717E"];
    cell.imageView.image=[UIImage imageNamed:@"p_left"];
        if (indexPath.row==2||indexPath.row==3) {
           
            cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"p_next"]];
            cell.textLabel.textColor=[UIColor colorWithHexString:@"#0B2137"];
            cell.textLabel.font=APP_NORMAL_FONT(12.0);
        }
        if (indexPath.row==1) {
           
             cell.textLabel.textColor=[UIColor colorWithHexString:@"#0B2137"];
             cell.textLabel.font=APP_BOLD_FONT(12.0);
        }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.text=self.contentList[indexPath.row];
    
    UIView  *   lineView=[[UIView alloc]init];
    if (indexPath.row==0) {
       headImage=[[UIImageView alloc]initWithFrame:CGRectMake(35.5*KScaleW, 35*KScaleH, 44*KScaleH, 44*KScaleH)];
               [headImage setRadius:22*KScaleH];
               headImage.clipsToBounds=YES;
               headImage.contentMode=UIViewContentModeScaleAspectFill;
               [cell addSubview:headImage];
         [headImage sd_setImageWithURL:[NSURL URLWithString:[UserInfoDefaults userInfo].avatar] placeholderImage:[UIImage imageNamed:@"p_normal_avatar"]];
         cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"p_left"]];
        lineView.frame=CGRectMake(13*KScaleW,22*KScaleH, SCREEN_WIDTH-26*KScaleW, 70*KScaleH);
    }else{
          lineView.frame=CGRectMake(13*KScaleW, 0, SCREEN_WIDTH-26*KScaleW, 54*KScaleH);
    }
    lineView.backgroundColor=[UIColor clearColor];
    lineView.layer.borderWidth=0.5*KScaleW;
    [lineView setRadius:5*KScaleW];
    lineView.layer.borderColor=[UIColor colorWithHexString:@"#EFEFF0"].CGColor;
    [cell addSubview:lineView];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
      return   114*KScaleH;
    }else{
        return 65*KScaleH;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
   
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
               imagePickerController.delegate = self;
               imagePickerController.allowsEditing = YES;
               [LCActionAlertView showActionViewNames:@[@"照相机",@"本地相册"] completed:^(NSInteger index,NSString * name) {
                   if (index==0) {
                       imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                       [self presentViewController:imagePickerController animated:YES completion:nil];
                   }else{
                       imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                       [self presentViewController:imagePickerController animated:YES completion:nil];
                   }
               } canceled:^{

               }];
    }
        if (indexPath.row==2) {
            InfoEditViewController   *  vc=[[InfoEditViewController alloc]init];
            vc.rreturnValueBlock = ^(NSString * _Nonnull data) {
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:data];
                
                [self editUserInfoWithNickName:data birthday:[UserInfoDefaults userInfo].birthday];
                
                
            };
            [self.navigationController pushViewController:vc animated:NO];
        }
        if (indexPath.row==3) {
            CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                           NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                 [self.contentList replaceObjectAtIndex:indexPath.row withObject:dateString];
                 [self editUserInfoWithNickName:[UserInfoDefaults userInfo].birthday birthday:dateString];
                      }];
                      datepicker.dateLabelColor = [UIColor colorWithHexString:@"#3f3166"];//年-月-日-时-分 颜色
                      datepicker.datePickerColor = [UIColor colorWithHexString:@"#444444"];//滚轮日期颜色
                      datepicker.doneButtonColor = [UIColor colorWithHexString:@"#29675f "];//确定按钮的颜色
                      datepicker.cancelButtonColor = [UIColor colorWithHexString:@"#f1c0c0"];
                      datepicker.yearLabelColor=[UIColor colorWithHexString:@"#ebebeb"];
                   [datepicker show];
        }
  
}


#pragma mark - lazy

- (UITableView *)tableView{
    
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.naviView.bottom) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor=[UIColor whiteColor];
        tableView.separatorColor = [UIColor clearColor];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
-(NSMutableArray *)contentList{
    if (!_contentList) {
        _contentList=[NSMutableArray arrayWithArray:@[@"更换头像",@"",[UserInfoDefaults userInfo].nickname==nil?@"未填写":[UserInfoDefaults userInfo].nickname,[UserInfoDefaults userInfo].birthday==nil?@"未填写":[UserInfoDefaults userInfo].birthday]];
    }
    return _contentList;
}
#pragma mark - 上传头像
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];    
    NSData *imgData = UIImageJPEGRepresentation([self fixOrientation:image], 0.5);
    UIImage *rightImage = [UIImage imageWithData:imgData];
    [headImage setImage:rightImage];
    [LoginHandle uploadAvatarWithToken:[UserInfoDefaults userInfo].token image:rightImage success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
            UserInfoModel   *  model=[UserInfoDefaults userInfo];
            model.avatar=dic[@"data"][@"avatar"];
            [UserInfoDefaults saveUserInfo:model];

        }
    } failed:^(id  _Nonnull obj) {
        
    }];
    
}


-(UIImage *)fixOrientation:(UIImage *)aImage {
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
-(void)editUserInfoWithNickName:(NSString * )nickName birthday:(NSString *)birthday{
    [PersonalHandle editUserInfoWithNickName:nickName birthday:birthday Success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"返回%@",dic);
        [self.view toast:dic[@"msg"]];
        if ([dic[@"code"] intValue]==1) {
            [self.view toast:@"修改成功"];
            [self getUser];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)getUser{
    [PersonalHandle getUserInfoWithToken:[UserInfoDefaults userInfo].token Success:^(id  _Nonnull obj) {
           NSDictionary * dic=(NSDictionary *)obj;
           if ([dic[@"code"] intValue]==1) {
            UserInfoModel  *  model=[UserInfoDefaults userInfo];
            model.avatar=dic[@"data"][@"avatar"];
            model.birthday=dic[@"data"][@"birthday"];
            model.nickname=dic[@"data"][@"nickname"];
            [UserInfoDefaults  saveUserInfo:model];
            [self.tableView reloadData];
           }
       } failed:^(id  _Nonnull obj) {
           
       }];
}
@end
