//
//  GroupBuyingDetailViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-2-11.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "GroupBuyingDetailViewController.h"
#import "RegistrationAndLoginAndFindHttpService.h"
#import "ZHMyMessageViewController.h"
#import "AXHHttpUrl.h"
#import "AXHVendors.h"
#import "SurveyRunTimeData.h"
extern NSString *Session;
extern NSDictionary *GroupBuyingDic;
extern NSString *mobel_iphone;
@interface GroupBuyingDetailViewController ()
{
    //请求
    RegistrationAndLoginAndFindHttpService  *yhGoodsDetailHttpSer;
    //商品id
    NSString *goodsID;
    //商品详情
    NSMutableDictionary *goodsDict;
    //详情列表头视图
    UIView *headView;
}

@end

@implementation GroupBuyingDetailViewController
@synthesize tgGoodsDetailTableView,goodsType;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(NSDictionary *)type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        goodsType = type;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"团购商品详情";
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil withColor:[UIColor whiteColor]];
    
    [self yhGoodsInit];
    tgGoodsDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 44) style:UITableViewStylePlain];
    tgGoodsDetailTableView.backgroundColor = [UIColor whiteColor];
    tgGoodsDetailTableView.delegate = self;
    tgGoodsDetailTableView.dataSource = self;
    
    [self.view addSubview:tgGoodsDetailTableView];

}
-(void)yhGoodsInit{
    
   // NSString *str1 [NSString stringWithFormat:@"{\"session\":\"%@\",\"id_array\":\[%@]}",Session,GroupBuyingDic];
    
    NSString *str1=@"{\"session\":\"xxx\",\"id_array\":[{\"store_id\":\"101\",\"goods_id\":\"136\"}]}";
    NSLog(@"canshu   %@",str1);
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    yhGoodsDetailHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
    yhGoodsDetailHttpSer.strUrl = TuanGou_m40_12;
    yhGoodsDetailHttpSer.delegate = self;
    yhGoodsDetailHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [yhGoodsDetailHttpSer beginQuery];
    
}
-(void)backUpper{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
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
        UILabel *goodsLab = [[UILabel alloc]initWithFrame:CGRectMake(10, imageViewsize.height + 10, kViewwidth - 20, 20)];
        
        goodsLab.font = [UIFont systemFontOfSize:16];
        goodsLab.text = goodsDict[@"goods_name"];
        [self labelSizeToFitHeight:goodsLab withWidth:kViewwidth - 20 withy:imageViewsize.height + 10];
        [headView addSubview:imageScrollView];
        [headView addSubview:goodsLab];
        //单价
        UILabel *price=[[UILabel alloc]initWithFrame:CGRectMake(10, imageViewsize.height + 35, 300, 20)];
        price.text=[NSString stringWithFormat:@"￥%@",goodsDict[@"price3"]];
        price.textColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        price.font=[UIFont systemFontOfSize:18];
        [headView addSubview:price];
        //数量
        
        i=1;
        UILabel *num=[[UILabel alloc]initWithFrame:CGRectMake(10, imageViewsize.height + 70, 40, 20)];
        num.text=@"数量";
        num.font=[UIFont systemFontOfSize:18];
        [headView addSubview:num];
        
        UIButton *jian = [UIButton buttonWithType:UIButtonTypeSystem];
        [jian setFrame:CGRectMake(60,imageViewsize.height + 70, 20, 20)];
        [jian setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        jian.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [jian setBackgroundColor:[UIColor redColor]];
        [jian addTarget:self action:@selector(jian) forControlEvents:UIControlEventTouchUpInside];
        [jian setTitle:@"-" forState:UIControlStateNormal];
        [headView addSubview:jian];

        num_label=[[UILabel alloc]initWithFrame:CGRectMake(80, imageViewsize.height + 70, 50, 20)];
        num_label.text=[NSString stringWithFormat:@"%d",i];
        num_label.textAlignment=NSTextAlignmentCenter;
        num_label.textColor=[UIColor redColor];
        num_label.font=[UIFont systemFontOfSize:16];
        [headView addSubview:num_label];

        UIButton *jia = [UIButton buttonWithType:UIButtonTypeSystem];
        [jia setFrame:CGRectMake(130,imageViewsize.height + 70, 20, 20)];
        [jia setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        jia.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [jia setBackgroundColor:[UIColor redColor]];
        [jia addTarget:self action:@selector(jia) forControlEvents:UIControlEventTouchUpInside];
        [jia setTitle:@"+" forState:UIControlStateNormal];
        [headView addSubview:jia];
        
        UIButton *lijituangou = [UIButton buttonWithType:UIButtonTypeSystem];
        [lijituangou setFrame:CGRectMake(180,imageViewsize.height + 70, 100, 20)];
        [lijituangou setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        lijituangou.titleLabel.font = [UIFont systemFontOfSize:18];
        [lijituangou setBackgroundColor:[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1]];
        lijituangou.layer.masksToBounds = YES;
        lijituangou.layer.cornerRadius = 6;
        [lijituangou addTarget:self action:@selector(lijituangou) forControlEvents:UIControlEventTouchUpInside];
        [lijituangou setTitle:@"立即团购" forState:UIControlStateNormal];
        [headView addSubview:lijituangou];
        y=YES;

        
        //查看图文详情
        UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [checkBtn setFrame:CGRectMake(0, goodsLab.frame.origin.y + goodsLab.frame.size.height + 85 , kViewwidth, 40)];
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
        g=attetnionBtn.frame.origin.y + attetnionBtn.frame.size.height + 10;
    }
    
    return headView;
}
-(void)jian
{
    if (i>1)
    {
        i=i-1;
        num_label.text=[NSString stringWithFormat:@"%d",i];
    }
}
-(void)jia
{
    i=i+1;
    num_label.text=[NSString stringWithFormat:@"%d",i];

}
-(void)lijituangou
{
    if (y==YES)
    {
        y=NO;
        NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"store_id\":\"%@\",\"goods_id\":\"%@\",\"count\":\"%@\",\"price\":\"%@\",\"mobile_phone\":\"%@\"}",Session,goodsDict[@"store_id"],goodsDict[@"goods_id"],num_label.text,goodsDict[@"price3"],mobel_iphone];
        NSLog(@"canshu   %@",str1);
        NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
        yhGoodsDetailHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
        yhGoodsDetailHttpSer.strUrl = TuanGou_m40_13;
        yhGoodsDetailHttpSer.delegate = self;
        yhGoodsDetailHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
        [yhGoodsDetailHttpSer beginQuery];

    }
}
#pragma mark - UITableView Delegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *storeArr = [NSArray arrayWithArray:goodsDict[@"store_info"]];
//    AXHStoreDetailViewController *storeVCtr = [[AXHStoreDetailViewController alloc]initWithNibName:nil bundle:nil withStoreId:storeArr[indexPath.row][@"store_id"]];
//    [self.navigationController pushViewController:storeVCtr animated:YES];
    
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
   
    return g;
}

#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 10:{
          //  NSLog(@"%@",yhGoodsDetailHttpSer.responDict);
            if ([yhGoodsDetailHttpSer.responDict[@"ecode"] integerValue] == 1000) {
                goodsDict = [NSMutableDictionary dictionaryWithDictionary:yhGoodsDetailHttpSer.responDict[@"info"][0]];
                
                [tgGoodsDetailTableView setTableHeaderView:[self tabHeadView]];
                [tgGoodsDetailTableView reloadData];
            }else if([yhGoodsDetailHttpSer.responDict[@"ecode"] integerValue] == 3007){
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据!" duration:1.5];
            }else {
                [SVProgressHUD showErrorWithStatus:@"未知错误!" duration:1.5];
            }
            
        }
            break;
        case 11:{
            y=YES;
           // NSLog(@"%@",yhGoodsDetailHttpSer.responDict);
            if ([yhGoodsDetailHttpSer.responDict[@"ecode"] integerValue] == 1000)
            {
                [self altShowTitle:@"秒杀结果" withMessage:@"恭喜您！\n本次团购成功，请尽快到合作商家处出示本次会员ID和订单号购买本款商品，详细信息，请到我的消息中查看明细消息!" withBtn:@"我的消息" otherBtn:@"关闭"];
            }
        }
            break;

            
        default:
            break;
    }
}
#pragma mark Alt
-(void)altShowTitle:(NSString *)title withMessage:(NSString *)msg withBtn:(NSString *)titleBtn otherBtn:(NSString *)otherTitleBtn {
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:titleBtn otherButtonTitles:otherTitleBtn, nil];
    [alertView show];
}
#pragma mark altDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:{
            ZHMyMessageViewController *messgaeVCtr = [[ZHMyMessageViewController alloc]init];
            
            [self.navigationController presentViewController:messgaeVCtr animated:YES completion:NULL];
        }
            break;
            
        default:
            break;
    }
}

-(void)didReceieveFail:(NSInteger)tag{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
