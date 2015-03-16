//
//  wViewController.m
//  shi
//
//  Created by zhao on 14-2-27.
//  Copyright (c) 2014年 zhao. All rights reserved.
//

#import "wViewController.h"
#import "SheQuXuanZeViewController.h"

extern int IsFiirst;
@interface wViewController ()

@end

@implementation wViewController

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
       // Do any additional setup after loading the view from its nib.
    @try
    {

    
    NSString *String =@"IsFirst";
    NSLog(@"****************%@",String);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:String forKey:@"shifou"];
    

    IsFiirst=1;
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat owidth=size.width;
    CGFloat oheight=size.height;

    
    //创建UIScrollView
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,owidth,oheight)];//创建UIScrollView，位置大小与主界面一样。
    scrollview.contentSize=CGSizeMake(owidth*4, oheight);
    //[scrollview setContentSize:CGSizeMake(bounds.size.width*5, bounds.size.height)];//设置全部内容的尺寸，帮助图片是5张，所以宽度设为界面宽度*5，高度和界面一致。
    
    scrollview.pagingEnabled=YES;//设置按页面滑动
    scrollview.bounces=NO;//取消UIScrollView的弹性属性
    [scrollview setDelegate:self];//UIScrollView的delegate函数在本类中定义
    scrollview.showsHorizontalScrollIndicator=NO;//因为要使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条
   
    
    imageArr=[[NSMutableArray alloc]init];
    [imageArr addObject:@"start_01.jpg"];
    [imageArr addObject:@"start_02.jpg"];
    [imageArr addObject:@"start_03.jpg"];
    [imageArr addObject:@"start_04.jpg"];

        for (int i=0; i<[imageArr count]; i++)
    {
       
        UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[imageArr objectAtIndex:i]]];
        
        imageview.frame=CGRectMake((320*i), 0, owidth, oheight);
        
        [scrollview addSubview:imageview];
        
        if (i==3)
        {
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(115, 0.885*oheight, 0.27*owidth,0.05*oheight)];

            btn.backgroundColor=[UIColor clearColor];
            [btn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 9;

            imageview.userInteractionEnabled = YES;
           
            [imageview addSubview:btn];
            
        }
        [scrollview addSubview:imageview];
        
    }
    [self.view addSubview:scrollview];
    
    //创建UIPageControl
    pagectrl=[[UIPageControl alloc]initWithFrame:CGRectMake(130, oheight-(oheight/10-20), owidth/4, 30)];//创建UIPageControl，位置在屏幕最下方。
    pagectrl.numberOfPages=4;//总的图片页数
    pagectrl.currentPage=0;//当前页
    [pagectrl addTarget:self action:@selector(pageturn:) forControlEvents:UIControlEventValueChanged];//用户点击UIPageControl的响应函数
    [self.view addSubview:pagectrl];
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
-(void)next
{
    SheQuXuanZeViewController *xuanze=[[SheQuXuanZeViewController alloc]init];
    [self presentViewController:xuanze animated:NO completion:nil];
}
//滑动页面停止 减速时调用该属性方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset=scrollview.contentOffset;
    CGRect bounds=scrollview.frame;
    [pagectrl setCurrentPage:offset.x/bounds.size.width];
}
-(void)pageturn:(UIPageControl*)sender
{
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize=scrollview.frame.size;
    CGRect rect=CGRectMake(sender.currentPage*viewSize.width, 0, viewSize.width, viewSize.height);
    [scrollview scrollRectToVisible:rect animated:YES];
    
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
