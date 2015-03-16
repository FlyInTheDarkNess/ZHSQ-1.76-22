//
//  AXHBXXViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 15/1/19.
//  Copyright (c) 2015年 lacom. All rights reserved.
//
#define headHeight 40
#define tags 4
#define count_page  500
#define pagenum 1
#import "AXHBXXViewController.h"

#import "AXHBXXHttpService.h"

#import "AXHBXXDetailViewController.h"

#import "AXHBXXNewViewController.h"
@interface AXHBXXViewController (){
    //标头滑动图片
    UIImageView *btnSelectedImage;
    
    NSArray *headBtnArr;
    
    AXHBXXHttpService *httpService;
    
    //加载开始位置
    int startIndex;
    

    NSMutableArray *idList;
    //新闻现场
    NSMutableArray *newsArr;
    NSMutableArray *newsIdList;
    //生活秀
      NSMutableArray *lifeShowArr;
      NSMutableArray *lifeIdList;
    //最美
    NSMutableArray *btCityArr;
      NSMutableArray *btCityIdList;
    //我的发布
    NSMutableArray *userArr;
    NSMutableArray *userIdList;
    //BXXtype
    int type;
}

@end

@implementation AXHBXXViewController
@synthesize scrollRootView;
@synthesize subTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)BXXDataTag:(NSInteger )tag
{
    if (tag == 4) {
        NSString *str1 = [NSString stringWithFormat:@"{\"session\":\"%@\",\"count_per_page\":\"%d\",\"pagenum\":\"%d\"}",[SurveyRunTimeData sharedInstance].session,count_page,pagenum];
        
        NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
        httpService = [[AXHBXXHttpService alloc]init];
        httpService.strUrl = kUSER_NEWS_URL;
        httpService.delegate = self;
        httpService.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
        [httpService beginQuery];
    }else{
        for (UITableView *tableview in scrollRootView.subviews) {
            if ([tableview isKindOfClass:[UITableView class]]) {
                if (tableview.tag == type) {
                    [tableview setFooterHidden:NO];
                }
            }
        }
        NSString *str1 = [NSString stringWithFormat:@"{\"city_id\":\"101\",\"type\":\"%d\",\"count_per_page\":\"%d\",\"pagenum\":\"%d\"}",tag,count_page,pagenum];
        NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
        httpService = [[AXHBXXHttpService alloc]init];
        httpService.strUrl = kFRESH_INFOR_URL;
        httpService.delegate = self;
        httpService.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
        [httpService beginQuery];
    }
}
-(void)addHeaderDataInit{
    [self BXXDataTag:type];
}


-(void)addFooterData{
    switch (type) {
        case 1:
            idList = newsIdList;
            break;
        case 2:
            idList = lifeIdList;
            break;
        case 3:
            idList = btCityIdList;
            break;
        case 4:
            idList = userIdList;
            break;
        default:
            break;
    }
    
    if (startIndex == idList.count) {
        for (UITableView *tableview in scrollRootView.subviews) {
            if ([tableview isKindOfClass:[UITableView class]]) {
                if (tableview.tag == type) {
                    [tableview headerEndRefreshing];
                    [tableview footerEndRefreshing];
                      [tableview setFooterHidden:YES];
                    [tableview reloadData];
                }
            }
        }
        [SVProgressHUD showErrorWithStatus:@"没有更多数据了!" duration:1.5];
        return;
    }
    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 10]];
    
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    
    httpService = [[AXHBXXHttpService alloc]init];
    httpService.strUrl = kFRESH_INFOR_LIST_URL;
    httpService.delegate = self;
    httpService.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [httpService beginQuery];
}
-(void)backUpper{
    //返回方式切换改变返回上一级
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}
-(void)nextControl{
    AXHBXXNewViewController *bxxNweVCtr = [[AXHBXXNewViewController alloc]initWithNibName:@"AXHBXXNewViewController" bundle:nil];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:bxxNweVCtr];
    [self.navigationController presentViewController:naVC animated:YES completion:NULL];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
     [self customRightNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil];
    self.navigationItem.title = @"报新鲜";
    
    
   headBtnArr = [NSArray arrayWithObjects:@"新闻现场",@"生活秀",@"图片莱芜",@"我的发布",nil];
    int btnTag = 2014;
    for (int i = 0; i < tags; i++) {
        
        UIButton *headBtn = [[UIButton alloc]initWithFrame:CGRectMake(kViewwidth/tags * i, 0, kViewwidth/tags, headHeight)];
        headBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [headBtn setBackgroundColor:[UIColor whiteColor]];
        [headBtn setTitle:headBtnArr[i] forState:UIControlStateNormal];
        if (i == 0) {
            [headBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:153/255.0 blue:230/255.0 alpha:1] forState:UIControlStateNormal];
        }else{
            [headBtn setTitleColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
        }
        //添加事件用
        headBtn.tag = btnTag;
        [headBtn addTarget:self action:@selector(btnChange:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:headBtn];
        btnTag++;
    }
    btnSelectedImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, headHeight - 2, kViewwidth/tags, 2)];
    btnSelectedImage.image = [UIImage imageNamed:@"headline"];
    [self.view addSubview:btnSelectedImage];
    
    [self.view addSubview:[self scroViewInit]];
}
-(UIScrollView *)scroViewInit{
    
    if (!scrollRootView) {
        scrollRootView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, kViewwidth, kViewHeight - 84)];
        scrollRootView.pagingEnabled = YES;
        scrollRootView.showsHorizontalScrollIndicator = NO;
        scrollRootView.bounces = NO;
        scrollRootView.tag = 1000;
        scrollRootView.delegate = self;
        scrollRootView.backgroundColor = [UIColor clearColor];
        CGSize size = scrollRootView.frame.size;
        [scrollRootView setContentSize:CGSizeMake(size.width * headBtnArr.count, 0)];
       
        
        for (int i = 1; i <= headBtnArr.count; i++) {
            subTableView  = [[UITableView alloc]initWithFrame:CGRectMake(kViewwidth * (i - 1) , 0, kViewwidth, kViewHeight - 84)];
            subTableView.backgroundColor = [UIColor whiteColor];
            subTableView.tag = i;
            subTableView.delegate = self;
            subTableView.dataSource = self;
      
            [subTableView addHeaderWithTarget:self action:@selector(addHeaderDataInit)];
            if (i == 1) {
                type = 1;
                 [subTableView headerBeginRefreshing];
            }
            [subTableView addFooterWithTarget:self action:@selector(addFooterData)];
            
            [scrollRootView addSubview:subTableView];
            subTableView = nil;
        }
    }
    return scrollRootView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"BXXCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (cell==nil)
    {
        NSArray *nibsArr = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
        cell  = nibsArr[0];
    }
     NSDictionary *dict ;
    switch (tableView.tag) {
        case 1:
            dict = [NSDictionary dictionaryWithDictionary:newsArr[indexPath.row]];
            break;
        case 2:
            dict = [NSDictionary dictionaryWithDictionary:lifeShowArr[indexPath.row]];
            break;
        case 3:
            dict = [NSDictionary dictionaryWithDictionary:btCityArr[indexPath.row]];
            break;
        case 4:
            dict = [NSDictionary dictionaryWithDictionary:userArr[indexPath.row]];

            break;
        default:
            break;
    }
    NSDictionary *detailDict = [NSDictionary dictionaryWithDictionary:dict[@"detail_info"][0]];
    UIImageView *leftImageView = (UIImageView *)[cell.contentView viewWithTag:1];
    
    [leftImageView setImageWithURL:[NSURL URLWithString:detailDict[@"phone_thumbs_url"]]
                  placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                           options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
       usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    UILabel *titleLab = (UILabel *)[cell.contentView viewWithTag:2];
    titleLab.text = [dict objectForKey:@"fnews_title"];
    
    UILabel *timeLab = (UILabel *)[cell.contentView viewWithTag:3];
    timeLab.text = [dict objectForKey:@"fnews_addtime"];
    
    UIImageView *typeImageView = (UIImageView *)[cell.contentView viewWithTag:31];
    
    NSString *typeImage = [NSString stringWithFormat:@"%@",detailDict[@"mediatype"]];
    if ([typeImage isEqualToString:@""]) {
        [typeImageView setImage:[UIImage imageNamed:@"doc"]];
    }else if ([typeImage isEqualToString:@"1"]) {
        [typeImageView setImage:[UIImage imageNamed:@"stats"]];
    }else if ([typeImage isEqualToString:@"2"]) {
        [typeImageView setImage:[UIImage imageNamed:@"sound"]];
    }else if ([typeImage isEqualToString:@"3"]) {
        [typeImageView setImage:[UIImage imageNamed:@"play"]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 1:
             return newsArr.count;
            break;
        case 2:
            return lifeShowArr.count;
            break;
        case 3:
            return btCityArr.count;
            break;
        case 4:
            return userArr.count;
            break;
            
        default:
            break;
    }
     return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict ;
    switch (tableView.tag) {
        case 1:
            dict = [NSDictionary dictionaryWithDictionary:newsArr[indexPath.row]];
            break;
        case 2:
            dict = [NSDictionary dictionaryWithDictionary:lifeShowArr[indexPath.row]];
            break;
        case 3:
            dict = [NSDictionary dictionaryWithDictionary:btCityArr[indexPath.row]];
            break;
        case 4:
            dict = [NSDictionary dictionaryWithDictionary:userArr[indexPath.row]];
            
            break;
        default:
            break;
    }
    AXHBXXDetailViewController *detailVCtr = [[AXHBXXDetailViewController alloc]initWithNibName:nil bundle:nil withDetailDict:dict];
    [self.navigationController pushViewController:detailVCtr animated:YES];
}


#pragma mark Button TouchUpInside
-(void)btnChange:(UIButton *)btn
{
    
    for (UIButton *seletedbtn  in self.view.subviews) {
        if ([seletedbtn isKindOfClass:[UIButton class]]) {
            if (seletedbtn.tag == btn.tag) {
                [seletedbtn setTitleColor:[UIColor colorWithRed:0/255.0 green:153/255.0 blue:230/255.0 alpha:1] forState:UIControlStateNormal];
            }else{
                [seletedbtn setTitleColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
            }
        }
    }
    for (UITableView *tableView in scrollRootView.subviews) {
        if ([tableView isKindOfClass:[UITableView class]]) {
            if (tableView.tag == btn.tag - 2013) {
                 type = tableView.tag;
                switch (tableView.tag) {
                    case 1:
                        if (newsArr.count == 0) {
                            [tableView headerBeginRefreshing];
                        }
                        break;
                    case 2:
                        if (lifeShowArr.count == 0) {
                            [tableView headerBeginRefreshing];
                        }
                        break;
                    case 3:
                        if (btCityArr.count == 0) {
                            [tableView headerBeginRefreshing];
                        }
                        break;
                    case 4:
                        if (userArr.count == 0) {
                            [tableView headerBeginRefreshing];
                        }
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
    [UIView animateWithDuration:0.3 animations:^(void){
        btnSelectedImage.frame = CGRectMake(kViewwidth/tags * (btn.tag - 2014), headHeight - 2, kViewwidth/tags, 2);
    }completion:NULL];
    [scrollRootView setContentOffset:CGPointMake(kViewwidth * (btn.tag - 2014), 0) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.tag == 1000) {
        [UIView animateWithDuration:0.3 animations:^(void){
            btnSelectedImage.frame = CGRectMake(kViewwidth/tags * (scrollView.contentOffset.x / kViewwidth), headHeight - 2, kViewwidth/tags, 2);
        }completion:^(BOOL finished){
            if (finished) {
    
                int index = scrollView.contentOffset.x / kViewwidth;
                for (UITableView *tableView in scrollRootView.subviews) {
                    if ([tableView isKindOfClass:[UITableView class]]) {

                        if (tableView.tag == index + 1) {
                            type = index + 1;
                            
                            switch (type) {
                                case 1:
                                    if (newsArr.count == 0) {
                                         [tableView headerBeginRefreshing];
                                    }
                                    break;
                                case 2:
                                    if (lifeShowArr.count == 0) {
                                        [tableView headerBeginRefreshing];
                                    }
                                    break;
                                case 3:
                                    if (btCityArr.count == 0) {
                                        [tableView headerBeginRefreshing];
                                    }
                                    break;
                                case 4:
                                    if (userArr.count == 0) {
                                        [tableView headerBeginRefreshing];
                                    }
                                    break;
                                    
                                default:
                                    break;
                            }
                           
                        }
                    }
                }
                for (UIButton *seletedbtn  in self.view.subviews) {
                    if ([seletedbtn isKindOfClass:[UIButton class]]) {
                        if (seletedbtn.tag == scrollView.contentOffset.x / kViewwidth + 2014) {
                            [seletedbtn setTitleColor:[UIColor colorWithRed:0/255.0 green:153/255.0 blue:230/255.0 alpha:1] forState:UIControlStateNormal];
                        }else{
                            [seletedbtn setTitleColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
                        }
                    }
                }
                
            }
        }];

    }
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 1:{
            startIndex = 0;
            idList = [NSMutableArray arrayWithArray:httpService.responDict[@"bxx"][0][@"id_list"]];
            switch (type) {
                case 1:
                    newsIdList = [NSMutableArray arrayWithArray:idList];
                       newsArr = [[NSMutableArray alloc]init];
                    break;
                case 2:
                    lifeIdList = [NSMutableArray arrayWithArray:idList];
                      lifeShowArr = [[NSMutableArray alloc]init];
                    break;
                case 3:
                    btCityIdList = [NSMutableArray arrayWithArray:idList];
                     btCityArr = [[NSMutableArray alloc]init];
                    break;
                case 4:
                    userIdList = [NSMutableArray arrayWithArray:idList];
                    userArr = [[NSMutableArray alloc]init];
                    break;
                    
                default:
                    break;
            };
         
            NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 10]];
            
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            
            httpService = [[AXHBXXHttpService alloc]init];
            httpService.strUrl = kFRESH_INFOR_LIST_URL;
            httpService.delegate = self;
            httpService.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [httpService beginQuery];
        }
            break;
        case 2:{
       
            NSArray *arr = [NSArray arrayWithArray:httpService.responDict[@"Info"]];
            switch (type) {
                case 1:
                      [newsArr addObjectsFromArray:arr];
                    break;
                case 2:[lifeShowArr addObjectsFromArray:arr];
                    break;
                 case 3:
                    [btCityArr addObjectsFromArray:arr];
                    break;
                case 4:
                    [userArr addObjectsFromArray:arr];
                    break;
                default:
                    break;
            }
          
            for (UITableView *tableview in scrollRootView.subviews) {
                if ([tableview isKindOfClass:[UITableView class]]) {
                    [tableview headerEndRefreshing];
                     [tableview footerEndRefreshing];
                    [tableview reloadData];
                }
            }
          
        }
            break;
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
    for (UITableView *tableview in scrollRootView.subviews) {
        if ([tableview isKindOfClass:[UITableView class]]) {
            [tableview headerEndRefreshing];
            [tableview footerEndRefreshing];
            [tableview reloadData];
        }
    }
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
