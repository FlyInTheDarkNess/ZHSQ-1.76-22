//
//  ZHMyMessageDetailsViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-24.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ZHMyMessageDetailsViewController.h"
extern NSDictionary *MyMessageDictionary;
@interface ZHMyMessageDetailsViewController ()

@end

@implementation ZHMyMessageDetailsViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度

    imageview_title=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    imageview_title.image=[UIImage imageNamed:@"nav.png"];
    [self.view addSubview:imageview_title];
    label_MessageTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label_MessageTitle.text=@"我的消息";
    [label_MessageTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_MessageTitle.textColor=[UIColor whiteColor];
    label_MessageTitle.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label_MessageTitle];
    btn_fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [btn_fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [btn_fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn_fanhui];
    imageview_MessageTitle=[[UIImageView alloc]initWithFrame:CGRectMake(0, 60, Width, 80)];
    imageview_MessageTitle.image=[UIImage imageNamed:@"渐变背景.png"];
    [self.view addSubview:imageview_MessageTitle];
    
    label_MessageTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, Width-20, 60)];
    label_MessageTitle.text=[MyMessageDictionary objectForKey:@"m_title"];
    label_MessageTitle.numberOfLines=0;
    label_MessageTitle.textAlignment=NSTextAlignmentCenter;
    label_MessageTitle.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:label_MessageTitle];

    label_time=[[UILabel alloc]initWithFrame:CGRectMake(0.6*Width, 120, 0.4*Width, 20)];
    label_time.text=[MyMessageDictionary objectForKey:@"createdate"];
    label_time.textAlignment=NSTextAlignmentCenter;
    label_time.textColor=[UIColor grayColor];
    label_time.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:label_time];

    label_MessageContent=[[UILabel alloc]initWithFrame:CGRectMake(1, 60, 318, 20)];
    NSString * tstring =[MyMessageDictionary objectForKey:@"m_content"];
    label_MessageContent.numberOfLines =0;
    UIFont * tfont = [UIFont systemFontOfSize:14];
    label_MessageContent.font = tfont;
    label_MessageContent.lineBreakMode =NSLineBreakByTruncatingTail ;
    label_MessageContent.text = tstring ;
    [self.view addSubview:label_MessageContent];
    CGSize sizea =CGSizeMake(300,10000);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    CGSize  actualsize =[tstring boundingRectWithSize:sizea options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    //添加图片标题，确定图片标题位置
    
    label_MessageContent.frame =CGRectMake(10,150,Width-20, actualsize.height);//最终的坐标位置

    
}
-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
