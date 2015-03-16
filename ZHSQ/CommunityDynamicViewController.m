//
//  CommunityDynamicViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "CommunityDynamicViewController.h"
#import "AXHVendors.h"
@interface CommunityDynamicViewController ()
{
    
    //新闻ID
    NSArray *idList;
    //请求
    CommunityDynamicHttpService *sqHttpSer;
    //当前列表数据
    NSMutableArray *newsArr;
    
    int startIndex;
    
    BOOL isUp;
}

@end

@implementation CommunityDynamicViewController
@synthesize dtTableView;
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
    
    startIndex = 0;
    
    dtTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStylePlain];
    dtTableView.backgroundColor = [UIColor whiteColor];
    dtTableView.delegate = self;
    
    dtTableView.dataSource = self;
    [self.view addSubview:dtTableView];
    
    [dtTableView addHeaderWithTarget:self action:@selector(dataInit)];
    [dtTableView addFooterWithTarget:self action:@selector(addData)];
    [dtTableView headerBeginRefreshing];
    
    newsArr = [NSMutableArray array];
    
}
-(void)dataInit{
    NSString *str1=@"{\"city_id\":\"101\",\"community_id\":\"102\"}";
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[CommunityDynamicHttpService alloc]init];
    sqHttpSer.strUrl = SheQuDongTai_m7_01;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;
}
-(void)addData{
    if (startIndex == idList.count) {
        [dtTableView footerEndRefreshing];
        [dtTableView setFooterHidden:YES];
        [SVProgressHUD showSuccessWithStatus:@"没有更多数据了!" duration:1.5];
        return;
        
    }
    NSString *str1=[NSString stringWithFormat:@"{\"city_id\":\"101\",\"community_id\":\"102\",\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
    
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[CommunityDynamicHttpService alloc]init];
    sqHttpSer.strUrl = SheQuDongTai_m7_02;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    static NSString *CellIdentifier=@"AXHSQDynamicCell";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    for (UIView *view in cell.contentView.subviews) {
//        [view removeFromSuperview];
//    }
//    if (cell==nil)
//    {
//        NSArray *nibsArr = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
//        cell  = nibsArr[0];
//    }
//    
//    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:newsArr[indexPath.row]];
//    //NSLog(@"%@",dict);
//    NSArray *imageArr = [NSArray arrayWithArray:dict[@"pic"]];
//    NSString *image_url=[imageArr[0] objectForKey:@"thumbs_url"];
//    // NSLog(@"%@",image_url);
//    UIImageView *leftImageView = (UIImageView *)[cell.contentView viewWithTag:100];
//    
//    [leftImageView setImageWithURL:[NSURL URLWithString:image_url]
//                  placeholderImage:[UIImage imageNamed:@"setPerson"]
//                           options:SDWebImageRetryFailed
//       usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    
//    UILabel *titleLab = (UILabel *)[cell.contentView viewWithTag:101];
//    titleLab.text = [dict objectForKey:@"title"];
//    
//    UILabel *detailLab = (UILabel *)[cell.contentView viewWithTag:102];
//    detailLab.text = [dict objectForKey:@"summary"];
//    
//    UILabel *deptLab = (UILabel *)[cell.contentView viewWithTag:103];
//    deptLab.text = [dict objectForKey:@"source"];
//    
//    UILabel *dateLab = (UILabel *)[cell.contentView viewWithTag:104];
//    dateLab.text = [dict objectForKey:@"createdate"];
//    
//    return cell;
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
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]];
    if (data.length>0)
    {
        UIImageView *imagea=[[UIImageView alloc]init];
        imagea= [[UIImageView alloc]initWithFrame:CGRectMake(5, 1, 65,58)];
        imagea.tag = 1000;
        imagea.userInteractionEnabled=NO;
        
        //imagea.hidden = NO;
        [imagea setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",image_url]]
               placeholderImage:[UIImage imageNamed:@"shequdongtai1"]
                        options:SDWebImageRetryFailed
    usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        [cell.contentView addSubview:imagea];
        
        
        
        UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(75, 0, 255, 20)];
        labela.text=[newsArr[indexPath.row] objectForKey:@"title"];
        labela.backgroundColor=[UIColor whiteColor];
        labela.font=[UIFont systemFontOfSize:12];
        labela.textColor=[UIColor blackColor];
        [cell addSubview:labela];
        UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(78, 18, 252, 20)];
        labelb.text=[newsArr[indexPath.row] objectForKey:@"summary"];
        labelb.backgroundColor=[UIColor whiteColor];
        labelb.font=[UIFont systemFontOfSize:12];
        labelb.textColor=[UIColor grayColor];
        [cell addSubview:labelb];
        UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(250, 39, 70, 20)];
        labelc.text=[newsArr[indexPath.row] objectForKey:@"createdate"];
        labelc.backgroundColor=[UIColor whiteColor];
        labelc.font=[UIFont systemFontOfSize:12];
        labelc.textColor=[UIColor grayColor];
        [cell addSubview:labelc];
        UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(78, 39, 70, 20)];
        labeld.text=[newsArr[indexPath.row] objectForKey:@"source"];
        labeld.backgroundColor=[UIColor whiteColor];
        labeld.font=[UIFont systemFontOfSize:12];
        labeld.textColor=[UIColor grayColor];
        [cell addSubview:labeld];
        
        
    }
    else
    {
        
        UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 310, 20)];
        labela.text=[newsArr[indexPath.row] objectForKey:@"title"];
        labela.backgroundColor=[UIColor whiteColor];
        labela.font=[UIFont systemFontOfSize:12];
        labela.textColor=[UIColor blackColor];
        [cell addSubview:labela];
        UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(8, 18, 252, 20)];
        labelb.text=[newsArr[indexPath.row] objectForKey:@"summary"];
        labelb.backgroundColor=[UIColor whiteColor];
        labelb.font=[UIFont systemFontOfSize:12];
        labelb.textColor=[UIColor grayColor];
        [cell addSubview:labelb];
        UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(250, 39, 70, 20)];
        labelc.text=[newsArr[indexPath.row] objectForKey:@"createdate"];
        labelc.backgroundColor=[UIColor whiteColor];
        labelc.font=[UIFont systemFontOfSize:12];
        labelc.textColor=[UIColor grayColor];
        [cell addSubview:labelc];
        UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(8, 39, 170, 20)];
        labeld.text=[newsArr[indexPath.row] objectForKey:@"source"];
        labeld.backgroundColor=[UIColor whiteColor];
        labeld.font=[UIFont systemFontOfSize:12];
        labeld.textColor=[UIColor grayColor];
        [cell addSubview:labeld];
        
    }
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:newsArr[indexPath.row]];
//    //NSLog(@"%@",dict);
//    AXHSQDynamicDetailViewController *sqDetailVCtr = [[AXHSQDynamicDetailViewController alloc]initWithNibName:nil bundle:nil withDetailDict:dict];
//    [self.navigationController pushViewController:sqDetailVCtr animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsArr.count;
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 1:{
            startIndex = 0;
            idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_list"]];
            NSString *str1=[NSString stringWithFormat:@"{\"city_id\":\"101\",\"community_id\":\"102\",\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 10]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[CommunityDynamicHttpService alloc]init];
            sqHttpSer.strUrl = SheQuDongTai_m7_02;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
            
        }
            break;
        case 2:{
            [dtTableView headerEndRefreshing];
            [dtTableView footerEndRefreshing];
            
            if (isUp) {
                [newsArr removeAllObjects];
            }
            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"news_info"]];
            [newsArr addObjectsFromArray:responArr];
            [dtTableView reloadData];
            
        }
            break;
        default:
            break;
    }
    
}
-(void)didReceieveFail:(NSInteger)tag{
    [dtTableView headerEndRefreshing];
    [dtTableView footerEndRefreshing];
}
-(NSString *)getFromArr:(NSArray *)arr withNumber:(int)num{
    if (arr.count == 0) {
        return @"";
    }
    NSLog(@"》》》》》》  %d",arr.count);
    
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
    NSLog(@">>>>>>>>>>>%@",finalStr);
    return finalStr;
}


@end
