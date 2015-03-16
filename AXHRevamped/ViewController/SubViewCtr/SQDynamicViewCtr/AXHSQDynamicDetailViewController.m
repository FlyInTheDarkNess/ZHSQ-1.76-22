//
//  AXHSQDynamicDetailViewController.m
//  HappyFace
//
//  Created by 安雄浩 on 14/12/9.
//  Copyright (c) 2014年 安雄浩的mac. All rights reserved.
//

#define smollFont 0.9
#define defaultFont 1.0
#define bigFont 1.2
#import "AXHSQDynamicDetailViewController.h"
#import "AXHSQForumDetailCell.h"
#import "SQForumHttpService.h"
#import "AXHImageViewController.h"
#import "AXHNewPostViewController.h"

#import <ShareSDK/ShareSDK.h>
@interface AXHSQDynamicDetailViewController (){
    NSDictionary *detailDict;
    SQForumHttpService *sqLtCommentHttpSer;
    UIView *backView;
    
    NSString *zxTitle;
    
    
    //评论内容
    NSMutableArray *commentArr;
    
    //评论ID
    NSArray *idList;
    
    int startIndex;
    
    BOOL isUp;

    /**
     *评论条数
     */
    UILabel *plNumLab;
    /**
     *赞条数
     */
    UILabel *upNumLab;
    /**
     *踩条数
     */
    UILabel *downNumLab;
}

@end

@implementation AXHSQDynamicDetailViewController
@synthesize mainScrollView,headView,contentView;
@synthesize footView;
@synthesize tabbar;
@synthesize tableHeadView;
@synthesize inforTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDetailDict:(NSDictionary *)dict withTitle:(NSString *)title
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        detailDict = dict;
        zxTitle = title;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customRightNarvigationBarWithImageName:@"show_title_details_normal_night" highlightedName:@"show_title_details_normal"];
    
    [self customViewBackImageWithImageName:nil];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kIsNight]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsNight];
    }
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@",zxTitle];
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:kFontType]) {
        [[NSUserDefaults standardUserDefaults] setFloat:1.0 forKey:kFontType];
    }

    
    CGFloat orginHeight = kViewHeight - 60 - 24;
    tabbar = [[tabbarView alloc]initWithFrame:CGRectMake(0,  orginHeight, kViewwidth, 40)];
    tabbar.backgroundColor = [UIColor clearColor];
    tabbar.delegate = self;
    [self.view addSubview:tabbar];
    
    inforTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 84) style:UITableViewStylePlain];
    inforTableView.backgroundColor = [UIColor whiteColor];
    inforTableView.delegate = self;
    inforTableView.dataSource = self;
    [self.view addSubview:inforTableView];
    
  
    [inforTableView addHeaderWithTarget:self action:@selector(inforDataInit)];
    [inforTableView addFooterWithTarget:self action:@selector(inforAddData)];
    [inforTableView headerBeginRefreshing];
    
    commentArr = [NSMutableArray array];
    
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backPostSendSuccess) name:@"backPostSendSuccess" object:nil];
}
-(void)inforDataInit
{
    NSString *str1=[NSString stringWithFormat:@"{\"id\":\"%@\"}",detailDict[@"article_id"]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqLtCommentHttpSer = [[SQForumHttpService alloc]init];
    sqLtCommentHttpSer.strUrl = kSOURCE_NEW_ID_URL;
    sqLtCommentHttpSer.delegate = self;
    sqLtCommentHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqLtCommentHttpSer beginQuery];
    isUp = YES;
}
-(void)inforAddData{
    if (startIndex == idList.count) {
        [inforTableView footerEndRefreshing];
        [inforTableView setFooterHidden:YES];
        [SVProgressHUD showErrorWithStatus:@"没有更多数据了!" duration:1.5];
        return;
    }
    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqLtCommentHttpSer = [[SQForumHttpService alloc]init];
    sqLtCommentHttpSer.strUrl = kSOURCE_NEW_LIST_URL;
    sqLtCommentHttpSer.delegate = self;
    sqLtCommentHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqLtCommentHttpSer beginQuery];
    isUp = NO;
}


-(void)backPostSendSuccess{
    [inforTableView headerBeginRefreshing];
}
-(void)backUpper{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)nextControl{
    
    [self.navigationController.view addSubview:[self settingView]];
}


-(UIView *)settingView{
    if (!backView) {
        backView = [[UIView alloc]initWithFrame:self.navigationController.view.frame];
        backView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.4];
        //添加关闭设置
        UIView *cancelBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 100)];
        cancelBackView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBackView)];
        [cancelBackView addGestureRecognizer:tap];
        [backView addSubview:cancelBackView];
        
        //白色底视图
        UIView *settingSubView = [[UIView alloc]initWithFrame:CGRectMake(0, kViewHeight + 20, kViewwidth, 150)];
        
        settingSubView.backgroundColor = [UIColor whiteColor];
        
        [backView addSubview:settingSubView];
        
        [settingSubView addSubview:[self settingfontSizeView]];
        [settingSubView addSubview:[self settingBackColorView]];
        
        UIButton *tureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tureBtn setFrame:CGRectMake(10, 100, kViewwidth - 20, 40)];
        [tureBtn setTitle:@"完成" forState:UIControlStateNormal];
        [tureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      
        tureBtn.layer.masksToBounds = YES;
        tureBtn.layer.cornerRadius = 1.0;
        
        tureBtn.layer.borderWidth = 0.5;
        tureBtn.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        [tureBtn addTarget:self action:@selector(removeBackView) forControlEvents:UIControlEventTouchUpInside];
        
        [settingSubView addSubview:tureBtn];
        
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = settingSubView.frame;
            frame.origin.y = kViewHeight - 130;
            settingSubView.frame = frame;
        }];
        
    }
    return backView;
}
-(void)removeBackView{
    [backView removeFromSuperview];
}
//设置昼夜交替
-(UIView *)settingBackColorView{
    UIView *changBackColorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, 50)];
    changBackColorView.backgroundColor = [UIColor clearColor];
    UILabel *fontlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    fontlabel.text = @"夜间模式";
    [changBackColorView addSubview:fontlabel];
    
    UISwitch *switCt = [[UISwitch alloc]initWithFrame:CGRectMake(240, 5, 51, 31)];
    [switCt addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
   
    [switCt setOn:[[NSUserDefaults standardUserDefaults] boolForKey:kIsNight] animated:YES];
    [changBackColorView addSubview:switCt];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, changBackColorView.frame.size.height - 0.5, kViewwidth, 0.5)];
    lineView.backgroundColor = [UIColor darkGrayColor];
    [changBackColorView addSubview:lineView];

    return changBackColorView;
    
}
-(void)switchChange:(UISwitch *)swit{
    if (swit.on) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsNight];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsNight];
    }
    [inforTableView beginUpdates];
    [inforTableView setTableHeaderView:[self tableHeadView]];
    [inforTableView reloadData];
    [inforTableView endUpdates];
}
//设置字体切换
-(UIView *)settingfontSizeView{
    UIView *changFontView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, kViewwidth, 50)];
    changFontView.backgroundColor = [UIColor clearColor];
    UILabel *fontlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    fontlabel.text = @"字体大小";
    [changFontView addSubview:fontlabel];
    
    UISegmentedControl *fontSegmented = [[UISegmentedControl alloc]initWithItems:@[ @"小", @"中",@"大" ]];
    fontSegmented.frame = CGRectMake(150, 10, 150, 30);
    if ([[NSUserDefaults standardUserDefaults] floatForKey:kFontType] == smollFont) {
        fontSegmented.selectedSegmentIndex = 0;
    }
   else if ([[NSUserDefaults standardUserDefaults] floatForKey:kFontType] == defaultFont) {
        fontSegmented.selectedSegmentIndex = 1;
    }
    else  {
        fontSegmented.selectedSegmentIndex = 2;
    }
    
    [fontSegmented addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [changFontView addSubview:fontSegmented];
    
    return changFontView;
}
- (void)segmentAction:(UISegmentedControl*)Seg
{
    switch (Seg.selectedSegmentIndex) {
        case 0:

            [[NSUserDefaults standardUserDefaults]setFloat:smollFont forKey:kFontType];
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults]setFloat:defaultFont forKey:kFontType];
            break;
        case 2:
            [[NSUserDefaults standardUserDefaults]setFloat:bigFont forKey:kFontType];
            break;
        default:
            break;
    }
    [inforTableView beginUpdates];
    [inforTableView setTableHeaderView:[self tableHeadView]];
    [inforTableView reloadData];
    [inforTableView endUpdates];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tabbarDelegate -
- (void)touchBtnAtIndex:(NSInteger)index
{
    switch (index) {
        case 1:
        {//评论
        AXHNewPostViewController *postVCtr = [[AXHNewPostViewController alloc]initWithNibName:@"AXHNewPostViewController" bundle:nil withType:PostTypeZXBack withBackDict:detailDict];
        UINavigationController  *NAVc = [[UINavigationController alloc]initWithRootViewController:postVCtr];
        [self.navigationController presentViewController:NAVc animated:YES completion:NULL];
        }
            
            break;
        case 2:{
            //收藏
            NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"business_type\":\"%@\",\"business_id\":\"%@\",\"favorites_title\":\"%@\"}",[SurveyRunTimeData sharedInstance].session,@"1",detailDict[@"article_id"],detailDict[@"title"]];
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
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"APP-icon58" ofType:@"png"];
            
            //构造分享内容
            id<ISSContent> publishContent = [ShareSDK content:nil
                                               defaultContent:nil
                                                        image:[ShareSDK imageWithPath:imagePath]
                                                        title:detailDict[@"title"]
                                                          url:@"http://www.happy-face.cn/"
                                                  description:nil
                                                    mediaType:SSPublishContentMediaTypeNews];
            //创建弹出菜单容器
            id<ISSContainer> container = [ShareSDK container];
//            [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
//            
            //弹出分享菜单
            [ShareSDK showShareActionSheet:container
                                 shareList:nil
                                   content:publishContent
                             statusBarTips:YES
                               authOptions:nil
                              shareOptions:nil
                                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                        
                                        if (state == SSResponseStateSuccess)
                                        {
                                            NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                        }
                                        else if (state == SSResponseStateFail)
                                        {
                                            NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                        }
                                    }];
            
        }
            break;
        case 4:{
            //赞
            NSUUID *uuId = [[UIDevice currentDevice] identifierForVendor];
            NSString *identifierNumber = [uuId UUIDString];
            
            NSString *imei = [identifierNumber substringWithRange:NSMakeRange(0, 20)];
            NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"id\":\"%@\",\"imei\":\"%@\",\"flg\":\"%@\"}",@"",detailDict[@"article_id"],imei,@"1"];
            NSLog(@"%@",str1);
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
            //踩
            NSUUID *uuId = [[UIDevice currentDevice] identifierForVendor];
            NSString *identifierNumber = [uuId UUIDString];
            NSString *imei = [identifierNumber substringWithRange:NSMakeRange(0, 20)];
            NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"id\":\"%@\",\"imei\":\"%@\",\"flg\":\"%@\"}",@"",detailDict[@"article_id"],imei,@"2"];
            NSLog(@"%@",str1);
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
#pragma mark propertyInit
-(UIView *)tableHeadView{
    tableHeadView = nil;
    if (!tableHeadView) {
        tableHeadView = [[UIView alloc]init];

        if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsNight]) {
            tableHeadView.backgroundColor = nightBackViewColor;
        }else{
            tableHeadView.backgroundColor = daytimeBackViewColor;
        }
        [tableHeadView addSubview:[self headViewInit]];
        [tableHeadView addSubview:[self contentViewInit]];
        [tableHeadView addSubview:[self footViewInit]];
        [tableHeadView setFrame:CGRectMake(0, 0, kViewwidth, headView.frame.size.height + contentView.frame.size.height + 40)];
    }
    return tableHeadView;
}

-(UIView *)headViewInit{
    headView = nil;
    if (!headView) {
        headView = [[UIView alloc]init];
        //主标题
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kViewwidth - 20, 20)];
        titleLab.backgroundColor = [UIColor clearColor];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsNight]) {
            titleLab.textColor = nightTextColor;
        }else{
            titleLab.textColor = daytimeTextColor;
        }
        
        titleLab.font = [UIFont boldSystemFontOfSize:18 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType]];
        titleLab.text = detailDict[@"title"];
        
        //title修改为居中对齐
        titleLab.textAlignment = NSTextAlignmentCenter;
        //
        
        
        [self labelSizeToFitHeight:titleLab withWidth:kViewwidth - 20 withy:10];
        //发布工作室
        UILabel *subTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLab.frame.size.height + 20, (kViewwidth - 20)/2, 20)];
        subTitleLab.font = [UIFont systemFontOfSize:13 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType]];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsNight]) {
            subTitleLab.textColor = nightTextColor;
        }else{
            subTitleLab.textColor = [UIColor lightGrayColor];
        }
     
        subTitleLab.backgroundColor = [UIColor clearColor];
        if (detailDict[@"article_source"] && ![detailDict[@"nickname"] isEqualToString:@""])
            
            //修改“爆“为“报” 中间添加空格
            
            subTitleLab.text = [NSString stringWithFormat:@"报料人\t%@",detailDict[@"nickname"]];
        else
            subTitleLab.text = detailDict[@"article_source"];
        //发布时间
        UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(kViewwidth/2, titleLab.frame.size.height + 20, (kViewwidth - 20)/2, 20)];
        timeLab.font = [UIFont systemFontOfSize:13 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType] ];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsNight]) {
            timeLab.textColor = nightTextColor;
        }else{
            timeLab.textColor = [UIColor lightGrayColor];
        }
    
        timeLab.backgroundColor = [UIColor clearColor];
        timeLab.text = detailDict[@"article_date"];
        timeLab.textAlignment  = NSTextAlignmentRight;
        [headView addSubview:titleLab];
        [headView addSubview:subTitleLab];
        [headView addSubview:timeLab];
        
        [headView setFrame:CGRectMake(0, 0, kViewwidth, titleLab.frame.size.height + 50)];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, headView.frame.size.height - 0.5, kViewwidth, 0.5)];
        lineView.backgroundColor = [UIColor darkGrayColor];
        [headView addSubview:lineView];
      
        headView.backgroundColor = [UIColor clearColor];
    }
    return headView;
}
-(UIView *)contentViewInit{
    contentView = nil;
    if (!contentView) {
        contentView = [[UIView alloc]init];
        contentView.backgroundColor = [UIColor clearColor];
        NSArray *picArr = [NSArray arrayWithArray:detailDict[@"pic"]];
        
        float picContentHeight = 0;
        if (picArr.count != 0) {
            for (int i = 0 ; i < picArr.count; i++) {
                NSDictionary *picDict = [NSDictionary dictionaryWithDictionary:picArr[i]];
                float imageHeight = 0;
                if ([picDict[@"pic_url"] length] != 0) {
                    imageHeight = 180;
                    UIImageView *picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10 + picContentHeight, kViewwidth - 30, imageHeight)];
                    
                    [picImageView setImageWithURL:[NSURL URLWithString:picDict[@"pic_url"]]
                                 placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                                          options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
                      usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    
                      picImageView.userInteractionEnabled = YES;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapForImageZoom:)];

                    picImageView.contentMode = UIViewContentModeScaleAspectFit;
                    [picImageView addGestureRecognizer:tap];
                    
                    [contentView addSubview:picImageView];
                    picImageView = nil;
            
                }else if([detailDict[@"video_url"] length] != 0){
                     imageHeight = 180;
                    UIImageView *picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10 + picContentHeight, kViewwidth - 30, imageHeight)];
                    [picImageView setImageWithURL:[NSURL URLWithString:detailDict[@"video_pic_thumbs"]]
                                 placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                                          options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
                      usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    [contentView addSubview:picImageView];
                    
                    UIImageView *videoplayImage = [[UIImageView alloc]initWithFrame:CGRectMake(picImageView.frame.size.width / 2 - 24, picImageView.frame.size.height / 2 - 24, 48, 48)];
                    [videoplayImage setImage:[UIImage imageNamed:@"videoplay0523"] ];
                    [picImageView addSubview:videoplayImage];
                     picImageView.userInteractionEnabled = YES;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapForImage:)];
                    [picImageView addGestureRecognizer:tap];
                }
                UILabel *picContLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kViewwidth - 20, 20)];
                picContLab.backgroundColor = [UIColor clearColor];
                
                
                if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsNight]) {
                    picContLab.textColor = nightTextColor;
                }else{
                    picContLab.textColor = [UIColor darkTextColor];
                }
           
                
            
                picContLab.font = [UIFont systemFontOfSize:17 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType]];
                picContLab.text =   picDict[@"pic_content"];
                
                [self labelSizeToFitHeight:picContLab withWidth:kViewwidth - 20 withy:imageHeight + picContentHeight + 15];
                picContentHeight =  10 + imageHeight  + picContLab.frame.size.height + picContentHeight;
                [contentView addSubview:picContLab];
                picContLab = nil;
            }
        }
        UILabel *detailContentLab = [[UILabel alloc]initWithFrame:CGRectMake(10, picContentHeight + 10, kViewwidth - 20, 20)];
        detailContentLab.font = [UIFont systemFontOfSize:17 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType]];
      
      
  
        
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:detailDict[@"content"]];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:6];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [detailDict[@"content"] length])];
        [detailContentLab setAttributedText:attributedString1];
     
        detailContentLab.backgroundColor = [UIColor clearColor];

        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsNight]) {
            detailContentLab.textColor = nightTextColor;
        }else{
            detailContentLab.textColor = daytimeTextColor;
        }
  

        [self labelSizeToFitHeight:detailContentLab withWidth:kViewwidth - 20 withy:picContentHeight + 10];
        [contentView addSubview:detailContentLab];
        [contentView setFrame:CGRectMake(0, headView.frame.size.height, kViewwidth, picContentHeight + detailContentLab.frame.size.height + 10)];
    }
    return contentView;
}
-(UIView *)footViewInit{
    footView = nil;
    if (!footView) {
        footView = [[UIView alloc]initWithFrame:CGRectMake(0, headView.frame.size.height + contentView.frame.size.height, kViewwidth, 40)];
        plNumLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kViewwidth / 2 - 20, 20)];
        plNumLab.text = [NSString stringWithFormat:@"评论:%d条",idList.count];
        plNumLab.font = [UIFont systemFontOfSize:15 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType]];
        
        upNumLab = [[UILabel alloc]initWithFrame:CGRectMake(kViewwidth/2, 10, 80, 20)];
        upNumLab.text = [NSString stringWithFormat:@"赞:%@",detailDict[@"count4up"]];
          upNumLab.font = [UIFont systemFontOfSize:15 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType]];
        
        downNumLab = [[UILabel alloc]initWithFrame:CGRectMake(kViewwidth - kViewwidth/4, 10, 80, 20)];
        downNumLab.text = [NSString stringWithFormat:@"踩:%@",detailDict[@"count4down"]];
          downNumLab.font = [UIFont systemFontOfSize:15 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType]];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsNight]) {
            plNumLab.textColor = nightTextColor;
            upNumLab.textColor = nightTextColor;
            downNumLab.textColor = nightTextColor;
        }else{
            plNumLab.textColor = daytimeTextColor;
            upNumLab.textColor = daytimeTextColor;
            downNumLab.textColor = daytimeTextColor;
        }
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, kViewwidth, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        
        [footView addSubview:plNumLab];
        [footView addSubview:upNumLab];
        [footView addSubview:downNumLab];
        [footView addSubview:lineView];
    }
    return footView;
}
#pragma mark - UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *flowTraceDict = [NSDictionary dictionaryWithDictionary:commentArr[indexPath.row]];
    AXHSQForumDetailCell *zxForumCell = [AXHSQForumDetailCell handCellHeight:flowTraceDict];
    
 
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsNight]) {
        zxForumCell.backgroundColor = nightBackViewColor;
    }else{
        zxForumCell.backgroundColor = daytimeBackViewColor;
        
    }

    zxForumCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return zxForumCell;
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
       
            if ([sqLtCommentHttpSer.responDict[@"ecode"] integerValue] == 3007) {
                [inforTableView headerEndRefreshing];
                [inforTableView footerEndRefreshing];
                return;
            }
            idList = [NSArray arrayWithArray:sqLtCommentHttpSer.responDict[@"id_list"]];
            
            [inforTableView setTableHeaderView:[self tableHeadView]];
            
            if (idList.count > 0) {
                NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
                NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                sqLtCommentHttpSer = [[SQForumHttpService alloc]init];
                sqLtCommentHttpSer.strUrl = kSOURCE_NEW_LIST_URL;
                sqLtCommentHttpSer.delegate = self;
                sqLtCommentHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                [sqLtCommentHttpSer beginQuery];
            }else{
                [inforTableView headerEndRefreshing];
                [inforTableView footerEndRefreshing];
                return;
            }
            plNumLab.text = [NSString stringWithFormat:@"评论:%d条",idList.count];
        }
            break;
        case 4:{
            [inforTableView headerEndRefreshing];
            [inforTableView footerEndRefreshing];
            if (isUp) {
                [commentArr removeAllObjects];
            }
            NSArray *responArr = [NSArray arrayWithArray:sqLtCommentHttpSer.responDict[@"feedback_info"]];
            for (int i = responArr.count-1; i >= 0; i--) {
                [commentArr addObject:responArr[i]];
            }
            [inforTableView reloadData];
        }
            break;
        case 7:{
            if ([sqLtCommentHttpSer.responDict[@"ecode"] integerValue] == 1000){
                [SurveyRunTimeData showWithCustomView:self.view withMsg:@"收藏成功!"];
            }else if ([sqLtCommentHttpSer.responDict[@"ecode"] integerValue] == 3005){
                [SurveyRunTimeData showWithCustomView:self.view withMsg:@"您的账号可能在其它地点登陆，如非本人操作请及时修改密码!"];
            }else{
                [SurveyRunTimeData showWithCustomView:self.view withMsg:@"收藏失败!"];
            }
        }
            break;
        case 8:{
            if ([sqLtCommentHttpSer.responDict[@"ecode"] integerValue] == 1000){
                [SurveyRunTimeData showWithCustomView:self.view withMsg:[NSString stringWithFormat:@"赞:%@|踩:%@",sqLtCommentHttpSer.responDict[@"count4up"],sqLtCommentHttpSer.responDict[@"count4down"]]];
                 upNumLab.text = [NSString stringWithFormat:@"赞:%@条",sqLtCommentHttpSer.responDict[@"count4up"]];
                 downNumLab.text = [NSString stringWithFormat:@"踩:%@条",sqLtCommentHttpSer.responDict[@"count4down"]];
            }else if ([sqLtCommentHttpSer.responDict[@"ecode"] integerValue] == 5021){
                [SurveyRunTimeData showWithCustomView:self.view withMsg:@"您已经赞/踩过了"];
            }else{
                [SurveyRunTimeData showWithCustomView:self.view withMsg:@"点赞失败"];
            }
        }
            break;
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
   
    [inforTableView headerEndRefreshing];
    [inforTableView footerEndRefreshing];
    [SVProgressHUD dismiss];
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

-(void)tapForImage:(UITapGestureRecognizer *)sender{
    //新闻详情
//    UIImageView *imageView = (UIImageView *)sender.view;
    MoviePlayerViewController *movieVC = [[MoviePlayerViewController alloc]initNetworkMoviePlayerViewControllerWithURL:[NSURL URLWithString:detailDict[@"video_url"]] movieTitle:@""];
    
    movieVC.datasource = self;
    [self presentViewController:movieVC animated:NO completion:nil];
}
-(void)tapForImageZoom:(UITapGestureRecognizer *)sender{
    
    UIImageView *imageView = (UIImageView *)sender.view;

    AXHImageViewController *imageZoomView = [[AXHImageViewController alloc]initWithNibName:nil bundle:nil withImage:imageView.image];
    [self.navigationController pushViewController:imageZoomView animated:YES];
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
