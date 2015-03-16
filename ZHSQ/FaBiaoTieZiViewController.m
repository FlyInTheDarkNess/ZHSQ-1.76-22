//
//  FaBiaoTieZiViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-1.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "FaBiaoTieZiViewController.h"
#import "SheQuHuDongViewController.h"
#import "AppDelegate.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "Customer.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "CheckNetwork.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "FaTie.h"
#import "UIWindow+YzdHUD.h"

#define kAnimationDuration 0.2
#define kViewHeight 56
extern NSString *xiaoquIDString;

@interface FaBiaoTieZiViewController ()

@end

@implementation FaBiaoTieZiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    textview.font = [UIFont systemFontOfSize:16];
    textview.scrollEnabled = NO;
    textview.layer.cornerRadius =4;
    textview.layer.masksToBounds = YES;
       //边框宽度及颜色设置
    [textview.layer setBorderWidth:1];
    [textview.layer setBorderColor:[[UIColor grayColor] CGColor]];  //设置边框为蓝色
    [textview becomeFirstResponder];
    textview.keyboardType =UIKeyboardTypeDefault;
    textview.returnKeyType=UIReturnKeyDefault;
    [self->textview.layer setCornerRadius:10];
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * button1 =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    [textview setInputAccessoryView:topView];
    filePath=@"";
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yourHandlingCode:)];  
    [imageview addGestureRecognizer:singleTap];

}
- (void)resignKeyboard
{
    [textview resignFirstResponder];
}

-(void)keyboardDidShow:(NSNotification *)notification { //获取键盘高度
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]; CGRect keyboardRect; [keyboardObject getValue:&keyboardRect]; //调整放置有textView的view的位置
    //设置动画
    [UIView beginAnimations:nil context:nil]; //定义动画时间
    [UIView setAnimationDuration:kAnimationDuration];
    //设置view的frame，往上平移
    [(UIView *)[self.view viewWithTag:1000] setFrame:CGRectMake(0, self.view.frame.size.height-keyboardRect.size.height-kViewHeight, 320, kViewHeight)];
    [UIView commitAnimations];
}
-(void)keyboardDidHidden { //定义动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration];
    //设置view的frame，往下平移
    [(UIView *)[self.view viewWithTag:1000] setFrame:CGRectMake(0, self.view.frame.size.height-kViewHeight, 320, kViewHeight)];
    [UIView commitAnimations];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)yourHandlingCode:(id)sender
{
    actSheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择照片", nil];
    actSheet.delegate=self;
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [actSheet showInView:app.window];
}

- (IBAction)fanhui:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    
    if (buttonIndex == myActionSheet.cancelButtonIndex)
        
    {
        
    }
    
    switch (buttonIndex)
    
    {
        case 0:  //打开照相机拍照
            
            [self takePhoto];
            
            break;
            
        case 1:  //打开本地相册
            
            [self LocalPhoto];
            
            break;
            
    }
    
}
-(void)takePhoto

{
    
    //判断是否可以打开相机，模拟器此功能无法使用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;  //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //[self presentModalViewController:picker animated:YES];
        [self presentViewController:picker animated:NO completion:nil];
    }
    else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
    }
    
}
//打开本地相册

-(void)LocalPhoto

{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    //设置选择后的图片可被编辑
    
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:NO completion:nil];
}

//当选择一张图片后进入这里

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    @try
    {
        
        
        NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
        //当选择的类型是图片
        
        if ([type isEqualToString:@"public.image"])
            
        {
            
            //先把图片转成NSData
            
            UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            
            NSData *data;
            
            if (UIImagePNGRepresentation(image) == nil)
                
            {
                data = UIImageJPEGRepresentation(image, 1.0);
            }
            
            else
                
            {
                data = UIImagePNGRepresentation(image);
            }
            
            //图片保存的路径
            date_image=data;
            //这里将图片放在沙盒的documents文件夹中
            
            NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            
            //文件管理器
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
            
            [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
            //得到选择后沙盒中图片的完整路径
            
            filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
            //关闭相册界面
            
            //[picker dismissModalViewControllerAnimated:YES];
            [picker dismissViewControllerAnimated:YES completion:nil];
           // UIImageView *imageTianjia=[[UIImageView alloc]initWithFrame:CGRectMake(12, 360, 30, 50)];
            
            imageview.image=image;
            //[self.view addSubview:imageTianjia];
            
        }
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



- (IBAction)fabu:(id)sender
{
    if ([textfield.text isEqualToString:@""])
    {
        [self showWithCustomView:@"帖子标题还没写呢"];
    }
    else if ([textview.text isEqualToString:@""])
    {
        [self showWithCustomView:@"帖子内容还没写呢"];
    }
    else
    {
    @try
    {
        [self.view.window showHUDWithText:@"提交中" Type:ShowLoading Enabled:YES];
        
        FaTie *customer =[[FaTie alloc]init];
        customer.city_id=@"101";
        customer.quarter_id=xiaoquIDString;
        customer.session=Session;
        customer.community_id=@"102";
        customer.module_id=@"";
        customer.title=textfield.text;
        customer.content=textview.text;
        customer.ip=@"192.168.1.104";
        NSString *str11 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str11];
        NSURL *url = [NSURL URLWithString:SheQuHuDong_m10_07];
        ASIFormDataRequest *aRequest = [[ASIFormDataRequest alloc] initWithURL:url];
        [aRequest setDelegate:self];//代理
        [aRequest setPostValue:str_jiami forKey:@"para"];
        [aRequest setRequestMethod:@"POST"];
        [aRequest addData:date_image withFileName:@"test.png" andContentType:@"image/png" forKey:nil];
        //forKey:@"file"
        [aRequest addRequestHeader:@"Content-Type" value:@"binary/octet-stream"];//这里的value值 需与服务器端 一致
        [aRequest startAsynchronous];//开始。异步
        [aRequest setDidFinishSelector:@selector(requestDidSuccess:)];//当成功后会自动触发 headPortraitSuccess 方法
        [aRequest setDidFailSelector:@selector(responseFailed:)];//如果失败会 自动触发 headPortraitFail 方法
        
        
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
}
-(void)requestDidSuccess:(NSString *)result
{
       [self.view.window showHUDWithText:@"提交成功" Type:ShowPhotoYes Enabled:YES];
    
    SheQuHuDongViewController *hudong=[[SheQuHuDongViewController alloc]init];
    [self presentViewController:hudong animated:NO completion:nil];
    
}
-(void)responseFailed:(NSString *)result
{
    [self.view.window showHUDWithText:@"提交失败" Type:ShowPhotoNo Enabled:YES];
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

@end
