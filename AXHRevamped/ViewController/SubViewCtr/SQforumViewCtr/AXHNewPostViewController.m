//
//  AXHNewPostViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/26.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHNewPostViewController.h"
#import "WUDemoKeyboardBuilder.h"


@interface AXHNewPostViewController (){
    
    __weak IBOutlet UIButton *picBtn;
    __weak IBOutlet UITextField *titleText;
    __weak IBOutlet UITextView *contentTextView;
    __weak IBOutlet UILabel *prolable;
    NSMutableArray *importItems;
    
    __weak IBOutlet UILabel *placeLable;
    __weak IBOutlet UIView *statueView;
    
    BOOL isTextView;
    
    //请求
    SQForumHttpService  *sqNewsPostHttpSer;
    
    
    NSString *newimagePath;
  
    
    NSDictionary *backInforDict;
}
@end

@implementation AXHNewPostViewController
@synthesize postType;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(PostType )type withBackDict:(NSDictionary *)dict
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        postType = type;
        if (dict != nil) {
            backInforDict = dict;
        }
        
    }
    return self;
}
-(void)backUpper{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}
-(void)nextControl{
    if (postType == PostTypeBack || postType == PostTypeZXBack) {
        if (contentTextView.text == nil || [contentTextView.text isEqualToString:@""]) {
            [self altshowMsg:@"内容不能为空"];
            return;
        }
        [SVProgressHUD showWithStatus:@"正在发表评论" maskType:SVProgressHUDMaskTypeClear];
        if (postType == PostTypeBack) {
            NSString *str1 = [NSString stringWithFormat:@"{\"session\":\"%@\",\"city_id\":\"%@\",\"quarter_id\":\"%@\",\"community_id\":\"%@\",\"module_id\":\"\",\"forum_id\":\"%@\",\"user_id\":\"%@\",\"content\":\"%@\",\"ip\":\"102.152.313.31\"}",[SurveyRunTimeData sharedInstance].session,backInforDict[@"city_id"],backInforDict[@"quarter_id"],backInforDict[@"community_id"],backInforDict[@"id"],[SurveyRunTimeData sharedInstance].user_id,contentTextView.text];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqNewsPostHttpSer = [[SQForumHttpService alloc]init];
            sqNewsPostHttpSer.strUrl = SheQuHuDong_m10_06;
            sqNewsPostHttpSer.delegate = self;
            if (newimagePath == nil) {
                sqNewsPostHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            }else{
                sqNewsPostHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para",newimagePath,@"pictures", nil];
            }
            [sqNewsPostHttpSer beginQuery];
        }else if (postType == PostTypeZXBack){
            NSString *str1 = [NSString stringWithFormat:@"{\"session\":\"%@\",\"id\":\"%@\",\"content\":\"%@\",\"ip\":\"102.152.313.31\"}",[SurveyRunTimeData sharedInstance].session,backInforDict[@"article_id"],contentTextView.text];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqNewsPostHttpSer = [[SQForumHttpService alloc]init];
            sqNewsPostHttpSer.strUrl = kSOURCE_NEW_FEEDBACK_URL;
            sqNewsPostHttpSer.delegate = self;
            sqNewsPostHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
          
            [sqNewsPostHttpSer beginQuery];
        }
       
        
    }else{
    if (titleText.text == nil || [titleText.text isEqualToString:@""]) {
        
       [self altshowMsg:@"标题不能为空"];
        return;
    }
    if (contentTextView.text == nil || [contentTextView.text isEqualToString:@""]) {
        [self altshowMsg:@"内容不能为空"];
        return;
    }
        switch (postType) {
            case PostTypeDefault:{
                    [SVProgressHUD showWithStatus:@"正在发布帖子" maskType:SVProgressHUDMaskTypeClear];
                NSString *str1 = [NSString stringWithFormat:@"{\"session\":\"%@\",\"city_id\":\"%@\",\"quarter_id\":\"%@\",\"community_id\":\"%@\",\"module_id\":\"\",\"title\":\"%@\",\"content\":\"%@\",\"ip\":\"102.152.313.31\"}",[SurveyRunTimeData sharedInstance].session,[SurveyRunTimeData sharedInstance].city_id,[SurveyRunTimeData sharedInstance].quarter_id,[SurveyRunTimeData sharedInstance].community_id,titleText.text,contentTextView.text];
                NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                sqNewsPostHttpSer = [[SQForumHttpService alloc]init];
                sqNewsPostHttpSer.strUrl = SheQuHuDong_m10_07;
                sqNewsPostHttpSer.delegate = self;
                if (newimagePath == nil) {
                    sqNewsPostHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                }else{
                    sqNewsPostHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para",newimagePath,@"pictures", nil];
                }
                [sqNewsPostHttpSer beginQuery];
            }
                break;
            case PostTypeNews:{
                   [SVProgressHUD showWithStatus:@"正在报料" maskType:SVProgressHUDMaskTypeClear];
                NSString *str1 = [NSString stringWithFormat:@"{\"session\":\"%@\",\"city_id\":\"101\",\"area_id\":\"%@\",\"agency_id\":\"%@\",\"community_id\":\"%@\",\"quarter_id\":\"%@\",\"ip\":\"%@\",\"title\":\"%@\",\"content\":\"%@\",\"media_type\":\"%@\",\"fnews_type\":\"%@\",\"position\":\"%@\",\"longitude\":\"%@\",\"latitude\":\"%@\"}",[SurveyRunTimeData sharedInstance].session,@"104",@"101",[SurveyRunTimeData sharedInstance].community_id,[SurveyRunTimeData sharedInstance].quarter_id,@"221.8.155.176",titleText.text,contentTextView.text,@"1",@"1",@"吉林省吉林市桦甸市",@"126.755607",@"42.967617"];

                NSLog(@"参数：%@",str1);
                NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                sqNewsPostHttpSer = [[SQForumHttpService alloc]init];
                sqNewsPostHttpSer.strUrl = kSOURCE_NEW_URL;
                sqNewsPostHttpSer.delegate = self;
                if (newimagePath == nil) {
                    sqNewsPostHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                }else{
                    sqNewsPostHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para",newimagePath,@"mediafile", nil];
                }
                [sqNewsPostHttpSer beginQuery];
            }
                break;
            default:
                break;
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customRightNarvigationBarWithTitle:@"发布"];
    [self customViewBackImageWithImageName:nil];
    switch (postType) {
        case PostTypeDefault:
            self.navigationItem.title = @"发表新帖子";
            break;
        case PostTypeBack | PostTypeZXBack:
            self.navigationItem.title = @"评论";
            break;
        case PostTypeNews:
            self.navigationItem.title = @"发表报料";
            break;
        default:
            break;
    }
    
    // Do any additional setup after loading the view from its nib.
    [statueView setFrame:CGRectMake(0,kViewHeight, kViewwidth, 36)];
    
    contentTextView.delegate = self;
    
    if (postType == PostTypeBack || postType == PostTypeZXBack) {
        titleText.hidden = YES;
        CGRect frame = contentTextView.frame;
        frame.origin.y = 10;
        contentTextView.frame = frame;
        
        CGRect imageViewFrame = picBtn.frame;
        imageViewFrame.origin.y = imageViewFrame.origin.y - 30;
        picBtn.frame = imageViewFrame;
        
        CGRect placeLableFrame = placeLable.frame;
        placeLableFrame.origin.y = 13;
        placeLable.frame = placeLableFrame;
        if (postType == PostTypeZXBack) {
            picBtn.hidden = YES;
        }
    }
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (IBAction)facebtn {
    if (!isTextView) {
        if (titleText.isFirstResponder) {
            if (titleText.emoticonsKeyboard)
                [titleText switchToDefaultKeyboard];
            else
                [titleText switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
        }else{
            [titleText switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
            [titleText becomeFirstResponder];
        }
    }else{
        if (contentTextView.isFirstResponder) {
            if (contentTextView.emoticonsKeyboard)
                [contentTextView switchToDefaultKeyboard];
            else
                [contentTextView switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
        }else{
            [contentTextView switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
            [contentTextView becomeFirstResponder];
        }
    }
}
- (IBAction)textfiled:(id)sender {
    isTextView = NO;
    if (contentTextView.isFirstResponder) {
        [contentTextView resignFirstResponder];
    }
}
-(void)keyboardshow{
    [titleText becomeFirstResponder];
}
#pragma mark -textViewdelegate
-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length == 0)
    {
        prolable.text = @"说点什么吧...";
    }
    else
    {
        prolable.text = @"";
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    isTextView = YES;
    if (titleText.isFirstResponder) {
        [titleText resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)switchKey:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [actionSheet showInView:self.view];
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float height = keyboardRect.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect frame = statueView.frame;
    frame.origin.y = kViewHeight - height - 80;
    statueView.frame = frame;
    [UIView commitAnimations];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect frame = statueView.frame;
    frame.origin.y  = kViewHeight;
    statueView.frame = frame;
    [UIView commitAnimations];
}

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
            /*  ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
             picker.maximumNumberOfSelection = 5;
             picker.assetsFilter = [ALAssetsFilter allPhotos];
             picker.showEmptyGroups=NO;
             picker.delegate=self;
             picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
             if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
             NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
             return duration >= 5;
             } else {
             return YES;
             }
             }];
             
             [self presentViewController:picker animated:YES completion:NULL];
             */
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
    newimagePath = imagePath;
    
    [picBtn setImage:image forState:UIControlStateNormal];
    //关闭相册界面
    [self dismissViewControllerAnimated:NO completion:^{//备注2
    }];
    
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 5:{
            if ([sqNewsPostHttpSer.responDict[@"ecode"] intValue] != 1000) {
                [SVProgressHUD showErrorWithStatus:@"系统内部错误" duration:1.5];
                return;
            }
            [SVProgressHUD showSuccessWithStatus:@"发表成功" duration:1.5];
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"postSendSuccess" object:nil];
            }];
        }
            break;
        case 6:{
            if ([sqNewsPostHttpSer.responDict[@"ecode"] intValue] != 1000) {
                [SVProgressHUD showErrorWithStatus:@"系统内部错误" duration:1.5];
                return;
            }
            [SVProgressHUD showSuccessWithStatus:@"评论成功" duration:1.5];
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"backPostSendSuccess" object:nil];
            }];
        }
            break;
        case 9:{
            if ([sqNewsPostHttpSer.responDict[@"ecode"] intValue] != 1000) {
                [SVProgressHUD showErrorWithStatus:@"系统内部错误" duration:1.5];
                return;
            }
            [SVProgressHUD showSuccessWithStatus:@"发布成功" duration:1.5];
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
        }
            break;
        default:
            break;
    }
}
/*
 #pragma mark - ZYQAssetPickerController Delegate
 -(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
 //    [src.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
 
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 //        src.contentSize=CGSizeMake(assets.count*src.frame.size.width, src.frame.size.height);
 dispatch_async(dispatch_get_main_queue(), ^{
 //            pageControl.numberOfPages=assets.count;
 });
 
 CGFloat radius = 70.0;
 CGFloat gap = 6;
 CGFloat topOffset = 5;
 //        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
 //        [library assetForURL:[mediaInfoArray[0] objectForKey:UIImagePickerControllerReferenceURL]
 //                 resultBlock:^(ALAsset *asset)
 //         {
 //             ALAssetRepresentation *representation = [asset defaultRepresentation];
 //             CGImageRef imgRef = [representation fullResolutionImage];
 //             UIImage *image = [UIImage imageWithCGImage:imgRef
 //                                                  scale:representation.scale
 //                                            orientation:(UIImageOrientation)representation.orientation];
 //             NSData * data = UIImageJPEGRepresentation(image, 0.5);
 //             NSLog(@"%@",data);
 //         }failureBlock:^(NSError *error){
 //             NSLog(@"couldn't get asset: %@", error);
 //         }
 //         ];
 
 for (int i=0; i<assets.count; i++) {
 ALAsset *asset=assets[i];
 UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
 picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 [picBtn setFrame:CGRectMake(0, 0, radius, radius)];
 int column =  i % 4;
 int row    = i / 4;
 CGFloat x = 2 * gap + radius / 2 + (gap + radius)*column;
 CGFloat y = (row * gap + row  * radius) + topOffset +160;
 picBtn.center = CGPointMake(x, y);
 dispatch_async(dispatch_get_main_queue(), ^{
 [picBtn setImage:tempImg forState:UIControlStateNormal];
 [self.view insertSubview:picBtn atIndex:0];
 });
 }
 });
 }*/


@end
