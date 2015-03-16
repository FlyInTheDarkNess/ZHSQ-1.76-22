//
//  LaiWuNewViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-1-9.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "LaiWuNewViewController.h"
#import "Header.h"
#import "BulletinNoticeHttpService.h"
extern NSString *columns_id;
extern NSString *columns_introduction;
extern NSString *first_play_time;
extern NSString *repeat_play_time;
extern NSString *HitRecommend_type;
@interface LaiWuNewViewController ()
{
    
    //主键ID
    NSArray *idList;
    //请求
    BulletinNoticeHttpService *sqHttpSer;
    //当前列表数据
    NSMutableArray *newsArr;
    //NSMutableArray *_fakeData;
    int startIndex;
    
    BOOL isUp;
}

@end

@implementation LaiWuNewViewController

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
    image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,320, 60)];
    image.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:image];
    label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.text=HitRecommend_type;
    label.textAlignment=NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    button=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    label_first_play_time=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, Width, 20)];
    NSString * tstring =first_play_time;
    label_first_play_time.numberOfLines =0;
    UIFont * tfont = [UIFont systemFontOfSize:12];
    label_first_play_time.font = tfont;
    label_first_play_time.backgroundColor=[UIColor grayColor];
    label_first_play_time.lineBreakMode =NSLineBreakByTruncatingTail ;
    label_first_play_time.text = tstring ;
    label_first_play_time.textColor=[UIColor whiteColor];
    [self.view addSubview:label_first_play_time];
    CGSize sizea_first_play_time =CGSizeMake(Width,10000);
    NSDictionary * tdic_first_play_time = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    CGSize  actualsize_first_play_time =[tstring boundingRectWithSize:sizea_first_play_time options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic_first_play_time context:nil].size;
    label_first_play_time.frame =CGRectMake(0,60,Width, actualsize_first_play_time.height);//最终的坐标位置

    
    label_repeat_play_time=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, Width, 20)];
    NSString * astring =repeat_play_time;
    label_repeat_play_time.numberOfLines =0;
    label_repeat_play_time.font =[UIFont systemFontOfSize:12];
    label_repeat_play_time.backgroundColor=[UIColor grayColor];
    label_repeat_play_time.lineBreakMode =NSLineBreakByTruncatingTail ;
    label_repeat_play_time.text = astring ;
    label_repeat_play_time.textColor=[UIColor whiteColor];
    [self.view addSubview:label_repeat_play_time];
    CGSize sizea_repeat_play_time=CGSizeMake(Width,10000);
    NSDictionary * tdic_repeat_play_time= [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    CGSize  actualsize_repeat_play_time=[astring boundingRectWithSize:sizea_repeat_play_time options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic_repeat_play_time context:nil].size;
    label_repeat_play_time.frame =CGRectMake(0,60+actualsize_first_play_time.height,Width, actualsize_repeat_play_time.height);//最终的坐标位置
    
    
    label_columns_introduction=[[UILabel alloc]initWithFrame:CGRectMake(0, 60+actualsize_first_play_time.height, Width, 20)];
    NSString * bstring =columns_introduction;
    label_columns_introduction.numberOfLines =0;
    UIFont * font = [UIFont systemFontOfSize:14];
    label_columns_introduction.textColor=[UIColor whiteColor];
    label_columns_introduction.font = font;
    label_columns_introduction.backgroundColor=[UIColor grayColor];
    label_columns_introduction.lineBreakMode =NSLineBreakByTruncatingTail ;
    label_columns_introduction.text = bstring ;
    [self.view addSubview:label_columns_introduction];
    CGSize sizea_columns_introduction=CGSizeMake(Width,10000);
    NSDictionary * tdic_columns_introduction= [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize  actualsize_columns_introduction=[bstring boundingRectWithSize:sizea_columns_introduction options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic_columns_introduction context:nil].size;
    label_columns_introduction.frame =CGRectMake(0,60+actualsize_first_play_time.height+actualsize_repeat_play_time.height,Width, actualsize_columns_introduction.height);//最终的坐标位置
    

    startIndex = 0;
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,60+actualsize_first_play_time.height+actualsize_repeat_play_time.height+actualsize_columns_introduction.height, Width, Hidth - 60+actualsize_first_play_time.height+actualsize_repeat_play_time.height+actualsize_columns_introduction.height) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [tableview addHeaderWithTarget:self action:@selector(dataInit)];
    [tableview addFooterWithTarget:self action:@selector(addData)];
    [tableview headerBeginRefreshing];
    
    newsArr = [NSMutableArray array];

}
-(void)dataInit
{
   NSString *str1=[NSString stringWithFormat:@"{\"session\":\"\",\"id\":%@}",columns_id];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[BulletinNoticeHttpService alloc]init];
    sqHttpSer.strUrl = HitRecommend_m29_01;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;
}
-(void)addData
{
    if (startIndex == idList.count) {
        [tableview footerEndRefreshing];
        [tableview setFooterHidden:YES];
        [SVProgressHUD showSuccessWithStatus:@"没有更多数据了!" duration:1.5];
        return;
        
    }
    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[BulletinNoticeHttpService alloc]init];
    sqHttpSer.strUrl = HitRecommend_m29_02;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = NO;
}


#pragma mark - UITableView Delegate


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MJTableViewCellIdentifier forIndexPath:indexPath];
    static NSString *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=nil;
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview]; //删除并进行重新分配
        }
    }
    
    NSString *image_url=[newsArr[indexPath.row] objectForKey:@"pic_url"];
    
    UIImageView *imagea=[[UIImageView alloc]init];
    imagea= [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 75,60)];
    imagea.tag = 1000;
    imagea.userInteractionEnabled=NO;
    
    if ([image_url isEqualToString:@""])
    {
        imagea.image=[UIImage imageNamed:@"video0916.png"];
        [cell.contentView addSubview:imagea];
    }
    else
    {
        [imagea setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",image_url]]
               placeholderImage:[UIImage imageNamed:@"tx1"]
                        options:SDWebImageRetryFailed
    usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell.contentView addSubview:imagea];
    }
    
    NSString *stringTime =[newsArr[indexPath.row] objectForKey:@"show_time"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *dateTime = [formatter dateFromString:stringTime];
    [formatter setDateFormat:@"MM月dd日"];
    NSString *locationString=[formatter stringFromDate:dateTime];
    
    
    UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(82, 25, 238, 20)];
    labela.text=[NSString stringWithFormat:@"%@ %@",HitRecommend_type,locationString];
    labela.backgroundColor=[UIColor whiteColor];
    labela.font=[UIFont systemFontOfSize:15];
    labela.textColor=[UIColor blackColor];
    [cell addSubview:labela];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    video_url=[newsArr[indexPath.row] objectForKey:@"video_url"];
    [self playmovie];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 7:{
            startIndex = 0;
            NSLog(@"%@",sqHttpSer.responDict);
            NSString *daima=[sqHttpSer.responDict objectForKey:@"ecode"];
            int intString = [daima intValue];
            if (intString==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1.5];
                [tableview headerEndRefreshing];
                
                return;
                
            }
            
            idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_list"]];
            NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 10]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[BulletinNoticeHttpService alloc]init];
            sqHttpSer.strUrl = HitRecommend_m29_02;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
            
        }
            break;
        case 8:{
            [tableview headerEndRefreshing];
            [tableview footerEndRefreshing];
            
            if (isUp) {
                [newsArr removeAllObjects];
            }
            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info"]];
            
            [newsArr addObjectsFromArray:responArr];
            NSLog(@"%@",newsArr);

            [tableview reloadData];
           

        }
            break;
        default:
            break;
    }
    
}
-(void)didReceieveFail:(NSInteger)tag{
    [tableview headerEndRefreshing];
    [tableview footerEndRefreshing];
}
-(NSString *)getFromArr:(NSArray *)arr withNumber:(int)num{
    if (arr.count == 0) {
        return @"";
    }
    NSMutableString *finalStr =[[NSMutableString alloc] initWithString:@"["];
    if (arr.count < num) {
        num = arr.count;
    }
    for (int index = startIndex; index < num; index++) {
        [finalStr appendFormat:@"{\"id\":\"%@\"},",arr[index][@"id"]];
        startIndex++;
    }
    NSUInteger location = [finalStr length]-1;
    NSRange range = NSMakeRange(location, 1);
    [finalStr replaceCharactersInRange:range withString:@"]"];
    return finalStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  播放视频事件，点击开始播放
- (void)playmovie
{
    MoviePlayerViewController *movieVC;
    NSURL *url = [NSURL URLWithString:video_url];
    // NSLog(@"url: %@",url);
    @try
    {
        
        
        movieVC = [[MoviePlayerViewController alloc]initNetworkMoviePlayerViewControllerWithURL:url movieTitle:@""];
        movieVC.datasource = self;
        [self presentViewController:movieVC animated:NO completion:nil];

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

- (void)fanhui:(id)sender
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
