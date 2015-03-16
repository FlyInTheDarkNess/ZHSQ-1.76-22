//
//  GeRenXinXiWanShanViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-9-22.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "GeRenXinXiWanShanViewController.h"
#import "GeRenXinXi.h"
#import "MJRefresh.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UIImageView+WebCache.h"

//头像截取picker
//********
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#define ORIGINAL_MAX_WIDTH 640.0f
//*********
#import "Toast+UIView.h"

extern NSString *Session;
extern NSString *UserName;
extern NSString *Name;
extern NSString *Card_id;
extern NSString *email;
extern NSString *icon_path;
extern NSString *string_Account;

/*
 添加新的picerView，添加协议
 */


@interface GeRenXinXiWanShanViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>

@end

@implementation GeRenXinXiWanShanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    @try
    {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    //CGFloat Hidth=size.height;//Hidth 屏幕高度
    
        /*
         头像背景
         */
        //*************
        UIImageView * backGroundImV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, 320, 120)];
        backGroundImV.image = [UIImage imageNamed:@"p050_我_背景.png"];
        [self.view addSubview:backGroundImV];
        //*************
        
        self.view.backgroundColor=[UIColor whiteColor];
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label.text=@"个人信息完善";
    label.textColor=[UIColor whiteColor];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [self.view addSubview:fanhui];
    
    wancheng=[[UIButton alloc]initWithFrame:CGRectMake(250, 20, 60, 40)];
    [wancheng addTarget:self action:@selector(wancheng) forControlEvents:UIControlEventTouchUpInside];
    [wancheng setTitle:@"完成" forState:UIControlStateNormal];
    [wancheng setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    wancheng.titleLabel.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:wancheng];
        
        
        /*
         头像设置
         */
        //***************
        imageview= [[UIImageView alloc]initWithFrame:CGRectMake(20, 70, 80, 80)];
        imageview.layer.cornerRadius = 40;
        imageview.layer.masksToBounds = YES;
        imageview.layer.borderColor = [UIColor redColor].CGColor;
        imageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
        [imageview addGestureRecognizer:singleTap];
        imageview.layer.borderWidth = 1;
    
        if (icon_path.length>0)
        {
            [imageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",icon_path]] placeholderImage:[UIImage imageNamed:@"touxiang1"] options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [self.view addSubview:imageview];

        }
        else
        {
            imageview.image=[UIImage imageNamed:@"m_personcenter.png"];
            
            [self.view addSubview:imageview];
        }
        UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageview.left - 10, imageview.bottom, 100, 20)];
        headerLabel.text = @"点击更换头像";
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.font = [UIFont systemFontOfSize:14];
        headerLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:headerLabel];
        //*****************
        
        /*
         更换手机号
         */
        //*******************
        UILabel * mobileNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake( imageview.right + 10, imageview.top + 20, 150, 20)];
        mobileNumberLabel.text = string_Account;
        mobileNumberLabel.textColor = [UIColor whiteColor];
        
        UIButton *changeNumberBtn = [[UIButton alloc]initWithFrame:CGRectMake(mobileNumberLabel.left, mobileNumberLabel.bottom +10, 100, 25)];
        [changeNumberBtn setTitle:@"更换绑定手机" forState:UIControlStateNormal];
        changeNumberBtn.layer.cornerRadius = 10.0f;
        changeNumberBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [changeNumberBtn setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:mobileNumberLabel];
        [self.view addSubview:changeNumberBtn];
        //*******************
    
    
//    hengxian=[[UILabel alloc]initWithFrame:CGRectMake(10, 140, 300, 1)];
//    hengxian.backgroundColor=[UIColor grayColor];
//    [self.view addSubview:hengxian];
    
    beijing=[[UILabel alloc]initWithFrame:CGRectMake(20, 200, 280, 120)];
    beijing.layer.masksToBounds=YES;
    beijing.layer.cornerRadius=7;
    beijing.layer.borderWidth=0.5;
    beijing.layer.borderColor=[[UIColor grayColor] CGColor];
    [self.view addSubview:beijing];
    
    label_xingming=[[UILabel alloc]initWithFrame:CGRectMake(20, 200, 40, 30)];
    label_xingming.text=@"姓名:";
    label_xingming.textAlignment=NSTextAlignmentCenter;
    label_xingming.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label_xingming];
    xingming_textfield=[[UITextField alloc]initWithFrame:CGRectMake(60, 200, 240, 30)];
    xingming_textfield.delegate=self;
    xingming_textfield.placeholder=@"您的姓名(必填)";
    xingming_textfield.text=Name;
    xingming_textfield.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:xingming_textfield];
    huixian1=[[UILabel alloc]initWithFrame:CGRectMake(25, 231, 270, 1)];
    huixian1.backgroundColor=[UIColor grayColor];
    [self.view addSubview:huixian1];
    
    nicheng=[[UILabel alloc]initWithFrame:CGRectMake(20, 231, 40, 30)];
    nicheng.text=@"昵称:";
    nicheng.textAlignment=NSTextAlignmentCenter;
    nicheng.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:nicheng];
    nicheng_textfield=[[UITextField alloc]initWithFrame:CGRectMake(60, 231, 240, 30)];
    nicheng_textfield.delegate=self;
    nicheng_textfield.text=UserName;
    nicheng_textfield.placeholder=@"昵称";
    nicheng_textfield.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:nicheng_textfield];

    huixian2=[[UILabel alloc]initWithFrame:CGRectMake(25, 260, 270, 1)];
    huixian2.backgroundColor=[UIColor grayColor];
    [self.view addSubview:huixian2];
    
    shenfenzheng=[[UILabel alloc]initWithFrame:CGRectMake(20, 260, 80, 30)];
    shenfenzheng.text=@"身份证号码:";
    shenfenzheng.textAlignment=NSTextAlignmentCenter;
    shenfenzheng.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:shenfenzheng];
    shenfenzheng_textfield=[[UITextField alloc]initWithFrame:CGRectMake(100, 260, 180, 30)];
    shenfenzheng_textfield.delegate=self;
    shenfenzheng_textfield.text=Card_id;
    shenfenzheng_textfield.placeholder=@"身份证号码";
    shenfenzheng_textfield.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:shenfenzheng_textfield];

    
    huixian3=[[UILabel alloc]initWithFrame:CGRectMake(25, 290, 270, 1)];
    huixian3.backgroundColor=[UIColor grayColor];
    [self.view addSubview:huixian3];
    youxiang=[[UILabel alloc]initWithFrame:CGRectMake(20, 290, 40, 30)];
    youxiang.text=@"邮箱:";
    youxiang.textAlignment=NSTextAlignmentCenter;
    youxiang.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:youxiang];
    youxiang_textfield=[[UITextField alloc]initWithFrame:CGRectMake(60, 290, 240, 30)];
    youxiang_textfield.delegate=self;
    youxiang_textfield.placeholder=@"邮箱";
    youxiang_textfield.text=email;
    youxiang_textfield.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:youxiang_textfield];
}
@catch (NSException * e) {
    NSLog(@"Exception: %@", e);
    UIAlertView * alert =
    [[UIAlertView alloc]
     initWithTitle:@"错误"
     message: [[NSString alloc] initWithFormat:@"%@",e]
     delegate:self
     cancelButtonTitle:nil
     otherButtonTitles:@"OK", nil];
    [alert show];
    return;
}

}

-(void)tapImageView
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [actionSheet showInView:self.view];

}

/*
 初版选择头像
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = NO;//设置可编辑
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:NULL];//进入照相界面
        }
            break;
        case 1:{
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = NO;//设置可编辑
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:NULL];//进入照相界面
                    }
            break;
        default:
            break;
    }
}
 



//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    UIImage *image;
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData *data;
    data = UIImageJPEGRepresentation(image, 0.3);
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/ZXHeadImage.png"] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    NSString *imagePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,@"/ZXHeadImage.png"];
    iconPath=imagePath;
    //imageview.image =[UIImage imageNamed:imagePath];
    [imageview setImage:[UIImage imageWithContentsOfFile:imagePath]];
   // [picBtn setImage:image forState:UIControlStateNormal];
    //关闭相册界面
    [self dismissViewControllerAnimated:NO completion:^{//备注2
    }];
    
}
  */

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    //NSLog(@" 偏差 %d",offset);
    if(offset > 0)
        self.view.frame = CGRectMake(20, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}
//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [xingming_textfield resignFirstResponder];
    [nicheng_textfield resignFirstResponder];
    [shenfenzheng_textfield resignFirstResponder];
    [youxiang_textfield resignFirstResponder];
    
    return YES;
    
}
-(void)wancheng
{
    @try
    {

    GeRenXinXi*customer =[[GeRenXinXi alloc]init];
    customer.session=Session;
    customer.name=xingming_textfield.text;
    customer.nickname=nicheng_textfield.text;
    customer.card_id=shenfenzheng_textfield.text;
    customer.email=youxiang_textfield.text;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
        
        
        
        
        
        NSString *str=GeRenXinXiWanShan_m1_08;
        NSString *canshu=str_jiami;
        //UIImage *image=[UIImage imageNamed:iconPath];
        UIImage *image=[UIImage imageWithContentsOfFile:iconPath];

        NSData *data = UIImagePNGRepresentation(image);
        NSURL *url = [NSURL URLWithString:str];
        ASIFormDataRequest *aRequest = [[ASIFormDataRequest alloc] initWithURL:url];
        [aRequest setDelegate:self];//代理
        [aRequest setPostValue:canshu forKey:@"para"];
        [aRequest setRequestMethod:@"POST"];
        [aRequest addData:data withFileName:@"test.png" andContentType:@"image/png" forKey:nil];
        //forKey:@"file"
        [aRequest addRequestHeader:@"Content-Type" value:@"binary/octet-stream"];//这里的value值 需与服务器端 一致
        [aRequest startAsynchronous];//开始。异步
        [aRequest setDidFinishSelector:@selector(requestDidSuccess:)];//当成功后会自动触发 headPortraitSuccess 方法
        [aRequest setDidFailSelector:@selector(responseFailed:)];//如果失败会 自动触发 headPortraitFail 方法

//    [HttpPostExecutor postExecuteWithUrlStr:GeRenXinXiWanShan_m1_08 Paramters:Str FinishCallbackBlock:^(NSString *result)
//     {
//         // 执行post请求完成后的逻辑
//        // NSLog(@"第二次:sssssssssss++++ %@", result);
//         if (result.length<=0)
//         {
//             UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//             [aler show];
//         }
//         else
//         {
//
//         NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
//         SBJsonParser *parser = [[SBJsonParser alloc] init];
//         NSError *error = nil;
//         NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
//         NSString *a=[rootDic objectForKey:@"ecode"];
//         int intb = [a intValue];
//        
//         if (intb==1000)
//         {
//             [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(jieguo) userInfo:nil repeats:NO];
//             [self showWithCustomView:@"完善成功"];
//             
//             UserName=nicheng_textfield.text;
//             Name=xingming_textfield.text;
//             Card_id=shenfenzheng_textfield.text;
//             email=youxiang_textfield.text;
//
//             
//         }
//         }
//     }];
}
@catch (NSException * e) {
    NSLog(@"Exception: %@", e);
    UIAlertView * alert =
    [[UIAlertView alloc]
     initWithTitle:@"错误"
     message: [[NSString alloc] initWithFormat:@"%@",e]
     delegate:self
     cancelButtonTitle:nil
     otherButtonTitles:@"OK", nil];
    [alert show];
    return;
}
}
-(void)requestDidSuccess:(ASIHTTPRequest *)result
{
    NSLog(@"上传成功%@",result);
    UserName=nicheng_textfield.text;
    Name=xingming_textfield.text;
    Card_id=shenfenzheng_textfield.text;
    email=youxiang_textfield.text;
    [self showWithCustomView:@"完善成功"];

}
-(void)responseFailed:(ASIHTTPRequest *)result
{
    NSLog(@"上传失败%@",result);
}

-(void)jieguo
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)showWithCustomView:(NSString*)aString {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}

-(void)fanhui
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//IOS 6.0 以上禁止横屏
- (BOOL)shouldAutorotate
{
    return NO;
}
//IOS 6.0 以下禁止横屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}








/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/*
 修改人 赵忠良
 修改时间 15.3.13
 修改原因 解决图片变形的问题
 */

#pragma mark VPImageCropperDelegate
//截取完毕调用的方法
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    imageview.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
        
        NSData *data;
        data = UIImageJPEGRepresentation(editedImage, 0.3);
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/ZXHeadImage.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        NSString *imagePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,@"/ZXHeadImage.png"];
        iconPath=imagePath;
        //imageview.image =[UIImage imageNamed:imagePath];
        [imageview setImage:[UIImage imageWithContentsOfFile:imagePath]];
        // [picBtn setImage:image forState:UIControlStateNormal];
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
            NSLog(@"裁剪");
        }];
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
        NSLog(@"");
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

/*
#pragma mark portraitImageView getter
- (UIImageView *)portraitImageView {
    if (!imageview) {
        CGFloat w = 100.0f; CGFloat h = w;
        CGFloat x = (self.view.frame.size.width - w) / 2;
        CGFloat y = (self.view.frame.size.height - h) / 2;
        imageview = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [imageview.layer setCornerRadius:(imageview.frame.size.height/2)];
        [imageview.layer setMasksToBounds:YES];
        [imageview setContentMode:UIViewContentModeScaleAspectFill];
        [imageview setClipsToBounds:YES];
        imageview.layer.shadowColor = [UIColor blackColor].CGColor;
        imageview.layer.shadowOffset = CGSizeMake(4, 4);
        imageview.layer.shadowOpacity = 0.5;
        imageview.layer.shadowRadius = 2.0;
        imageview.layer.borderColor = [[UIColor blackColor] CGColor];
        imageview.layer.borderWidth = 2.0f;
        imageview.userInteractionEnabled = YES;
        imageview.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [imageview addGestureRecognizer:portraitTap];
    }
    return imageview;
}
 */









@end
