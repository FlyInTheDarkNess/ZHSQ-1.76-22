//
//  AXHSeckillDetailViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/25.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHSeckillDetailViewController.h"
#import "shouyeViewController.h"
#import "AXHSeckillIntroduceViewController.h"
#import "ZHMyMessageViewController.h"
@interface AXHSeckillDetailViewController (){
    //请求
    AXHYHGoodsHttpService  *msGoodsDetailHttpSer;
    //商品id
    NSString *goodsID;
    //商家id
    NSString *storeID;
    //商品详情
    NSMutableDictionary *goodsDict;
    //详情列表头视图
    UIView *headView;
    
    //秒杀请求
    AXHYHGoodsHttpService  *seckillHttpSer;
    
    //点击秒杀之后返回数据
    NSDictionary *seckillDict;
}
@end

@implementation AXHSeckillDetailViewController
@synthesize msGoodsDetailTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withStoreId:(NSString *)storeId withGoodsId:(NSString *)goodsId
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        storeID = storeId;
        goodsID = goodsId;
    }
    return self;
}
-(void)backUpper{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil withColor:[UIColor colorWithRed:225/255.0 green:224/255.0 blue:222/255.0 alpha:1]];
    
    self.navigationItem.title = @"商品详情";
    
    [self msGoodsDataInit];
    msGoodsDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 44) style:UITableViewStylePlain];
    msGoodsDetailTableView.backgroundColor = [UIColor whiteColor];
    msGoodsDetailTableView.delegate = self;
    msGoodsDetailTableView.dataSource = self;
    msGoodsDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:msGoodsDetailTableView];
}
-(void)msGoodsDataInit{
    NSString *str1= [NSString stringWithFormat:@"{\"session\":\"%@\",\"id_array\":\[\{\"store_id\":\"%@\",\"goods_id\":\"%@\"}]}",[SurveyRunTimeData sharedInstance].session,storeID,goodsID];
    NSLog(@"%@",str1);
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    msGoodsDetailHttpSer = [[AXHYHGoodsHttpService alloc]init];
    msGoodsDetailHttpSer.strUrl = kSECKILL_GOODS_DETAIL_URL;
    msGoodsDetailHttpSer.delegate = self;
    msGoodsDetailHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [msGoodsDetailHttpSer beginQuery];
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
        imageScrollView.backgroundColor = [UIColor whiteColor];
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
        UILabel *goodsLab = [[UILabel alloc]initWithFrame:CGRectMake(10, imageViewsize.height + 5, kViewwidth - 20, 20)];
        goodsLab.backgroundColor = [UIColor clearColor];
        goodsLab.font = [UIFont systemFontOfSize:16];
        goodsLab.text = goodsDict[@"goods_name"];
        [self labelSizeToFitHeight:goodsLab withWidth:kViewwidth - 20 withy:imageViewsize.height + 5];
        //商品价格
        UILabel  *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(10, imageViewsize.height + goodsLab.frame.size.height + 15, kViewwidth - 20, 20)];
        priceLab.backgroundColor = [UIColor clearColor];
        priceLab.textColor = [UIColor redColor];
        priceLab.font = [UIFont systemFontOfSize:16];
        priceLab.text = [NSString stringWithFormat:@"￥%@",goodsDict[@"price4"]];
        
        float height = imageViewsize.height + goodsLab.frame.size.height + 40 ;
        //剩余秒杀时间
        UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, height, 20, 20)];
        [leftImageView setImage:[UIImage imageNamed:@"clock"]];
        //掌上秒杀剩余时间
        NSDate *senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy/M/d HH:mm:ss"];
        NSString *locationString=[dateformatter stringFromDate:senddate];
        
        NSString *timeStr;
        //秒杀按钮
        UIButton *seckillBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [seckillBtn setFrame:CGRectMake(223, height - 3, 90, 30)];
        seckillBtn.layer.masksToBounds = YES;
        seckillBtn.layer.cornerRadius = 3;
        [seckillBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        seckillBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [seckillBtn addTarget:self action:@selector(seckillGoodsBegin) forControlEvents:UIControlEventTouchUpInside];
        if ([goodsDict[@"seckill_state"] isEqualToString:@"1"]) {
            timeStr = goodsDict[@"enddate"];
            seckillBtn.backgroundColor = [UIColor colorWithRed:161/255.0 green:76/255.0 blue:197/255.0 alpha:1];
            seckillBtn.enabled = NO;
            [seckillBtn setTitle:@"秒杀过" forState:UIControlStateNormal];
        }else if([self mxGetStringTimeDiff:locationString timeE:goodsDict[@"startdate"]] > 0){
            seckillBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:202/255.0 blue:196/255.0 alpha:1];
            seckillBtn.enabled = NO;
            timeStr = goodsDict[@"startdate"];
            [seckillBtn setTitle:@"未开始" forState:UIControlStateNormal];
            
        }else if ([self mxGetStringTimeDiff:locationString timeE:goodsDict[@"startdate"]] < 0 && [self mxGetStringTimeDiff:locationString timeE:goodsDict[@"enddate"]] > 0){
            seckillBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:65/255.0 alpha:1];
            seckillBtn.enabled = YES;
            timeStr = goodsDict[@"enddate"];
            [seckillBtn setTitle:@"秒杀中" forState:UIControlStateNormal];
            
        }else{
            seckillBtn.backgroundColor = [UIColor colorWithRed:190/255.0 green:192/255.0 blue:193/255.0 alpha:1];
            seckillBtn.enabled = NO;
            timeStr = goodsDict[@"enddate"];
            [seckillBtn setTitle:@"已结束" forState:UIControlStateNormal];
        }
        UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(30, height, 60, 20)];
        leftLab.font = [UIFont boldSystemFontOfSize:14];
        leftLab.backgroundColor = [UIColor clearColor];
        leftLab.text = @"掌上秒杀";
        
        //秒杀开始or结束时间计时器
        MZTimerLabel *timeLab = [[MZTimerLabel alloc]initWithFrame:CGRectMake(87, height, 130, 20)];
        timeLab.font = [UIFont boldSystemFontOfSize:14];
        timeLab.textColor = [UIColor redColor];
        timeLab.backgroundColor = [UIColor clearColor];
        [timeLab setTimerType:MZTimerLabelTypeTimer];
        [timeLab setCountDownTime:[self mxGetStringTimeDiff:locationString timeE:timeStr]];
        timeLab.delegate = self;
        [timeLab start];
        //分割线
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, height + 30, kViewwidth, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        
        //商品规格
        UILabel*specificationLab = [[UILabel alloc]initWithFrame:CGRectMake(10, height + 35, kViewwidth - 20, 20)];
        NSString *str = [NSString stringWithFormat:@"规格 %@",goodsDict[@"store_name"]];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(2,str.length - 2)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0,str.length)];
        specificationLab.attributedText = attriStr;
        [self labelSizeToFitHeight:specificationLab withWidth:kViewwidth - 20 withy:height + 35];
        //查看图文详情
        UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [checkBtn setFrame:CGRectMake(0, height + 40 + specificationLab.frame.size.height, kViewwidth, 40)];
        [checkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        checkBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [checkBtn setBackgroundColor:[UIColor whiteColor]];
        [checkBtn setTitle:@"查看图文详情" forState:UIControlStateNormal];
        [checkBtn addTarget:self action:@selector(seckillIntroduceVC) forControlEvents:UIControlEventTouchUpInside];
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
        [headView addSubview:seckillBtn];
        [headView addSubview:priceLab];
        [headView addSubview:leftImageView];
        [headView addSubview:leftLab];
        [headView addSubview:timeLab];
        [headView addSubview:imageScrollView];
        [headView addSubview:goodsLab];
        
        [headView addSubview:lineView];
        [headView addSubview:specificationLab];
        [headView addSubview:checkBtn];
        [headView addSubview:attetnionBtn];
        [headView addSubview:intoShoppongCartBtn];
        [headView addSubview:shoppongCartBtn];
        CGRect frame = headView.frame;
        frame.size.height = shoppongCartBtn.frame.origin.y + 50;
        headView.frame = frame;
    }
    
    return headView;
}
#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    
    switch (tag) {
        case 7:{
            if ([msGoodsDetailHttpSer.responDict[@"ecode"] integerValue] == 1000){
                 goodsDict = [NSMutableDictionary dictionaryWithDictionary:msGoodsDetailHttpSer.responDict[@"info"][0]];
            }else  if([msGoodsDetailHttpSer.responDict[@"ecode"] integerValue] == 3007){
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据!" duration:1.5];
            }else{
              [SVProgressHUD showErrorWithStatus:@"未知错误!" duration:1.5];
            }
           
            [msGoodsDetailTableView setTableHeaderView:[self tabHeadView]];
            [msGoodsDetailTableView reloadData];
        }
            break;
        case 8:{
            [SVProgressHUD dismiss];
            seckillDict = [NSDictionary dictionaryWithDictionary:seckillHttpSer.responDict];
            if ([seckillDict[@"ecode"] integerValue] == 5010) {
                [self altShowTitle:@"秒杀结果" withMessage:@"您已经秒杀过了！请关注近期其它的秒杀活动！" withBtn:nil otherBtn:@"关闭"];
            }else if ([seckillDict[@"ecode"] integerValue] == 1000){
                if ([seckillDict[@"seckill_order_status"] integerValue] == 0 ) {
                    [self altShowTitle:@"秒杀结果" withMessage:@"恭喜您！\n本次秒杀成功，请尽快到合作商家处出示本次会员ID和订单号购买本款商品，详细信息，请到我的消息中查看明细信息！" withBtn:@"我的消息" otherBtn:@"关闭"];
                }else{
                    [self altShowTitle:@"秒杀结果" withMessage:@"非常遗憾，您本次秒杀不成功！由于本次秒杀商品数量有限，请留意其他秒杀商品。" withBtn:nil otherBtn:@"关闭"];
                    
                }
            }
        }
            break;
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
    [SVProgressHUD dismiss];
}
#pragma mark date
- (double)mxGetStringTimeDiff:(NSString*)timeS timeE:(NSString*)timeE{
    double timeDiff = 0.0;
    NSDateFormatter *formatters = [[NSDateFormatter alloc]init];
    [formatters setDateFormat:@"yyyy/M/d HH:mm:ss"];
    NSDate *dateS = [formatters dateFromString:timeS];
    NSDateFormatter *formatterE = [[NSDateFormatter alloc]init];
    [formatterE setDateFormat:@"yyyy/M/d HH:mm:ss"];
    NSDate *dateE = [formatterE dateFromString:timeE];
    timeDiff = [dateE timeIntervalSinceDate:dateS ];
    
    timeDiff = [dateE timeIntervalSinceNow];
    
    //单位秒
    return timeDiff;
}
#pragma mark MZTimerLabelDelegate

- (NSString*)timerLabel:(MZTimerLabel *)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time
{
    int second = (int)time  % 60;
    int minute = ((int)time / 60) % 60;
    int hours = time / 3600;
    return [NSString stringWithFormat:@"%02d小时%02d分钟%02d秒",hours,minute,second];
    
}
#pragma mark buttonAction
-(void)seckillGoodsBegin{
    if ([SurveyRunTimeData sharedInstance].session.length == 0) {
        shouyeViewController *loginVCtr = [[shouyeViewController alloc]initWithNibName:@"shouyeViewController" bundle:nil];
        
        [self.navigationController presentViewController:loginVCtr animated:YES completion:NULL];
        return;
    }
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"store_id\":\"%@\",\"goods_id\":\"%@\",\"count1\":\"%@\",\"startdate\":\"%@\",\"enddate\":\"%@\",\"mobile_phone\":\"%@\"}",[SurveyRunTimeData sharedInstance].session,goodsDict[@"store_id"],goodsDict[@"goods_id"],goodsDict[@"count1"],goodsDict[@"startdate"],goodsDict[@"enddate"],[SurveyRunTimeData sharedInstance].mobilePhone];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    seckillHttpSer = [[AXHYHGoodsHttpService alloc]init];
    seckillHttpSer.strUrl = kSECKILL_GOODS_URL;
    seckillHttpSer.delegate = self;
    seckillHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [SVProgressHUD showWithStatus:@"正在抢购..." maskType:SVProgressHUDMaskTypeClear];
    [seckillHttpSer beginQuery];
}
-(void)seckillIntroduceVC{
    AXHSeckillIntroduceViewController *introduceVCtr = [[AXHSeckillIntroduceViewController alloc]initWithNibName:nil bundle:nil withSeckillDict:goodsDict];
    [self.navigationController pushViewController:introduceVCtr animated:YES];
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

@end
