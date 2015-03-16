//
//  TongZhiXiangQingViewController.m
//  ZHSQ
//
//  Created by lacom on 14-6-12.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "TongZhiXiangQingViewController.h"
extern NSDictionary *TZDictionary;
@interface TongZhiXiangQingViewController ()

@end

@implementation TongZhiXiangQingViewController
@synthesize myscrollview;
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
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    self.view.backgroundColor=[UIColor whiteColor];
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];

    label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.text=@"物业通知";
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label];
    fanhui_btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui_btn setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui_btn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui_btn];
    title_label=[[UILabel alloc]initWithFrame:CGRectMake(0, 70, 320, 30)];
    title_label.text=[TZDictionary objectForKey:@"title"];
    title_label.textAlignment=NSTextAlignmentCenter;
    title_label.backgroundColor=[UIColor colorWithRed:219/255.0 green:233/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:title_label];
    
    myscrollview=[[UIScrollView alloc]init];
    myscrollview.delegate=self;
    myscrollview.frame=CGRectMake(0, 110, Width, Hidth-110);
    myscrollview.directionalLockEnabled =NO; //只能一个方向滑动
    myscrollview.pagingEnabled = NO; //是否翻页
    myscrollview.backgroundColor = [UIColor whiteColor];
    myscrollview.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
    myscrollview.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    label_content=[[UILabel alloc]initWithFrame:CGRectMake(1, 60, 318, 20)];
    NSString * tstring =[TZDictionary objectForKey:@"content"];
    label_content.numberOfLines =0;
    UIFont * tfont = [UIFont systemFontOfSize:14];
    label_content.font = tfont;
    label_content.lineBreakMode =NSLineBreakByTruncatingTail ;
    label_content.text = tstring ;
    [myscrollview addSubview:label_content];
    CGSize sizea =CGSizeMake(300,10000);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    CGSize  actualsize =[tstring boundingRectWithSize:sizea options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    //添加图片标题，确定图片标题位置
    
    label_content.frame =CGRectMake(10,0,300, actualsize.height);//最终的坐标位置
    
    CGSize newSize = CGSizeMake(self.view.frame.size.width,actualsize.height);
    [myscrollview setContentSize:newSize];
    myscrollview.showsVerticalScrollIndicator =YES;

    [self.view addSubview:myscrollview];
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
-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
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

@end
