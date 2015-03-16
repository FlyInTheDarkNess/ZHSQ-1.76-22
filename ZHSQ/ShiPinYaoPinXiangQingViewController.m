//
//  ShiPinYaoPinXiangQingViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-11-14.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ShiPinYaoPinXiangQingViewController.h"
extern NSDictionary *ShiPinYaoPin_Dictionary;

@interface ShiPinYaoPinXiangQingViewController ()

@end

@implementation ShiPinYaoPinXiangQingViewController

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
        label.text=@"食品药品";
        [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        [self.view addSubview:label];
        fanhui_btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
        [fanhui_btn setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
        [fanhui_btn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:fanhui_btn];
        
        myscrollview=[[UIScrollView alloc]init];
        myscrollview.delegate=self;
        myscrollview.frame=CGRectMake(0, 60, Width, Hidth-60);
        myscrollview.directionalLockEnabled =NO; //只能一个方向滑动
        myscrollview.pagingEnabled = NO; //是否翻页
        myscrollview.backgroundColor = [UIColor whiteColor];
        myscrollview.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
        myscrollview.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
        
        title_label=[[UILabel alloc]initWithFrame:CGRectMake(20, 60, 280, 20)];
        NSString * string;
        string =[ShiPinYaoPin_Dictionary objectForKey:@"title"];
        title_label.numberOfLines =0;
        UIFont * font = [UIFont systemFontOfSize:16];
        title_label.font = font;
        title_label.lineBreakMode =NSLineBreakByTruncatingTail;
        title_label.text =string ;
        title_label.textAlignment=NSTextAlignmentCenter;
        [myscrollview addSubview:title_label];
        CGSize sizea =CGSizeMake(300,10000);
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        CGSize  actualsize =[string boundingRectWithSize:sizea options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
       
        
        title_label.frame =CGRectMake(10,10,300, actualsize.height);//最终的坐标位置
        
        label_publish_department=[[UILabel alloc]initWithFrame:CGRectMake(20, actualsize.height+15, 180, 20)];
        label_publish_department.text=[ShiPinYaoPin_Dictionary objectForKey:@"article_source"];
        label_publish_department.font=[UIFont systemFontOfSize:12];
        label_publish_department.textColor=[UIColor grayColor];
        [myscrollview addSubview:label_publish_department];
        
        
        label_time=[[UILabel alloc]initWithFrame:CGRectMake(200, actualsize.height+15, 120, 20)];
        label_time.text=[ShiPinYaoPin_Dictionary objectForKey:@"article_date"];
        label_time.font=[UIFont systemFontOfSize:12];
        label_time.textColor=[UIColor grayColor];
        [myscrollview addSubview:label_time];
        
        hengxian=[[UILabel alloc]initWithFrame:CGRectMake(0, actualsize.height+35, 320, 1)];
        hengxian.backgroundColor=[UIColor grayColor];
        [myscrollview addSubview:hengxian];
        
        label_content=[[UILabel alloc]initWithFrame:CGRectMake(1, 60, 318, 20)];
        NSString * tstring;
        tstring =[ShiPinYaoPin_Dictionary objectForKey:@"content"];
        label_content.numberOfLines =0;
        UIFont * tfont = [UIFont systemFontOfSize:14];
        label_content.font = tfont;
        label_content.lineBreakMode =NSLineBreakByTruncatingTail;
        label_content.text = tstring ;
        [myscrollview addSubview:label_content];
        CGSize sizeb =CGSizeMake(300,10000);
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
        CGSize  ctualsize =[tstring boundingRectWithSize:sizeb options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
        //添加图片标题，确定图片标题位置
        label_content.frame =CGRectMake(10,actualsize.height+40,300, ctualsize.height);//最终的坐标位置
        [myscrollview setContentSize:CGSizeMake(self.view.frame.size.width,ctualsize.height+actualsize.height+50)];
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

@end
