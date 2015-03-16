
//
//  AXHStoreDetailViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/21.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHStoreDetailViewController.h"

@interface AXHStoreDetailViewController (){
    AXHYHGoodsHttpService *storeHttpSer;
    //商家ID
    NSString *storeId;
    //接口数据
    NSMutableDictionary *storeDict;
    
    NSMutableArray *commentArr;
    
    //详情列表头视图
    UIView *headView;
}
@end

@implementation AXHStoreDetailViewController
@synthesize detaidTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withStoreId:(NSString *)storeID
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        storeId = storeID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil withColor:[UIColor colorWithRed:225/255.0 green:224/255.0 blue:222/255.0 alpha:1]];
    self.navigationItem.title = @"商家详情";
    
    
    detaidTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 84) style:UITableViewStylePlain];
    detaidTableView.backgroundColor = [UIColor whiteColor];
    detaidTableView.delegate = self;
    detaidTableView.dataSource = self;
    
    [self.view addSubview:detaidTableView];
    
    [detaidTableView addHeaderWithTarget:self action:@selector(storeDataInit)];
//    [detaidTableView addFooterWithTarget:self action:@selector(addCommentData)];
    [detaidTableView headerBeginRefreshing];

    
}
-(void)backUpper{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)storeDataInit{
   
    NSString *str1= [NSString stringWithFormat:@"{\"id_list\":\[\{\"id\":\"%@\"}]}",storeId];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    storeHttpSer = [[AXHYHGoodsHttpService alloc]init];
    storeHttpSer.strUrl = kSTORE_DETAIL_URL;
    storeHttpSer.delegate = self;
    storeHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [storeHttpSer beginQuery];
}
-(void)addCommentData{
    
}

-(UIView *)tabHeadView{
    if (!headView) {
        headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, 200)];
        headView.backgroundColor = [UIColor colorWithRed:225/255.0 green:224/255.0 blue:222/255.0 alpha:1];
        //商家名称
        UILabel *storeNameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kViewwidth - 20, 20)];
        storeNameLab.backgroundColor = [UIColor clearColor];
        storeNameLab.font = [UIFont boldSystemFontOfSize:18];
        storeNameLab.text = storeDict[@"store_name"];
        //推荐级别
        UILabel *recommendLevelLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 75, 20)];
        recommendLevelLab.backgroundColor = [UIColor clearColor];
        recommendLevelLab.font = [UIFont boldSystemFontOfSize:15];
        recommendLevelLab.text = @"推荐级别 :";
        RatingView *starView = [[RatingView alloc]initWithFrame:CGRectMake(90, 47, 150, 20)];
        [starView setImagesDeselected:@"0.png" partlySelected:@"1.png" fullSelected:@"2.png" andDelegate:nil];
        [starView displayRating:[storeDict[@"star_level"] floatValue]];
        starView.userInteractionEnabled = NO;
        //地址
        UILabel *storeAddressLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, kViewwidth - 20, 20)];
        storeAddressLab.backgroundColor = [UIColor clearColor];
        storeAddressLab.font = [UIFont boldSystemFontOfSize:15];
        storeAddressLab.text = [NSString stringWithFormat:@"地址 : %@",storeDict[@"store_address"]];
         //电话
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"电话 : %@",  storeDict[@"phone"]]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,4)];
          [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(4,str.length - 4)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, str.length)];
       
        UILabel *phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, kViewwidth - 20, 20)];
        phoneLab.backgroundColor = [UIColor clearColor];
        phoneLab.attributedText = str;
        //店家详情
        NSMutableAttributedString *storeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"店家详情 : \n%@",  storeDict[@"describtion"]]];
     
        [storeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, 6)];
         [storeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(6, storeStr.length - 6)];
        UILabel *storeDetailLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 140, kViewwidth - 20, 20)];
        storeDetailLab.attributedText = storeStr;
        [self labelSizeToFitHeight:storeDetailLab withWidth:kViewwidth - 20 withy:140];
        //主要经营项目
        UILabel *jyLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 150 + storeDetailLab.frame.size.height , kViewwidth - 20, 20)];
        jyLab.backgroundColor = [UIColor clearColor];
        jyLab.font = [UIFont boldSystemFontOfSize:20];
        jyLab.text = @"主要经营项目";
        NSArray *goodsArr = [NSArray arrayWithArray:storeDict[@"goods"]];
        for (int i = 0; i < goodsArr.count; i++) {
            UIImageView *goodsBackView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 180 + storeDetailLab.frame.size.height + 50 * i, kViewwidth - 20, 50)];
                [goodsBackView setImage:[[UIImage imageNamed:@"collection_cell_bg"] stretchableImageWithLeftCapWidth:106/4 topCapHeight:106/4]];
            UIImageView *goodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 46, 46)];
            [goodsImageView setImageWithURL:[NSURL URLWithString:goodsArr[i][@"image_url"]]
                            placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                                     options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
                 usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            UILabel *goodsLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 15, goodsBackView.frame.size.width - 60, 20)];
            goodsLab.backgroundColor = [UIColor clearColor];
            goodsLab.text = goodsArr[i][@"goods_name"];
            
            [goodsBackView addSubview:goodsImageView];
            [goodsBackView addSubview:goodsLab];
            [headView addSubview:goodsBackView];
            goodsBackView = nil;
            
        }
        //反馈评论
        UILabel *commenLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 180 + storeDetailLab.frame.size.height + 50 * goodsArr.count, kViewwidth - 20, 20)];
        commenLab.backgroundColor = [UIColor clearColor];
        commenLab.text = [NSString stringWithFormat:@"反馈评论: %d 条",commentArr.count];
        
        [headView addSubview:storeDetailLab];
        [headView addSubview:storeNameLab];
        [headView addSubview:starView];
        [headView addSubview:recommendLevelLab];
        [headView addSubview:storeAddressLab];
        [headView addSubview:phoneLab];
        [headView addSubview:jyLab];
        [headView addSubview:commenLab];
        CGRect frame = headView.frame;
        frame.size.height = 210 + storeDetailLab.frame.size.height + 50 * goodsArr.count;
        headView.frame = frame;
    }
    
    return headView;

}
#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
    
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
    return 60;
}

#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 6:{
            if ([storeHttpSer.responDict[@"ecode"] integerValue] == 1000) {
                storeDict = [NSMutableDictionary dictionaryWithDictionary:storeHttpSer.responDict[@"wufu_info"][0]];
           
                [detaidTableView setTableHeaderView:[self tabHeadView]];
                [detaidTableView reloadData];
                
                [detaidTableView headerEndRefreshing];
                [detaidTableView footerEndRefreshing];
            }else  if ([storeHttpSer.responDict[@"ecode"] integerValue] == 3007){
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据!" duration:1.5];
            }else{
                [SVProgressHUD showErrorWithStatus:@"未知错误!" duration:1.5];
            }
           
        }
            break;
            
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
    [detaidTableView headerEndRefreshing];
    [detaidTableView footerEndRefreshing];
}




@end
