//
//  AXHSeckillViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/18.
//  Copyright (c) 2014年 lacom. All rights reserved.
//
#define kCollectionCellWith 160
#define kCollectionCellHeight 250
#import "AXHSeckillViewController.h"
#import "AXHTapImageView.h"
#import "AXHButton.h"
#import "AXHSeckillDetailViewController.h"

#import "shouyeViewController.h"
#import "ZHMyMessageViewController.h"
@interface AXHSeckillViewController (){
 
    //请求
    AXHYHGoodsHttpService  *seckillHttpSer;
    
    NSMutableArray *seckillArr;
    
    //主键ID
    NSArray *idList;
    //加载开始位置
    int startIndex;
    
    BOOL isUp;
    
    //点击秒杀之后返回数据
    NSDictionary *seckillDict;
    
    NSInteger btnIndexPath;
}
@end

@implementation AXHSeckillViewController
@synthesize seckillCollectionView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)backUpper{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil withColor:[UIColor colorWithRed:225/255.0 green:224/255.0 blue:222/255.0 alpha:1]];
    
    self.navigationItem.title = @"秒杀商品";
    [self.view addSubview:[self collectionView]];
    seckillArr = [NSMutableArray array];
}
-(UICollectionView *)collectionView{
    if (!seckillCollectionView) {
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize=CGSizeMake(kCollectionCellWith,kCollectionCellHeight);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        seckillCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 44) collectionViewLayout:flowLayout];
        [seckillCollectionView setBackgroundColor:[UIColor clearColor]];
        //注册collection的cell
        [seckillCollectionView addHeaderWithTarget:self action:@selector(seckillDataInit)];
        [seckillCollectionView addFooterWithTarget:self action:@selector(seckillAddData)];
        [seckillCollectionView headerBeginRefreshing];
        UINib *cell = [UINib nibWithNibName:@"seckillCell" bundle:nil];
        [seckillCollectionView registerNib:cell forCellWithReuseIdentifier:@"seckillCell"];
        seckillCollectionView.alwaysBounceVertical = YES;
        
        seckillCollectionView.delegate = self;
        seckillCollectionView.dataSource = self;
    }
    return seckillCollectionView;
}
-(void)seckillDataInit{
    [seckillCollectionView setFooterHidden:NO];
    NSString *str1 = [NSString stringWithFormat:@"{\"city_id\":\"%@\"}",[SurveyRunTimeData sharedInstance].city_id];;
    
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    seckillHttpSer = [[AXHYHGoodsHttpService alloc]init];
    seckillHttpSer.strUrl = kSECKILL_ID_URL;
    seckillHttpSer.delegate = self;
    seckillHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [seckillHttpSer beginQuery];
    isUp = YES;
}
-(void)seckillAddData{
    if (startIndex == idList.count) {
        [seckillCollectionView footerEndRefreshing];
        [seckillCollectionView setFooterHidden:YES];
        [SVProgressHUD showErrorWithStatus:@"没有更多数据了!" duration:1.5];
        return;
    }
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"id_array\":%@}",[SurveyRunTimeData sharedInstance].session,[self getFromArr:idList withNumber: startIndex + 6]];
    NSLog(@"%@",str1);
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    seckillHttpSer = [[AXHYHGoodsHttpService alloc]init];
    seckillHttpSer.strUrl = kSECKILL_LIST_URL;
    seckillHttpSer.delegate = self;
    seckillHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [seckillHttpSer beginQuery];
    
    isUp = NO;

}
#pragma mark UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return seckillArr.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:seckillArr[indexPath.row]];
    static NSString *CellIdentifier = @"seckillCell";
    
    
    UICollectionViewCell *cell;
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (!cell) {
         cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    }
  
   
    //cell背景图片
    UIImageView *backImageView = (UIImageView *)[cell.contentView viewWithTag:10];
    [backImageView setImage:[[UIImage imageNamed:@"collection_cell_bg"] stretchableImageWithLeftCapWidth:106/4 topCapHeight:106/4]];
    //秒杀商品状态
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy/M/d HH:mm:ss"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    UIImageView *ztImageView = (UIImageView *)[cell.contentView viewWithTag:11];
    //秒杀按钮
    AXHButton *seckillBtn = (AXHButton *)[cell.contentView viewWithTag:4];
    seckillBtn.indexPath = indexPath.row;
    seckillBtn.layer.masksToBounds = YES;
    seckillBtn.layer.cornerRadius = 3;
    [seckillBtn addTarget:self action:@selector(seckillGoodsBegin:) forControlEvents:UIControlEventTouchUpInside];
   
    MZTimerLabel *timeLab = (MZTimerLabel *)[cell.contentView viewWithTag:5];
    float timedouble;
    if ([dict[@"seckill_state"] isEqualToString:@"1"]) {
        [ztImageView setImage:[UIImage imageNamed:@"auction_over"]];
        seckillBtn.backgroundColor = [UIColor colorWithRed:190/255.0 green:192/255.0 blue:193/255.0 alpha:1];
        [seckillBtn setTitle:@"已秒杀" forState:UIControlStateNormal];
        seckillBtn.enabled = NO;
        timedouble = [self mxGetStringTimeDiff:locationString timeE:dict[@"enddate"]];
    }else if([self mxGetStringTimeDiff:locationString timeE:dict[@"startdate"]] > 0){
         timedouble = [self mxGetStringTimeDiff:locationString timeE:dict[@"startdate"]];
        [ztImageView setImage:[UIImage imageNamed:@"auction_ago"]];
        seckillBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:202/255.0 blue:196/255.0 alpha:1];
         [seckillBtn setTitle:@"未开始" forState:UIControlStateNormal];
        seckillBtn.enabled = NO;
        CGRect frame = timeLab.frame;
        frame.origin.x = 70;
        timeLab.frame = frame;
        
        UILabel *timeTSLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 180, 70, 20)];
        timeTSLab.font = [UIFont systemFontOfSize:15];
        timeTSLab.textColor = [UIColor blackColor];
        timeTSLab.text = @"距开始:";
        [backImageView addSubview:timeTSLab];
        
    }else if ([self mxGetStringTimeDiff:locationString timeE:dict[@"startdate"]] < 0 && [self mxGetStringTimeDiff:locationString timeE:dict[@"enddate"]] > 0){
        if ([dict[@"count1"] integerValue] - [dict[@"count2"] integerValue] == 0) {
            [ztImageView setImage:[UIImage imageNamed:@"auction_out"]];
            seckillBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:202/255.0 blue:196/255.0 alpha:1];
            [seckillBtn setTitle:@"已抢光" forState:UIControlStateNormal];
            seckillBtn.enabled = NO;
            timedouble = [self mxGetStringTimeDiff:locationString timeE:dict[@"enddate"]];
        }else{
            [ztImageView setImage:[UIImage imageNamed:@"auction_in"]];
            seckillBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:65/255.0 alpha:1];
            seckillBtn.enabled = YES;
             [seckillBtn setTitle:@"立即秒杀" forState:UIControlStateNormal];
            timedouble = [self mxGetStringTimeDiff:locationString timeE:dict[@"enddate"]];
            
            CGRect frame = timeLab.frame;
            frame.origin.x = 70;
            timeLab.frame = frame;
            UILabel *timeTSLab = [[UILabel alloc]initWithFrame:CGRectMake(8, 180, 70, 20)];
            timeTSLab.font = [UIFont systemFontOfSize:15];
            timeTSLab.textColor = [UIColor blackColor];
            timeTSLab.text = @"距结束:";
            [backImageView addSubview:timeTSLab];
        }
        
    }else{
        [ztImageView setImage:[UIImage imageNamed:@"auction_end"]];
       seckillBtn.backgroundColor = [UIColor colorWithRed:190/255.0 green:192/255.0 blue:193/255.0 alpha:1];
        [seckillBtn setTitle:@"已结束" forState:UIControlStateNormal];
        seckillBtn.enabled = NO;
        timedouble = [self mxGetStringTimeDiff:locationString timeE:dict[@"enddate"]];
    }
    //商品图片
    AXHTapImageView *imageView = (AXHTapImageView *)[cell.contentView viewWithTag:1];
    [imageView setImageWithURL:[NSURL URLWithString:dict[@"thumbs_url"]]
              placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                       options:SDWebImageRetryFailed | SDWebImageLowPriority
   usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGoodsImage:)];
    imageView.indexPath = indexPath.row;
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapImage];
    
    //商品标题
    UILabel *titleLab = (UILabel *)[cell.contentView viewWithTag:2];
    titleLab.font = [UIFont boldSystemFontOfSize:15];
    titleLab.text = dict[@"goods_name"];
    //商品价格
    UILabel *pricrLab = (UILabel *)[cell.contentView viewWithTag:3];
  
    if (![dict[@"price4"] isEqualToString:@""]) {
        pricrLab.text = [NSString stringWithFormat:@"秒杀价:￥%@元",dict[@"price4"]];
    }else if (![dict[@"price3"] isEqualToString:@""]){
        pricrLab.text = [NSString stringWithFormat:@"秒杀价:￥%@元",dict[@"price3"]];
    }else if (![dict[@"price2"] isEqualToString:@""]){
        pricrLab.text = [NSString stringWithFormat:@"秒杀价:￥%@元",dict[@"price2"]];
    }else{
        pricrLab.text = [NSString stringWithFormat:@"秒杀价:￥%@元",dict[@"price1"]];
    }
    LPLabel *hyPrice = (LPLabel *)[cell.contentView viewWithTag:32];
    hyPrice.text = [NSString stringWithFormat:@"原价:￥%@元",dict[@"price1"]];
    hyPrice.strikeThroughEnabled = YES;
    hyPrice.strikeThroughColor = [UIColor lightGrayColor];

    //秒杀开始or结束时间计时器

    [timeLab setTimerType:MZTimerLabelTypeTimer];
    [timeLab setCountDownTime:timedouble];
    timeLab.delegate = self;
    [timeLab start];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
#pragma mark UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
}
//点击图片查看详情
-(void)tapGoodsImage:(UITapGestureRecognizer *)sender{
    
    AXHTapImageView *imageView = (AXHTapImageView *)sender.view;
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:seckillArr[imageView.indexPath]];
    AXHSeckillDetailViewController *seckillDetaiVCtr = [[AXHSeckillDetailViewController alloc]initWithNibName:nil bundle:nil withStoreId:dict[@"store_id"] withGoodsId:dict[@"goods_id"]];
    [self.navigationController pushViewController:seckillDetaiVCtr animated:YES];
}
//秒杀按钮
-(void)seckillGoodsBegin:(AXHButton *)btn{
 
    if ([SurveyRunTimeData sharedInstance].session.length == 0) {
        shouyeViewController *loginVCtr = [[shouyeViewController alloc]initWithNibName:@"shouyeViewController" bundle:nil];
    
        [self.navigationController presentViewController:loginVCtr animated:YES completion:NULL];
        return;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:seckillArr[btn.indexPath]];
    btnIndexPath = btn.indexPath;
    
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"store_id\":\"%@\",\"goods_id\":\"%@\",\"count1\":\"%@\",\"startdate\":\"%@\",\"enddate\":\"%@\",\"mobile_phone\":\"%@\"}",[SurveyRunTimeData sharedInstance].session,dict[@"store_id"],dict[@"goods_id"],dict[@"count1"],dict[@"startdate"],dict[@"enddate"],[SurveyRunTimeData sharedInstance].mobilePhone];

    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    seckillHttpSer = [[AXHYHGoodsHttpService alloc]init];
    seckillHttpSer.strUrl = kSECKILL_GOODS_URL;
    seckillHttpSer.delegate = self;
    seckillHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [SVProgressHUD showWithStatus:@"正在抢购..." maskType:SVProgressHUDMaskTypeClear];
    [seckillHttpSer beginQuery];
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    [SVProgressHUD dismiss];
    switch (tag) {
        case 4:{
            if ([seckillHttpSer.responDict[@"ecode"] integerValue] == 3007) {
                [seckillCollectionView headerEndRefreshing];
                [seckillCollectionView footerEndRefreshing];
                [SVProgressHUD showErrorWithStatus:@"暂无秒杀商品!" duration:1.5];
                return;
            }
            startIndex = 0;
            idList = [NSArray arrayWithArray:seckillHttpSer.responDict[@"id_array"]];
            NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"id_array\":%@}",[SurveyRunTimeData sharedInstance].session,[self getFromArr:idList withNumber: startIndex + 6]];
           
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            seckillHttpSer = [[AXHYHGoodsHttpService alloc]init];
            seckillHttpSer.strUrl = kSECKILL_LIST_URL;
            seckillHttpSer.delegate = self;
            seckillHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [seckillHttpSer beginQuery];
        }
            break;
        case 5:{
            [seckillCollectionView headerEndRefreshing];
            [seckillCollectionView footerEndRefreshing];
            if (isUp) {
                [seckillArr removeAllObjects];
            }
            NSArray *responArr = [NSArray arrayWithArray:seckillHttpSer.responDict[@"info"]];
            NSLog(@"%@",responArr);
            [seckillArr addObjectsFromArray:responArr];
            [seckillCollectionView reloadData];
        }
            break;
        case 8:{
  
           seckillDict = [NSDictionary dictionaryWithDictionary:seckillHttpSer.responDict];
            if ([seckillDict[@"ecode"] integerValue] == 5010) {
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"秒杀结果" message:@"您已经秒杀过了!请关注近期其它的秒杀活动" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
                [alertView show];
            }else if ([seckillDict[@"ecode"] integerValue] == 1000){
                if ([seckillDict[@"seckill_order_status"] integerValue] == 0 ) {
                      NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:seckillArr[btnIndexPath]];
                    [dict setObject:@"1" forKey:@"seckill_state"];
                    [seckillArr replaceObjectAtIndex:btnIndexPath withObject:dict];
                    [seckillCollectionView reloadData];
                    [self altShowTitle:@"秒杀结果" withMessage:@"恭喜您！\n本次秒杀成功，请尽快到合作商家处出示本次会员ID和订单号购买本款商品，详细信息，请到我的消息中查看明细消息!" withBtn:@"我的消息" otherBtn:@"关闭"];
                }else{
                    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"秒杀结果" message:@"由于本次秒杀商品数量有限，请留意其他秒杀商品。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
                    [alertView show];
                }
            }
        }
            break;
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
    switch (tag) {
        case 400:
             [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1.5];
            break;
            
        default:
            break;
    }
       [SVProgressHUD showErrorWithStatus:@"网络连接失败" duration:1.5];
    [seckillCollectionView headerEndRefreshing];
    [seckillCollectionView footerEndRefreshing];
}
#pragma mark

-(NSString *)getFromArr:(NSArray *)arr withNumber:(int)num{
    if (arr.count == 0) {
        return @"";
    }
    NSMutableString *finalStr =[[NSMutableString alloc] initWithString:@"["];
    if (arr.count < num) {
        num = arr.count;
    }
    for (int index = startIndex; index < num; index++) {
        [finalStr appendFormat:@"{\"store_id\":\"%@\",",arr[index][@"store_id"]];
        [finalStr appendFormat:@"\"goods_id\":\"%@\"},",arr[index][@"goods_id"]];
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

- (NSString*)timerLabel:(MZTimerLabel *)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time
{
    int second = (int)time  % 60;
    int minute = ((int)time / 60) % 60;
    int hours = time / 3600;
    return [NSString stringWithFormat:@"%02d : %02d : %02d",hours,minute,second];

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
