//
//  AXHYHGoodsDetailViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/16.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHYHGoodsDetailViewController.h"
#import "YHGoodsDetailCell.h"

#import "AXHStoreDetailViewController.h"
#import "FuWuYingYongXiangQingViewController.h"
extern NSDictionary *FUWUdtDictionary;
@interface AXHYHGoodsDetailViewController (){
    //请求
    AXHYHGoodsHttpService  *yhGoodsDetailHttpSer;
    //商品id
    NSString *goodsID;
    //商品详情
    NSMutableDictionary *goodsDict;
    //详情列表头视图
    UIView *headView;
}
@end

@implementation AXHYHGoodsDetailViewController
@synthesize yhGoodsDetailTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withGoodsId:(NSString *)goodsId
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        goodsID = goodsId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"商品详情";
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil withColor:[UIColor whiteColor]];
    
    [self yhGoodsInit];
    yhGoodsDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 44) style:UITableViewStylePlain];
    yhGoodsDetailTableView.backgroundColor = [UIColor whiteColor];
    yhGoodsDetailTableView.delegate = self;
    yhGoodsDetailTableView.dataSource = self;
    
    [self.view addSubview:yhGoodsDetailTableView];
    
//    [yhGoodsDetailTableView addHeaderWithTarget:self action:@selector(dataInit)];
//    [yhGoodsDetailTableView addFooterWithTarget:self action:@selector(addData)];
//    [yhGoodsDetailTableView headerBeginRefreshing];
}
-(void)yhGoodsInit{

    NSString *str1= [NSString stringWithFormat:@"{\"id_list\":\[\{\"id\":\"%@\"}]}",goodsID];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    yhGoodsDetailHttpSer = [[AXHYHGoodsHttpService alloc]init];
    yhGoodsDetailHttpSer.strUrl = kYHGOODS_GOODS_DETAIL_URL;
    yhGoodsDetailHttpSer.delegate = self;
    yhGoodsDetailHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [yhGoodsDetailHttpSer beginQuery];
   
}
-(void)backUpper{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)tabHeadView{
    if (!headView) {
        headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, 400)];
        [headView setBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255. blue:241/255. alpha:1]];
        //商品图片
        UIScrollView *imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, 320)];
        imageScrollView.pagingEnabled = YES;
        //因为我们使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条。
        imageScrollView.showsHorizontalScrollIndicator = NO;
        CGSize imageViewsize = imageScrollView.frame.size;
        NSArray *goods_picArr = [NSArray arrayWithArray:goodsDict[@"goods_show"]];
        [imageScrollView setContentSize:CGSizeMake(imageViewsize.width * goods_picArr.count, 0)];
        for (int i = 0; i < goods_picArr.count; i++) {
            UIImageView *goodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageViewsize.width * i, 0, imageViewsize.width, imageViewsize.height)];
            [goodsImageView setImageWithURL:[NSURL URLWithString:goods_picArr[i][@"url_big"]]
                           placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                                    options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
                usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            UILabel *indexPathLab =  [[UILabel alloc]initWithFrame:CGRectMake(250, 270, 40, 40)];
            indexPathLab.backgroundColor = [UIColor lightGrayColor];
            indexPathLab.textAlignment = NSTextAlignmentCenter;
            indexPathLab.layer.masksToBounds = YES;
            indexPathLab.layer.cornerRadius = 20;
            indexPathLab.text = [NSString stringWithFormat:@"%d/%d",i + 1,goods_picArr.count];
            [goodsImageView addSubview:indexPathLab];
            [imageScrollView addSubview:goodsImageView];
            goodsImageView = nil;
            indexPathLab = nil;
        }
        
        //商品信息
        UILabel *goodsLab = [[UILabel alloc]initWithFrame:CGRectMake(10
                                                                     , imageViewsize.height + 10, kViewwidth - 20, 20)];
       
        goodsLab.font = [UIFont systemFontOfSize:16];
        goodsLab.text = goodsDict[@"goods_name"];
         [self labelSizeToFitHeight:goodsLab withWidth:kViewwidth - 20 withy:imageViewsize.height + 10];
        [headView addSubview:imageScrollView];
         [headView addSubview:goodsLab];
       
        //查看图文详情
        UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [checkBtn setFrame:CGRectMake(0, goodsLab.frame.origin.y + goodsLab.frame.size.height + 5 , kViewwidth, 40)];
        [checkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        checkBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [checkBtn setBackgroundColor:[UIColor whiteColor]];
        [checkBtn setTitle:@"查看图文详情" forState:UIControlStateNormal];
      
        //关注
        UIButton *attetnionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [attetnionBtn setFrame:CGRectMake(8, checkBtn.frame.origin.y + 50, 75, 40)];
        [attetnionBtn setImage:[UIImage imageNamed:@"attention"] forState:UIControlStateNormal];
        //加入购物车
        UIButton *intoShoppongCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [intoShoppongCartBtn setFrame:CGRectMake(93,  checkBtn.frame.origin.y + 50, 150, 40)];
        [intoShoppongCartBtn setImage:[UIImage imageNamed:@"into_shooping_cart"] forState:UIControlStateNormal];
        //购物车
        UIButton *shoppongCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shoppongCartBtn setFrame:CGRectMake(253, checkBtn.frame.origin.y + 50, 60, 40)];
        [shoppongCartBtn setImage:[UIImage imageNamed:@"shopping_cart"] forState:UIControlStateNormal];
        
        [headView addSubview:checkBtn];
        [headView addSubview:attetnionBtn];
        [headView addSubview:intoShoppongCartBtn];
        [headView addSubview:shoppongCartBtn];
        CGRect frame = headView.frame;
        frame.size.height = attetnionBtn.frame.origin.y + attetnionBtn.frame.size.height + 10;
        headView.frame = frame;
    }
    
    return headView;
}
#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *storeArr = [NSArray arrayWithArray:goodsDict[@"store_info"]];
    YHGoodsDetailCell *yhGoodsCell = [YHGoodsDetailCell handCellHeight:storeArr[indexPath.row]];
    yhGoodsCell.backgroundColor = [UIColor clearColor];
    UIView *view = (UIView *)[yhGoodsCell.contentView viewWithTag:8];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 1.0;
    view.backgroundColor = [UIColor whiteColor];
    yhGoodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return yhGoodsCell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *storeArr = [NSArray arrayWithArray:goodsDict[@"store_info"]];
    AXHStoreDetailViewController *storeVCtr = [[AXHStoreDetailViewController alloc]initWithNibName:nil bundle:nil withStoreId:storeArr[indexPath.row][@"store_id"]];
    [self.navigationController pushViewController:storeVCtr animated:YES];
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *storeArr = [NSArray arrayWithArray:goodsDict[@"store_info"]];
    return storeArr.count;
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSArray *storeArr = [NSArray arrayWithArray:goodsDict[@"store_info"]];
    return [YHGoodsDetailCell handCellHeight:storeArr[indexPath.row]].frame.size.height;

}

#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 3:{
            if ([yhGoodsDetailHttpSer.responDict[@"ecode"] integerValue] == 1000) {
                goodsDict = [NSMutableDictionary dictionaryWithDictionary:yhGoodsDetailHttpSer.responDict[@"info"][0]];
                
                [yhGoodsDetailTableView setTableHeaderView:[self tabHeadView]];
                [yhGoodsDetailTableView reloadData];
            }else if([yhGoodsDetailHttpSer.responDict[@"ecode"] integerValue] == 3007){
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据!" duration:1.5];
            }else {
                [SVProgressHUD showErrorWithStatus:@"未知错误!" duration:1.5];
            }
            
        }
            break;
            
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
    
}
@end
