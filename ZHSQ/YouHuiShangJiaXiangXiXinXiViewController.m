//
//  YouHuiShangJiaXiangXiXinXiViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-18.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "YouHuiShangJiaXiangXiXinXiViewController.h"
#import "UIScrollView+MJRefresh.h"
#import "MBProgressHUD.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UIImageView+WebCache.h"



extern NSDictionary *SJXXdtDictionary;
extern NSDictionary *YouHuiZiXunDic;
extern NSString *UserName;
extern NSString *Session;

@interface YouHuiShangJiaXiangXiXinXiViewController ()
{
    NSMutableArray *_fakeData;
    NSMutableArray *shuzu;
}

@end

@implementation YouHuiShangJiaXiangXiXinXiViewController
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
    [super viewDidLoad];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    //设置滑动背景
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.text=@"优惠资讯";
    label.font=[UIFont systemFontOfSize:19];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    myscrollview=[[UIScrollView alloc]init];
    myscrollview.delegate=self;
    myscrollview.frame=CGRectMake(0, 60, Width, Hidth-60);
    myscrollview.directionalLockEnabled =NO; //只能一个方向滑动
    myscrollview.pagingEnabled = NO; //是否翻页
    myscrollview.backgroundColor = [UIColor whiteColor];
    
    
    myscrollview=[[UIScrollView alloc]init];
    myscrollview.delegate=self;
    myscrollview.frame=CGRectMake(0, 60, Width, Hidth-60);
    myscrollview.directionalLockEnabled =NO; //只能一个方向滑
    myscrollview.pagingEnabled = NO; //是否翻页
    myscrollview.backgroundColor = [UIColor whiteColor];
    
    a=[[NSMutableArray alloc]init];//返回值pic对应的数组
    b=[[NSMutableArray alloc]init];//返回值pic对应的数组中的pic_url对应数组
    c=[[NSMutableArray alloc]init];//最终存放图片的数组
    d=[[NSMutableArray alloc]init];//返回值pic对应的数组中的pic_content对应数组
    e=[[NSMutableArray alloc]init];//最终存放图片标题的数组
    gaodu=[[NSMutableArray alloc]init];//存放[gaodu count]-1图片标题的所有标题高度
    zonggaodu=[[NSMutableArray alloc]init];
    int i;
    a=[YouHuiZiXunDic objectForKey:@"pic"];
    for (i=0; i<[a count]; i++)
    {
        NSString *str;
        NSString *str1;
        str=[[a objectAtIndex:i] objectForKey:@"pic_url"];
        [b addObject:str];
        str1=[[a objectAtIndex:i] objectForKey:@"pic_content"];
        [d addObject:str1];
        
    }
    for (int j=0; j<[b count]; j++)
    {
        NSString *str1;
        str1=[b objectAtIndex:j];
        NSString *str2;
        str2=[d objectAtIndex:j];
        
        if (![str1 isEqualToString:@""])
        {
            [c addObject:str1];
            [e addObject:str2];
        }
    }
    
    label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    label1.backgroundColor=[UIColor colorWithRed:176/255.0 green:230/255.0 blue:255/255.0 alpha:1];
    label1.text=[YouHuiZiXunDic objectForKey:@"title"];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:14];
    [myscrollview addSubview:label1];
    
    
    
    if (![[YouHuiZiXunDic objectForKey:@"video_url"] isEqualToString:@""])
    {
        imageview2=[[UIImageView alloc]init];
        [imageview2 setImageWithURL:[NSURL URLWithString:[YouHuiZiXunDic objectForKey:@"video_pic_thumbs"]]
                 placeholderImage:[UIImage imageNamed:@"shangjia1"]
                          options:SDWebImageRetryFailed
      usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

        imageview2.frame=CGRectMake(0, 40, 320, 200);
        //[myscrollview addSubview:imageview2];
        
        
        video_url=[YouHuiZiXunDic objectForKey:@"video_url"];
        playbtn=[[UIButton alloc]initWithFrame:CGRectMake(130, 100, 60, 60)];
        [playbtn setImage:[UIImage imageNamed:@"videoplay0523.png"] forState:UIControlStateNormal];
        playbtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [playbtn addTarget:self action:@selector(playmovie) forControlEvents:UIControlEventTouchUpInside];
        [myscrollview addSubview:playbtn];
    }
    if ([[YouHuiZiXunDic objectForKey:@"video_url"] isEqualToString:@""])
    {
        imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, 320,0)];
        [myscrollview addSubview:imageview2];
    }
    label2=[[UILabel alloc]initWithFrame:CGRectMake(Width/2, imageview2.frame.size.height+40, Width/2, 20)];
    label2.textAlignment=NSTextAlignmentRight;
    label2.text=[YouHuiZiXunDic objectForKey:@"createdate"];
    label2.font=[UIFont systemFontOfSize:14];
    label2.textColor=[UIColor grayColor];
    label2.backgroundColor=[UIColor colorWithRed:240/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [myscrollview addSubview:label2];
    
    label3=[[UILabel alloc]initWithFrame:CGRectMake(10,imageview2.frame.size.height+40, Width/2, 20)];
    label3.textAlignment=NSTextAlignmentLeft;
    label3.text=[YouHuiZiXunDic objectForKey:@"source"];
    label3.font=[UIFont systemFontOfSize:14];
    label3.textColor=[UIColor grayColor];
    label3.backgroundColor=[UIColor colorWithRed:240/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [myscrollview addSubview:label3];
    
    
    if ([c count]!=0)
    {
        for (int k=0; k<[c count]; k++)
        {
            UILabel * testlable = [[UILabel alloc]initWithFrame:CGRectMake(60,420,200,20)];
            NSString * tstring =[e objectAtIndex:k];
            testlable.numberOfLines =0;
            UIFont * tfont = [UIFont systemFontOfSize:14];
            testlable.font = tfont;
            testlable.textAlignment=NSTextAlignmentCenter;
            testlable.lineBreakMode =NSLineBreakByTruncatingTail ;
            testlable.text = tstring ;
            [myscrollview addSubview:testlable];
            CGSize size =CGSizeMake(300,10000);
            NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
            CGSize  actualsize =[tstring boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
            int q=actualsize.height;
            NSString *stringInt = [NSString stringWithFormat:@"%d",q];
            [gaodu addObject:stringInt];
            int sum=0;
            sum_label=0;
            if ([gaodu count]-1>0)
            {
                for (int k=0; k<[gaodu count]-1; k++)
                {
                    NSString *str;
                    str=[gaodu objectAtIndex:k];
                    int intString = [str intValue];
                    sum=sum+intString;
                }
                for (int k=0; k<[gaodu count]; k++)
                {
                    NSString *str;
                    str=[gaodu objectAtIndex:k];
                    int intString = [str intValue];
                    sum_label=sum_label+intString;
                }
            }
            //添加图片标题，确定图片标题位置
            testlable.frame =CGRectMake(0,imageview2.frame.size.height+220+sum+160*k,320, actualsize.height);//最终的坐标位置
            //添加图片，确定图片位置
            NSString *image_url=[c objectAtIndex:k];
            NSData *imagedata=[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:image_url]];
            UIImage *imagea=[[UIImage alloc] initWithData:imagedata];
            UIImageView *imageview=[[UIImageView alloc]initWithImage:imagea];
            
            imageview.frame=CGRectMake(60,imageview2.frame.size.height+70+sum+160*k, 200, 150);
            [myscrollview addSubview:imageview];
        }
    }
    if ([c count]==0)
    {
        sum_label=0;
    }
    label_content=[[UILabel alloc]initWithFrame:CGRectMake(1, imageview2.frame.size.height+70+sum_label+[c count]*160, 318, 20)];
    NSString * tstring =[YouHuiZiXunDic objectForKey:@"content"];
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
    int gao=imageview2.frame.size.height+80+sum_label+[c count]*160;
    label_content.frame =CGRectMake(10,gao,300, actualsize.height);//最终的坐标位置
    
    CGSize newSize = CGSizeMake(self.view.frame.size.width,gao+actualsize.height);
    [myscrollview setContentSize:newSize];
    myscrollview.showsVerticalScrollIndicator =YES;
    //添加scrollview
    [self.view addSubview:myscrollview];
    


}
//  播放视频事件，点击开始播放
- (void)playmovie
{
    MoviePlayerViewController *movieVC;
    NSURL *url = [NSURL URLWithString:video_url];
    NSLog(@"url: %@",url);
    @try
    {
        
        
        movieVC = [[MoviePlayerViewController alloc]initNetworkMoviePlayerViewControllerWithURL:url movieTitle:@""];
        
    }
    @catch (NSException *q) {
        NSLog(@"Exception: %@",q);
        UIAlertView * alert =
        [[UIAlertView alloc]
         initWithTitle:@"错误"
         message: [[NSString alloc] initWithFormat:@"%@",q]
         delegate:self
         cancelButtonTitle:nil
         otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
    movieVC.datasource = self;
    [self presentViewController:movieVC animated:NO completion:nil];
    
}

- (BOOL)isHavePreviousMovie//视频
{
    return NO;//上一个功能设置
}
- (BOOL)isHaveNextMovie//视频
{
    return NO;//下一个功能设置
}
- (NSDictionary *)previousMovieURLAndTitleToTheCurrentMovie//视频
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSURL URLWithString:@"http://v.youku.com/player/getRealM3U8/vid/XNjQ5MDM3Nzg0/type/mp4/v.m3u8"],KURLOfMovieDicTionary,@"qqqqqqq",KTitleOfMovieDictionary, nil];
    return dic;
}
- (NSDictionary *)nextMovieURLAndTitleToTheCurrentMovie//视频
{
    return nil;
}

- (void)showWithCustomView:(NSString*)aString
{
    
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
    [self dismissViewControllerAnimated:NO completion:nil];
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
