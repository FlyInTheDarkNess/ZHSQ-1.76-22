//
//  GroupBuyingViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-2-9.
//  Copyright (c) 2015年 lacom. All rights reserved.
//
#define kCollectionCellWith 160
#define kCollectionCellHeight 235

#import "GroupBuyingViewController.h"
#import "RegistrationAndLoginAndFindHttpService.h"
#import "GroupBuyingDetailViewController.h"
#import "ZHMyMessageViewController.h"
#import "AXHButton.h"
#import "AXHHttpUrl.h"
#import "AXHVendors.h"
#import "SurveyRunTimeData.h"
extern NSString *Session;
extern NSDictionary *GroupBuyingDic;
extern NSString *mobel_iphone;
@interface GroupBuyingViewController ()
{
    //请求
    RegistrationAndLoginAndFindHttpService  *yhGoodsHttpSer;
    
    
    
    //主键ID
    NSArray *idList;
    //加载开始位置
    int startIndex;
    
    BOOL isUp;
    NSInteger btnIndexPath;
    //获取商品主键
    NSString *idUrl;
    //获取商品列表
    NSString *goodsListUrl;
    
}

@end

@implementation GroupBuyingViewController
@synthesize _collectionView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"团购商品";
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil withColor:[UIColor whiteColor]];
    
    [self.view addSubview:[self collectionView]];
    GroupBuyingGoodArr=[NSMutableArray array];
    y=YES;
}
-(void)backUpper
{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize=CGSizeMake(kCollectionCellWith,kCollectionCellHeight);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 44) collectionViewLayout:flowLayout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册collection的cell
        [_collectionView addHeaderWithTarget:self action:@selector(yhGoodsDataInit)];
        [_collectionView addFooterWithTarget:self action:@selector(yhGoodsAddData)];
        [_collectionView headerBeginRefreshing];
        UINib *cell = [UINib nibWithNibName:@"GroupBuyingGoodsCell" bundle:nil];
        [_collectionView registerNib:cell forCellWithReuseIdentifier:@"GroupBuyingGoodsCell"];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
-(void)yhGoodsDataInit
{
    [_collectionView setFooterHidden:NO];
    NSString *str1;
    str1=@"{\"city_id\":\"101\"}";
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    yhGoodsHttpSer=[[RegistrationAndLoginAndFindHttpService alloc]init];
    yhGoodsHttpSer.strUrl=TuanGou_m40_10;
    yhGoodsHttpSer.delegate=self;
    yhGoodsHttpSer.requestDict=[NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [yhGoodsHttpSer beginQuery];
    isUp=YES;
}

-(void)yhGoodsAddData{
    if (startIndex == idList.count) {
        [_collectionView footerEndRefreshing];
        [_collectionView setFooterHidden:YES];
        [SVProgressHUD showErrorWithStatus:@"没有更多数据了!" duration:1.5];
        return;
    }
    
    NSString *str1;
    str1=[NSString stringWithFormat:@"{\"id_array\":%@}",[self getFromArr:idList withNumber: startIndex + 4]];

    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    yhGoodsHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
    yhGoodsHttpSer.strUrl = TuanGou_m40_11;
    yhGoodsHttpSer.delegate = self;
    yhGoodsHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [yhGoodsHttpSer beginQuery];
    
    isUp = NO;
}

#pragma mark UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return GroupBuyingGoodArr.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:GroupBuyingGoodArr[indexPath.row]];
    
    
    static NSString *CellIdentifier = @"GroupBuyingGoodsCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    //cell背景图片
    UIImageView *backImageView = (UIImageView *)[cell.contentView viewWithTag:6];
    [backImageView setImage:[[UIImage imageNamed:@"collection_cell_bg"] stretchableImageWithLeftCapWidth:106/4 topCapHeight:106/4]];
    //商品图片
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
    [imageView setImageWithURL:[NSURL URLWithString:dict[@"thumbs_url"]]
              placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                       options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
   usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //商品标题
    UILabel *titleLab = (UILabel *)[cell.contentView viewWithTag:2];
    titleLab.text=dict[@"goods_name"];
    //NSLog(@"商品标题 %@",dict[@"goods_name"]);
    //商品价格-团购价
    UILabel *pricrLab_tuangou= (UILabel *)[cell.contentView viewWithTag:3];
    pricrLab_tuangou.text=[NSString stringWithFormat:@"团购价:￥%@",dict[@"price3"]];

    //商品价格-市场价
    UILabel *pricrLab_shichang= (UILabel *)[cell.contentView viewWithTag:4];
    pricrLab_shichang.text=[NSString stringWithFormat:@"市场价:￥%@",dict[@"price1"]];
    NSString *oldPrice=[NSString stringWithFormat:@"市场价:￥%@",dict[@"price1"]];

    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, length)];
    [pricrLab_shichang setAttributedText:attri];
    
    AXHButton *seckillBtn = (AXHButton *)[cell.contentView viewWithTag:5];
    NSInteger a=indexPath.row;
    seckillBtn.tag=a;
    seckillBtn.enabled=YES;
    seckillBtn.layer.masksToBounds = YES;
    seckillBtn.layer.cornerRadius = 3;
    [seckillBtn addTarget:self action:@selector(buying:) forControlEvents:UIControlEventTouchUpInside];

    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(void)buying:(AXHButton *)btn
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:GroupBuyingGoodArr[btn.tag]];
    NSLog(@"%@",dict);
    btnIndexPath = btn.tag;
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"store_id\":\"%@\",\"goods_id\":\"%@\",\"count\":\"%@\",\"price\":\"%@\",\"mobile_phone\":\"%@\"}",Session,dict[@"store_id"],dict[@"goods_id"],@"1",dict[@"price3"],mobel_iphone];

    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    yhGoodsHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
    yhGoodsHttpSer.strUrl = TuanGou_m40_13;
    yhGoodsHttpSer.delegate = self;
    yhGoodsHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [yhGoodsHttpSer beginQuery];
    isUp = YES;
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    GroupBuyingDic=[NSDictionary dictionaryWithDictionary:idList[indexPath.row]];
    NSLog(@"商品id ：%@",GroupBuyingDic);
    //GroupBuyingDetailViewController *goodsVCtr = [[GroupBuyingDetailViewController alloc]initWithNibName:nil bundle:nil withGoodsId:dict];
    GroupBuyingDetailViewController *sqDyVCtr = [[GroupBuyingDetailViewController alloc]init];    UINavigationController *NAVCtr = [[UINavigationController alloc]initWithRootViewController:sqDyVCtr];
    [self presentViewController:NAVCtr animated:YES completion:NULL];

}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 8:{
            NSLog(@"%@",yhGoodsHttpSer.responDict);
            if ([yhGoodsHttpSer.responDict[@"ecode"] integerValue] == 1000) {
                startIndex = 0;
                idList = [NSArray arrayWithArray:yhGoodsHttpSer.responDict[@"id_array"]];
                
                NSString *str1;
                str1=[NSString stringWithFormat:@"{\"id_array\":%@}",[self getFromArr:idList withNumber: startIndex + 6]];
                
                NSLog(@"参数:%@",str1);
                NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                yhGoodsHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
                yhGoodsHttpSer.strUrl = TuanGou_m40_11;
                yhGoodsHttpSer.delegate = self;
                yhGoodsHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                [yhGoodsHttpSer beginQuery];
            }else if ([yhGoodsHttpSer.responDict[@"ecode"] integerValue] == 3007){
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据！" duration:1.5];
            }else{
                [SVProgressHUD showErrorWithStatus:@"未知错误！" duration:1.5];
            }
        }
            break;
        case 9:{
             NSLog(@"商品:%@",yhGoodsHttpSer.responDict);
            [_collectionView headerEndRefreshing];
            [_collectionView footerEndRefreshing];
            if (isUp) {
                [GroupBuyingGoodArr removeAllObjects];
            }
            NSArray *responArr = [NSArray arrayWithArray:yhGoodsHttpSer.responDict[@"info"]];
            [GroupBuyingGoodArr addObjectsFromArray:responArr];
            [_collectionView reloadData];
        }
            break;
        case 11:{
            y=YES;
            // NSLog(@"%@",yhGoodsDetailHttpSer.responDict);
            if ([yhGoodsHttpSer.responDict[@"ecode"] integerValue] == 1000)
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
    [_collectionView headerEndRefreshing];
    [_collectionView footerEndRefreshing];
}

-(NSString *)getFromArr:(NSArray *)arr withNumber:(int)num{
    if (arr.count == 0) {
        return @"";
    }
    NSMutableString *finalStr =[[NSMutableString alloc] initWithString:@"["];
    if (arr.count < num) {
        num = arr.count;
    }
    for (int index = startIndex; index < num; index++)
    {
        
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

@end
