//
//  AXHSQDynamicViewController.m
//  HappyFace
//
//  Created by 安雄浩的mac on 14-12-5.
//  Copyright (c) 2014年 安雄浩的mac. All rights reserved.
//

#import "AXHSQDynamicViewController.h"
#import "AXHSQDynamicDetailViewController.h"

extern int WDNum;
@interface AXHSQDynamicViewController (){
    
    //新闻ID
    NSArray *idList;
    //请求
    SQDynamicHttpService *sqHttpSer;
    //当前列表数据
    NSMutableArray *newsArr;
    
    int startIndex;
    
    BOOL isUp;
    
    
    NSString *itemTitle;
    NSInteger zxType;
}
@end

@implementation AXHSQDynamicViewController
@synthesize dtTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTitle:(NSString *)title withType:(NSInteger)type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        zxType = type;
        itemTitle = title;
    }
    return self;
}
-(void)backUpper{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil];
    self.navigationItem.title = itemTitle;
    
    startIndex = 0;
    dtTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 44) style:UITableViewStylePlain];
    dtTableView.backgroundColor = [UIColor whiteColor];
    dtTableView.delegate = self;
    dtTableView.dataSource = self;
    [self.view addSubview:dtTableView];
    
    [dtTableView addHeaderWithTarget:self action:@selector(dataInit)];
    [dtTableView addFooterWithTarget:self action:@selector(addData)];
    [dtTableView headerBeginRefreshing];
    //    [dtTableView setFooterHidden:YES];
    
    newsArr = [NSMutableArray array];
    
}
-(void)dataInit{
    NSString *str1 = [NSString stringWithFormat:@"{\"session\":\"%@\",\"city_id\":\"%@\",\"area_id\":\"%@\",\"agency_id\":\"%@\",\"community_id\":\"%@\",\"quarter_id\":\"%@\",\"article_item_id\":\"%d\"}",@"",[SurveyRunTimeData sharedInstance].city_id,[SurveyRunTimeData sharedInstance].area_id,[SurveyRunTimeData sharedInstance].agency_id,[SurveyRunTimeData sharedInstance].community_id,[SurveyRunTimeData sharedInstance].quarter_id,zxType];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[SQDynamicHttpService alloc]init];
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
    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[SQDynamicHttpService alloc]init];
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
    
    static NSString *CellIdentifier=@"AXHSQDynamicCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (cell==nil)
    {
        NSArray *nibsArr = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
        cell  = nibsArr[0];
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:newsArr[indexPath.row]];
    
    NSArray *imageArr = [NSArray arrayWithArray:dict[@"pic"]];
    NSString *image_url=[imageArr[0] objectForKey:@"thumbs_url"];
    if (image_url.length == 0) {
        image_url=[dict objectForKey:@"article_type_icon"];
    }
    
    UIImageView *leftImageView = (UIImageView *)[cell.contentView viewWithTag:100];
    
    [leftImageView setImageWithURL:[NSURL URLWithString:image_url]
                  placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                           options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
       usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //标题
    UILabel *titleLab = (UILabel *)[cell.contentView viewWithTag:101];
    titleLab.text = [dict objectForKey:@"title"];
    //副标题
    UILabel *detailLab = (UILabel *)[cell.contentView viewWithTag:102];
    detailLab.text = [dict objectForKey:@"content"];
    //信息来源
    UILabel *fromInfoLab = (UILabel *)[cell.contentView viewWithTag:105];
    if (dict[@"article_source"] && ![dict[@"nickname"] isEqualToString:@""])
        fromInfoLab.text = [NSString stringWithFormat:@"爆料人\t%@",dict[@"nickname"]];
    else
        fromInfoLab.text = dict[@"article_source"];
    //发布时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterFullStyle;
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[dict objectForKey:@"article_date"]];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *todayStr = [dateFormatter stringFromDate:date];
    UILabel *dateLab = (UILabel *)[cell.contentView viewWithTag:104];
    dateLab.text = todayStr;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:newsArr[indexPath.row]];
    AXHSQDynamicDetailViewController *sqDetailVCtr = [[AXHSQDynamicDetailViewController alloc]initWithNibName:nil bundle:nil withDetailDict:dict withTitle:itemTitle];
    [self.navigationController pushViewController:sqDetailVCtr animated:YES];
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
    return 95;
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 1:{
            startIndex = 0;
            idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_list"]];
            NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 10]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[SQDynamicHttpService alloc]init];
            sqHttpSer.strUrl = SheQuDongTai_m7_02;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
            
        }
            break;
        case 2:{
            /*
             剩余条数存储
            NSArray *saveArr = [[NSUserDefaults standardUserDefaults] arrayForKey: @"shengyutiaoshu_article_id"];
             */
            
            
            [dtTableView headerEndRefreshing];
            [dtTableView footerEndRefreshing];
            
            if (isUp) {
                [newsArr removeAllObjects];
            }
            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info"]];
            [newsArr addObjectsFromArray:responArr];
            [dtTableView reloadData];
            
            
            /*
            if (saveArr.count > 0) {
                NSString *article_id=[newsArr[0] objectForKey:@"article_id"];
                NSMutableArray *Array=[[NSMutableArray alloc]init];
                for (int i=0; i<saveArr.count; i++)
                {
                    if (i==WDNum)
                    {
                        [Array addObject:article_id];
                    }
                    else
                    {
                        [Array addObject:saveArr[i]];
                    }
                }
                [[NSUserDefaults standardUserDefaults] setObject:Array  forKey:@"shengyutiaoshu_article_id"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
            }
             */
             
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
@end
