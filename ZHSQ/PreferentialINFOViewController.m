//
//  PreferentialINFOViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-1-8.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "PreferentialINFOViewController.h"
#import "YouHuiShangJiaXiangXiXinXiViewController.h"
#import "Header.h"
#import "BulletinNoticeHttpService.h"
extern NSDictionary *YouHuiZiXunDic;
@interface PreferentialINFOViewController ()
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

@implementation PreferentialINFOViewController

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
    label.text=@"优惠资讯";
    label.font=[UIFont systemFontOfSize:19];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    button=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    startIndex = 0;
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, Width, Hidth - 60) style:UITableViewStylePlain];
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
     NSString *str1=@"{\"session\":\"\",\"city_id\":\"101\",\"area_id\":\"\",\"agency_id\":\"\",\"community_id\":\"\",\"quarter_id\":\"\",\"article_type_id\":\"60\"}";
    
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[BulletinNoticeHttpService alloc]init];
    sqHttpSer.strUrl = ZiXunXinXi_m38_01;
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
    sqHttpSer.strUrl = ZiXunXinXi_m38_02;
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
    
    NSArray *imagelist=[[NSArray alloc]init];
    imagelist=[newsArr[indexPath.row] objectForKey:@"pic"];
    NSDictionary *imzgedic=[[NSDictionary alloc]init];
    imzgedic=[imagelist objectAtIndex:0];
    NSString *image_url=[imzgedic objectForKey:@"thumbs_url"];
    
    UIImageView *imagea=[[UIImageView alloc]init];
    imagea= [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 75,60)];
    imagea.tag = 1000;
    imagea.userInteractionEnabled=NO;
    
    if ([image_url isEqualToString:@""])
    {
        
        UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(5, 5,310, 20)];
        labela.text=[newsArr[indexPath.row] objectForKey:@"title"];
        labela.backgroundColor=[UIColor whiteColor];
        labela.font=[UIFont systemFontOfSize:15];
        labela.textColor=[UIColor blackColor];
        [cell addSubview:labela];
        UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(8, 23, 304, 20)];
        labelb.text=[newsArr[indexPath.row] objectForKey:@"summary"];
        labelb.backgroundColor=[UIColor whiteColor];
        labelb.font=[UIFont systemFontOfSize:15];
        labelb.textColor=[UIColor grayColor];
        [cell addSubview:labelb];
        UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(220, 59, 100, 20)];
        labelc.text=[newsArr[indexPath.row] objectForKey:@"article_date"];
        labelc.backgroundColor=[UIColor whiteColor];
        labelc.font=[UIFont systemFontOfSize:12];
        labelc.textColor=[UIColor grayColor];
        [cell addSubview:labelc];
        UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(8, 59, 170, 20)];
        labeld.text=[newsArr[indexPath.row] objectForKey:@"article_source"];
        labeld.backgroundColor=[UIColor whiteColor];
        labeld.font=[UIFont systemFontOfSize:12];
        labeld.textColor=[UIColor grayColor];
        [cell addSubview:labeld];
    }
    else
    {
        [imagea setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",image_url]]
               placeholderImage:[UIImage imageNamed:@"tx1"]
                        options:SDWebImageRetryFailed
    usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        //[imagea setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",image_url]] placeholderImage:[UIImage imageNamed:@"tx1"] options:SDWebImageProgressiveDownload];
        [cell.contentView addSubview:imagea];
        
        UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(82, 5, 238, 20)];
        labela.text=[newsArr[indexPath.row] objectForKey:@"title"];
        labela.backgroundColor=[UIColor whiteColor];
        labela.font=[UIFont systemFontOfSize:15];
        labela.textColor=[UIColor blackColor];
        [cell addSubview:labela];
        UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(82, 25, 238, 20)];
        labelb.text=[newsArr[indexPath.row] objectForKey:@"summary"];
        labelb.backgroundColor=[UIColor whiteColor];
        labelb.font=[UIFont systemFontOfSize:15];
        labelb.textColor=[UIColor grayColor];
        [cell addSubview:labelb];
        UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(220, 45, 100, 20)];
        labelc.text=[newsArr[indexPath.row] objectForKey:@"article_date"];
        labelc.backgroundColor=[UIColor whiteColor];
        labelc.font=[UIFont systemFontOfSize:12];
        labelc.textColor=[UIColor grayColor];
        [cell addSubview:labelc];
        UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(82, 45, 120, 20)];
        labeld.text=[newsArr[indexPath.row] objectForKey:@"article_source"];
        labeld.backgroundColor=[UIColor whiteColor];
        labeld.font=[UIFont systemFontOfSize:12];
        labeld.textColor=[UIColor grayColor];
        [cell addSubview:labeld];
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YouHuiZiXunDic=newsArr[indexPath.row];
    YouHuiShangJiaXiangXiXinXiViewController *shangjia=[[YouHuiShangJiaXiangXiXinXiViewController alloc]init];
    [self presentViewController:shangjia animated:YES completion:nil];
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
        case 5:{
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
            NSString *str1=[NSString stringWithFormat:@"{\"city_id\":\"101\",\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 10]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[BulletinNoticeHttpService alloc]init];
            sqHttpSer.strUrl = ZiXunXinXi_m38_02;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
            
        }
            break;
        case 6:{
            [tableview headerEndRefreshing];
            [tableview footerEndRefreshing];
            
            if (isUp) {
                [newsArr removeAllObjects];
            }
            NSLog(@"%@",sqHttpSer.responDict);
            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info"]];
            [newsArr addObjectsFromArray:responArr];
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

/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */

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
