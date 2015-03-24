//
//  AXHYHGoodsViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/15.
//  Copyright (c) 2014年 lacom. All rights reserved.
//
#define kCollectionCellWith 160
#define kCollectionCellHeight 180
#import "AXHYHGoodsViewController.h"
#import "AXHYHGoodsDetailViewController.h"
@interface AXHYHGoodsViewController (){
    //请求
    AXHYHGoodsHttpService  *yhGoodsHttpSer;
  
    NSMutableArray *yhGoodArr;
    
    //主键ID
    NSArray *idList;
    //加载开始位置
    int startIndex;
    
    BOOL isUp;
    
    //获取商品主键
    NSString *idUrl;
    //获取商品列表
     NSString *goodsListUrl;
    
}
@end

@implementation AXHYHGoodsViewController
@synthesize _collectionView;
@synthesize goodsType;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(GoodsType )type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        goodsType = type;
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
    [self customViewBackImageWithImageName:nil withColor:[UIColor colorWithRed:225/255.0 green:224/255.0 blue:222/255.0 alpha:1]];
    
   
    [self.view addSubview:[self collectionView]];
    yhGoodArr = [NSMutableArray array];
    
    switch (goodsType) {
        case GoodsTypeDefault:
            idUrl = kYHGOODS_BRIEF_ID_URL;
            goodsListUrl = kYHGOODS_BRIEF_LIST_URL;
             self.navigationItem.title = @"优惠商品";
            break;
        case GoodsTypeJF:
            idUrl = kRULE_ID_URL;
            goodsListUrl = kRULE_LIST_URL;
             self.navigationItem.title = @"笑脸币商城";
            break;
        default:
            break;
    }

  
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
        UINib *cell = [UINib nibWithNibName:@"AXHYHGoodsCell" bundle:nil];
        [_collectionView registerNib:cell forCellWithReuseIdentifier:@"AXHYHGoodsCell"];
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
    
    switch (goodsType) {
        case GoodsTypeDefault:
            str1 = [NSString stringWithFormat:@"{\"city_id\":\"%@\"}",[SurveyRunTimeData sharedInstance].city_id];;
            break;
        case GoodsTypeJF:
            str1 = [NSString stringWithFormat:@"{\"session\":\"%@\",\"city_id\":\"%@\"}",[SurveyRunTimeData sharedInstance].session,[SurveyRunTimeData sharedInstance].city_id];
            break;
        default:
            break;
    }
    
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    yhGoodsHttpSer = [[AXHYHGoodsHttpService alloc]init];
    yhGoodsHttpSer.strUrl = idUrl;
    yhGoodsHttpSer.delegate = self;
    yhGoodsHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [yhGoodsHttpSer beginQuery];
    isUp = YES;
}

-(void)yhGoodsAddData{
    if (startIndex == idList.count) {
        [_collectionView footerEndRefreshing];
        [_collectionView setFooterHidden:YES];
        [SVProgressHUD showErrorWithStatus:@"没有更多数据了!" duration:1.5];
        return;
    }

    NSString *str1;
    
    switch (goodsType) {
        case GoodsTypeDefault:
            str1=[NSString stringWithFormat:@"{\"id_array\":%@}",[self getFromArr:idList withNumber: startIndex + 4]];
            break;
        case GoodsTypeJF:
            str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"id_array\":%@}",[SurveyRunTimeData sharedInstance].session,[self getFromArr:idList withNumber: startIndex + 4]];
            break;
        default:
            break;
    }
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    yhGoodsHttpSer = [[AXHYHGoodsHttpService alloc]init];
    yhGoodsHttpSer.strUrl = goodsListUrl;
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
    return yhGoodArr.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:yhGoodArr[indexPath.row]];
    
    
    static NSString *CellIdentifier = @"AXHYHGoodsCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    //cell背景图片
    UIImageView *backImageView = (UIImageView *)[cell.contentView viewWithTag:10];
    [backImageView setImage:[[UIImage imageNamed:@"collection_cell_bg"] stretchableImageWithLeftCapWidth:106/4 topCapHeight:106/4]];
    //商品图片
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
    [imageView setImageWithURL:[NSURL URLWithString:dict[@"thumbs_url"]]
                  placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                           options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
       usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //商品标题
    UILabel *titleLab = (UILabel *)[cell.contentView viewWithTag:2];
    
    
    //商品价格
    UILabel *pricrLab = (UILabel *)[cell.contentView viewWithTag:3];
    
    switch (goodsType) {
        case GoodsTypeDefault:
            titleLab.text = dict[@"goods_name"];
            if (![dict[@"price3"] isEqualToString:@""]) {
                pricrLab.text = [NSString stringWithFormat:@"优惠价:%@",dict[@"price3"]];
            }else if (![dict[@"price2"] isEqualToString:@""]){
                pricrLab.text = [NSString stringWithFormat:@"优惠价:%@",dict[@"price2"]];
            }else{
                pricrLab.text = [NSString stringWithFormat:@"市场价:%@",dict[@"price1"]];
            }
            break;
        case GoodsTypeJF:
             titleLab.text = dict[@"name"];
            pricrLab.text = [NSString stringWithFormat:@"所需要积分:%@",dict[@"credit"]];
            break;
        default:
            break;
    }
   

    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
      NSDictionary *dict = [NSDictionary dictionaryWithDictionary:yhGoodArr[indexPath.row]];
    AXHYHGoodsDetailViewController *goodsVCtr = [[AXHYHGoodsDetailViewController alloc]initWithNibName:nil bundle:nil withGoodsId:dict[@"goods_id"]];
    [self.navigationController pushViewController:goodsVCtr animated:YES];
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 1:{
            if ([yhGoodsHttpSer.responDict[@"ecode"] integerValue] == 1000) {
                startIndex = 0;
                idList = [NSArray arrayWithArray:yhGoodsHttpSer.responDict[@"id_array"]];
                
                NSString *str1;
                switch (goodsType) {
                    case GoodsTypeDefault:
                        str1=[NSString stringWithFormat:@"{\"id_array\":%@}",[self getFromArr:idList withNumber: startIndex + 6]];
                        break;
                    case GoodsTypeJF:
                        str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"id_array\":%@}",[SurveyRunTimeData sharedInstance].session,[self getFromArr:idList withNumber: startIndex + 6]];
                        break;
                    default:
                        break;
                }
                
                NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                yhGoodsHttpSer = [[AXHYHGoodsHttpService alloc]init];
                yhGoodsHttpSer.strUrl = goodsListUrl;
                yhGoodsHttpSer.delegate = self;
                yhGoodsHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                [yhGoodsHttpSer beginQuery];
            }else if ([yhGoodsHttpSer.responDict[@"ecode"] integerValue] == 3007){
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据！" duration:1.5];
                [_collectionView headerEndRefreshing];
                [_collectionView footerEndRefreshing];
            }else{
                    [SVProgressHUD showErrorWithStatus:@"未知错误！" duration:1.5];
                [_collectionView headerEndRefreshing];
                [_collectionView footerEndRefreshing];
            }
        }
            break;
        case 2:{
            [_collectionView headerEndRefreshing];
            [_collectionView footerEndRefreshing];
            if (isUp) {
                [yhGoodArr removeAllObjects];
            }
            NSArray *responArr = [NSArray arrayWithArray:yhGoodsHttpSer.responDict[@"info"]];
            [yhGoodArr addObjectsFromArray:responArr];
            [_collectionView reloadData];
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
    for (int index = startIndex; index < num; index++) {
        switch (goodsType) {
            case GoodsTypeDefault:
                [finalStr appendFormat:@"{\"store_id\":\"%@\",",arr[index][@"store_id"]];
                [finalStr appendFormat:@"\"goods_id\":\"%@\"},",arr[index][@"goods_id"]];
                break;
            case GoodsTypeJF:
                [finalStr appendFormat:@"{\"id\":\"%@\"},",arr[index][@"id"]];
                break;
            default:
                break;
        }
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
