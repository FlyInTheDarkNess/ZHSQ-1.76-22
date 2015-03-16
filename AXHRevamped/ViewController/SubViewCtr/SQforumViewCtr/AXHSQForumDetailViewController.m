//
//  AXHSQForumDetailViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHSQForumDetailViewController.h"
#import "AXHSQForumDetailCell.h"
#import "CustomMethod.h"

#import "AXHNewPostViewController.h"
@interface AXHSQForumDetailViewController (){
    SQForumHttpService *sqLtCommentHttpSer;
    //评论内容
    NSMutableArray *commentArr;
    
    //评论ID
    NSArray *idList;
    
    int startIndex;
    BOOL isUp;
    
    NSDictionary *detailDict;
    
    
    //tableview头视图
    UIView *headView;
}

@end

@implementation AXHSQForumDetailViewController
@synthesize ltInforTableView;
@synthesize tabbar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDetailDict:(NSDictionary *)dict
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        detailDict = dict;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil];
    self.navigationItem.title = @"论坛详情";
    
     CGFloat orginHeight = kViewHeight - 60 - 24;
    tabbar = [[tabbarView alloc]initWithFrame:CGRectMake(0,  orginHeight, kViewwidth, 40)];
    tabbar.backgroundColor = [UIColor clearColor];
    tabbar.delegate = self;
    [self.view addSubview:tabbar];
    
    ltInforTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 84) style:UITableViewStylePlain];
    ltInforTableView.backgroundColor = [UIColor whiteColor];
    ltInforTableView.delegate = self;
    
    ltInforTableView.dataSource = self;
    [self.view addSubview:ltInforTableView];
    
    [ltInforTableView addHeaderWithTarget:self action:@selector(ltInforDataInit)];
    [ltInforTableView addFooterWithTarget:self action:@selector(ltInforAddData)];
    [ltInforTableView headerBeginRefreshing];
    //    ltInforTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    commentArr = [NSMutableArray array];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backPostSendSuccess) name:@"backPostSendSuccess" object:nil];
}
-(void)backUpper{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backPostSendSuccess{
        [ltInforTableView headerBeginRefreshing];
}
#pragma mark - tabbarDelegate -
- (void)touchBtnAtIndex:(NSInteger)index
{
    switch (index) {
        case 1:
        {//评论
            AXHNewPostViewController *postVCtr = [[AXHNewPostViewController alloc]initWithNibName:@"AXHNewPostViewController" bundle:nil withType:PostTypeBack withBackDict:detailDict];
            UINavigationController  *NAVc = [[UINavigationController alloc]initWithRootViewController:postVCtr];
            [self.navigationController presentViewController:NAVc animated:YES completion:NULL];
        }

            break;
        case 2:{
            //收藏
            NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"business_type\":\"%@\",\"business_id\":\"%@\",\"favorites_title\":\"%@\"}",[SurveyRunTimeData sharedInstance].session,@"4",detailDict[@"id"],detailDict[@"title"]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqLtCommentHttpSer = [[SQForumHttpService alloc]init];
            sqLtCommentHttpSer.strUrl = kUSER_BUSINESS_URL;
            sqLtCommentHttpSer.delegate = self;
            sqLtCommentHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqLtCommentHttpSer beginQuery];
            [SVProgressHUD showWithStatus:@"正在存储至我的收藏..."];
            
        }
            break;
        case 3:{
            //分享
            [SurveyRunTimeData showWithCustomView:self.view withMsg:@"敬请期待!"];
        }
            break;
        case 4:{
            //赞
            NSUUID *uuId = [[UIDevice currentDevice] identifierForVendor];
            NSString *identifierNumber = [uuId UUIDString];
            NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"id\":\"%@\",\"imei\":\"%@\",\"flg\":\"%@\"}",@"",detailDict[@"id"],identifierNumber,@"1"];
       
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqLtCommentHttpSer = [[SQForumHttpService alloc]init];
            sqLtCommentHttpSer.strUrl = kUSER_NEWS_UPORDOWN_URL;
            sqLtCommentHttpSer.delegate = self;
            sqLtCommentHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqLtCommentHttpSer beginQuery];
            [SVProgressHUD show];
        }
            break;
        case 5:{
            NSUUID *uuId = [[UIDevice currentDevice] identifierForVendor];
            NSString *identifierNumber = [uuId UUIDString];
            //踩
            NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"id\":\"%@\",\"imei\":\"%@\",\"flg\":\"%@\"}",@"",detailDict[@"id"],identifierNumber,@"2"];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqLtCommentHttpSer = [[SQForumHttpService alloc]init];
            sqLtCommentHttpSer.strUrl = kUSER_NEWS_UPORDOWN_URL;
            sqLtCommentHttpSer.delegate = self;
            sqLtCommentHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqLtCommentHttpSer beginQuery];
            [SVProgressHUD show];
        }
            break;
        default:
            break;
    }
}
-(void)ltInforDataInit
{
    NSString *str1=[NSString stringWithFormat:@"{\"forum_id\":\"%@\"}",detailDict[@"id"]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqLtCommentHttpSer = [[SQForumHttpService alloc]init];
    sqLtCommentHttpSer.strUrl = SheQuHuDong_m10_04;
    sqLtCommentHttpSer.delegate = self;
    sqLtCommentHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqLtCommentHttpSer beginQuery];
    isUp = YES;
}
-(void)ltInforAddData{
    if (startIndex == idList.count) {
        [ltInforTableView footerEndRefreshing];
        [ltInforTableView setFooterHidden:YES];
        [SVProgressHUD showErrorWithStatus:@"没有更多数据了!" duration:1.5];
        return;
    }
    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqLtCommentHttpSer = [[SQForumHttpService alloc]init];
    sqLtCommentHttpSer.strUrl = SheQuHuDong_m10_05;
    sqLtCommentHttpSer.delegate = self;
    sqLtCommentHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqLtCommentHttpSer beginQuery];
    isUp = NO;
}

-(UIView *)tabHeadView{
    if (!headView) {
        headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, 100)];
        [headView setBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]];
        //头像
        UIImageView *peopleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        peopleImageView.layer.masksToBounds = YES;
        peopleImageView.layer.cornerRadius = 20.0;
        peopleImageView.layer.borderWidth = 1.0;
        peopleImageView.layer.borderColor = [[UIColor redColor] CGColor];
        [peopleImageView setImageWithURL:[NSURL URLWithString:detailDict[@"creator_icon"]]
                        placeholderImage:[UIImage imageNamed:@"m_personcenter"]
                                 options:SDWebImageRetryFailed
             usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //用户名字
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(65, 10, 210, 20)];;
        if (![detailDict[@"nickname"] isEqualToString:@""]) {
            nameLab.text = detailDict[@"nickname"];
        }else if(![detailDict[@"mobile_phone"] isEqualToString:@""]){
            NSString *nameMobile = [NSString stringWithFormat:@"%@",detailDict[@"mobile_phone"]];
            nameMobile =  [nameMobile stringByReplacingCharactersInRange:NSMakeRange(nameMobile.length-8, 4) withString:@"****"];
            nameLab.text = nameMobile;
        }else{
            nameLab.text = @"匿名";
        }
        nameLab.textColor = [UIColor redColor];
        nameLab.font = [UIFont boldSystemFontOfSize:16];
        //日期
        UILabel *dateLab = [[UILabel alloc]initWithFrame:CGRectMake(65, 30, 210, 20)];
        dateLab.text = [NSString stringWithFormat:@"%@",detailDict[@"create_time"]];
        dateLab.textColor = [UIColor lightGrayColor];
         dateLab.font = [UIFont boldSystemFontOfSize:14];
        //内容
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kViewwidth, 20)];
        contentView.backgroundColor = [UIColor whiteColor];
        //内容
        OHAttributedLabel *contentLab = [[OHAttributedLabel alloc]initWithFrame:CGRectMake(10, 10, kViewwidth - 20, 20)];
        NSString *detailStr = [CustomMethod escapedString:detailDict[@"content"]];
        [SurveyRunTimeData creatAttributedLabel:detailStr Label:contentLab withFont:15];
        contentLab.textColor = [UIColor blackColor];
        [CustomMethod drawImage:contentLab];
        
        CGRect contectViewFrame = contentView.frame;
        contectViewFrame.size.height = contentLab.frame.size.height +20;
        contentView.frame = contectViewFrame;
        [contentView addSubview:contentLab];
        
        [headView addSubview:peopleImageView];
        [headView addSubview:nameLab];
        [headView addSubview:dateLab];
        [headView addSubview:contentView];
    
        float picContentHeight = contentView.frame.size.height + 55;
        
        UILabel *plLab = [[UILabel alloc]initWithFrame:CGRectMake(10,  picContentHeight + 12, kViewwidth - 20, 20)];
        plLab.text = [NSString stringWithFormat:@"反馈评论:%@条", detailDict[@"feedback_num"]];
        [headView addSubview:plLab];
        
        
        NSArray *picArr = [NSArray arrayWithArray:detailDict[@"images"]];
        if (picArr.count != 0) {
            for (int i = 0 ; i < picArr.count; i++) {
                NSDictionary *picDict = [NSDictionary dictionaryWithDictionary:picArr[i]];
                if ([picDict[@"pic_url"] length] != 0) {

                    if (i == 0) {
                        CGRect headViewFrame = headView.frame;
                        headViewFrame.size.height = plLab.frame.origin.y + 30 ;
                        headView.frame =  headViewFrame;
                    }
                UIImageView *sizeView = [[UIImageView alloc]initWithFrame:CGRectMake(10, contentView.frame.origin.y + contentView.frame.size.height + 5, kViewwidth - 20, 0)];
                [headView addSubview:sizeView];
                [sizeView setImageWithURL:[NSURL URLWithString:picDict[@"pic_url"]]
                         placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                                  options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    if (!error) {
                        UIImageView *picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10,headView.frame.size.height - 20 + 10 , kViewwidth - 20, image.size.height * ((kViewwidth - 20) / image.size.width))];
                    
                        [picImageView setImage:image];
                       
                        [headView addSubview:picImageView];
                        
                        float imageViewHeight = image.size.height * ((kViewwidth - 20) / image.size.width);
                        CGRect headViewFrame = headView.frame;
                        headViewFrame.size.height =  headViewFrame.size.height + imageViewHeight + 15;
                        headView.frame =  headViewFrame;
                        
                        CGRect plLabFrame = plLab.frame;
                        plLabFrame.origin.y =  headView.frame.size.height - 22;
                        plLab.frame =  plLabFrame;
                        //重新刷tabheader高度
                        [ltInforTableView beginUpdates];
                        [ltInforTableView setTableHeaderView:headView];
                        [ltInforTableView endUpdates];
                        picImageView = nil;
                    }
                    
                } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            }
            }
        }
        CGRect headViewFrame = headView.frame;
        headViewFrame.size.height = plLab.frame.origin.y + 25;
        headView.frame =  headViewFrame;
    }
    return headView;
}
#pragma mark - UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *flowTraceDict = [NSDictionary dictionaryWithDictionary:commentArr[indexPath.row]];
    AXHSQForumDetailCell *sqForumCell = [AXHSQForumDetailCell handCellHeight:flowTraceDict];
    sqForumCell.backgroundColor = [UIColor clearColor];
    UIView *view = (UIView *)[sqForumCell.contentView viewWithTag:8];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 1.0;
    view.backgroundColor = [UIColor whiteColor];
    sqForumCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return sqForumCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return commentArr.count;
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *flowTraceDict = [NSDictionary dictionaryWithDictionary:commentArr[indexPath.row]];
    return [AXHSQForumDetailCell handCellHeight:flowTraceDict].frame.size.height;
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
     [SVProgressHUD dismiss];
    switch (tag) {
        case 3:{
            startIndex = 0;
            [ltInforTableView setTableHeaderView:[self tabHeadView]];
            if ([sqLtCommentHttpSer.responDict[@"ecode"] integerValue] == 3007) {
                [ltInforTableView headerEndRefreshing];
                [ltInforTableView footerEndRefreshing];
                return;
            }
            idList = [NSArray arrayWithArray:sqLtCommentHttpSer.responDict[@"id_list"]];
            NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqLtCommentHttpSer = [[SQForumHttpService alloc]init];
            sqLtCommentHttpSer.strUrl = SheQuHuDong_m10_05;
            
            sqLtCommentHttpSer.delegate = self;
            sqLtCommentHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqLtCommentHttpSer beginQuery];
            
        }
            break;
        case 4:{
     
            [ltInforTableView headerEndRefreshing];
            [ltInforTableView footerEndRefreshing];
            
            if (isUp) {
                [commentArr removeAllObjects];
            }
            NSArray *responArr = [NSArray arrayWithArray:sqLtCommentHttpSer.responDict[@"feedback_info"]];
            for (int i = responArr.count-1; i >= 0; i--) {
                    [commentArr addObject:responArr[i]];

            }
  
            [ltInforTableView reloadData];
            
        }
            break;
        case 7:{
            if ([sqLtCommentHttpSer.responDict[@"ecode"] integerValue] == 1000){
                [SurveyRunTimeData showWithCustomView:self.view withMsg:@"收藏成功"];
            }else{
                 [SurveyRunTimeData showWithCustomView:self.view withMsg:@"收藏失败"];
            }
        }
            break;
        case 8:{
            if ([sqLtCommentHttpSer.responDict[@"ecode"] integerValue] == 1000){
                [SurveyRunTimeData showWithCustomView:self.view withMsg:[NSString stringWithFormat:@"赞:%@|踩:%@",sqLtCommentHttpSer.responDict[@"count4up"],sqLtCommentHttpSer.responDict[@"count4down"]]];
            }else if ([sqLtCommentHttpSer.responDict[@"ecode"] integerValue] == 5021){
                [SurveyRunTimeData showWithCustomView:self.view withMsg:@"您已经赞/踩过了"];
            }else{
                [SurveyRunTimeData showWithCustomView:self.view withMsg:@"点赞/踩失败"];
            }
        }
            break;
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
     [SVProgressHUD dismiss];
    [ltInforTableView headerEndRefreshing];
    [ltInforTableView footerEndRefreshing];
}

#pragma mark ArrtoStr
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



@end
