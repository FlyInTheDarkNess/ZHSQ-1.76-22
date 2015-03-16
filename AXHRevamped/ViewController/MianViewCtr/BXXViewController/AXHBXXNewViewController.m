//
//  AXHBXXNewViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 15/2/12.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBXXNewViewController.h"

@interface AXHBXXNewViewController (){
    __weak IBOutlet UIButton *picBtn;
    __weak IBOutlet UITextField *titleText;
    __weak IBOutlet UITextView *contentTextView;

    __weak IBOutlet UILabel *placeLab;
    
    __weak IBOutlet UIButton *pickType;
    
    NSMutableArray *importItems;
    
    
    __weak IBOutlet UIView *statueView;
    
    BOOL isTextView;
    
//    //请求
    SQForumHttpService  *sqNewsPostHttpSer;
    
    
    NSString *newimagePath;
    
    
    NSDictionary *backInforDict;
    
    NSArray *typeArr;
    
    NSInteger type;
}

@end

@implementation AXHBXXNewViewController
@synthesize BXXTypeTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        typeArr = [NSArray arrayWithObjects:@"新闻现场",@"生活秀",@"图片莱芜", nil];
    }
    return self;
}
-(UITableView *)BXXTypeTableView{
   
        BXXTypeTableView = [[UITableView alloc]initWithFrame:CGRectMake(16, 60, 288, 120) style:UITableViewStylePlain];
        BXXTypeTableView.backgroundColor = [UIColor colorWithWhite:196/255.0 alpha:1];
        BXXTypeTableView.layer.masksToBounds = YES;
        BXXTypeTableView.layer.cornerRadius = 3;
        BXXTypeTableView.delegate = self;
        BXXTypeTableView.dataSource =self;
        BXXTypeTableView.tag = 103;
        BXXTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    return BXXTypeTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customRightNarvigationBarWithTitle:@"发布"];
  
    type = 1;
    
    self.navigationItem.title = @"添加新鲜事";
    // Do any additional setup after loading the view from its nib.
    [statueView setFrame:CGRectMake(0,kViewHeight, kViewwidth, 36)];
    
    contentTextView.delegate = self;
    

    
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
-(void)backUpper{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}
-(void)nextControl{
    if (titleText.text == nil || [titleText.text isEqualToString:@""]) {
        
        [self altshowMsg:@"标题不能为空"];
        return;
    }
    if (contentTextView.text == nil || [contentTextView.text isEqualToString:@""]) {
        [self altshowMsg:@"内容不能为空"];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在提交我的新鲜事" maskType:SVProgressHUDMaskTypeClear];
    NSString *str1 = [NSString stringWithFormat:@"{\"session\":\"%@\",\"city\":\"%@\",\"ip\":\"%@\",\"title\":\"%@\",\"content\":\"%@\",\"media_type\":\"%@\",\"fnews_type\":\"%d\",\"position\":\"%@\",\"longitude\":\"%@\",\"latitude\":\"%@\"}",[SurveyRunTimeData sharedInstance].session,[SurveyRunTimeData sharedInstance].city_id,@"221.8.155.176",titleText.text,contentTextView.text,@"1",type,@"房山饺子铺",@"126.755607",@"42.967617"];
    
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqNewsPostHttpSer = [[SQForumHttpService alloc]init];
    sqNewsPostHttpSer.strUrl = kBXX_NEW_URL;
    sqNewsPostHttpSer.delegate = self;
    if (newimagePath == nil) {
        sqNewsPostHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    }else{
        sqNewsPostHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para",newimagePath,@"mediafile", nil];
    }
    [sqNewsPostHttpSer beginQuery];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [picBtn setImage:image forState:UIControlStateNormal];
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
    
    
    //关闭相册界面
    [self dismissViewControllerAnimated:NO completion:^{//备注2
    }];
    
}
- (IBAction)pickType:(id)sender {
    if (!BXXTypeTableView) {
          [self.view addSubview:[self BXXTypeTableView]];
    }
   
    if (  BXXTypeTableView.hidden == YES) {
        BXXTypeTableView.hidden = NO;
    }
   
}
-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length == 0)
    {
        placeLab.text = @"说点什么吧...";
    }
    else
    {
        placeLab.text = @"";
    }
}
#pragma mark - UITableView -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static  NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSString *typeStr = [NSString stringWithFormat:@"%@",typeArr[indexPath.row]];
 
    
    UILabel *typeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 40)];
    typeLab.backgroundColor = [UIColor clearColor];
    typeLab.font = [UIFont systemFontOfSize:18];
    typeLab.textColor = [UIColor blackColor];
    typeLab.text = typeStr;
  
    
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:typeLab];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return typeArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return 40;
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [pickType setTitle:typeArr[indexPath.row] forState:UIControlStateNormal];
    type = indexPath.row +1;
    BXXTypeTableView.hidden = YES;
}
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 10:{
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
@end
