//
//  LifeToHelpViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/17.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "LifeToHelpViewController.h"
#import "AXHVendors.h"
#import "SurveyRunTimeData.h"
#import "AXHLTHelpHttpService.h"
//生活帮子界面（webview）
#import "LefeToHelpSubViewController.h"

#import "AXHBXXViewController.h"
//赵VC
//便民电话
#import "XiaoQuBiBieViewController.h"
//公积金查询
#import "GongJiJinViewController.h"
#import "ProvidentfundViewController.h"
//违章查询
#import "WeiZhangChaXunViewController.h"
//公交路线
#import "GongJiaoXianLuViewController.h"
//长途客车
#import "ChangTuKeYunViewController.h"
//地图
#import "ZhouBianViewController.h"
//节目单
#import "WoDeViewController.h"
//热推荐
#import "HitRecommendViewController.h"
@interface LifeToHelpViewController (){
    AXHLTHelpHttpService *httpService;
    
    NSMutableArray *lTHelpArr;
}
@end

@implementation LifeToHelpViewController
@synthesize _LTHelpCollectionView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"生活帮";
    // Do any additional setup after loading the view.
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil withColor:[UIColor colorWithRed:225/255.0 green:224/255.0 blue:222/255.0 alpha:1]];
    [self.view addSubview:[self LTHelpCollectionView]];
}
-(void)backUpper{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}
-(UICollectionView *)LTHelpCollectionView{
    if (!_LTHelpCollectionView) {
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize=CGSizeMake(kViewwidth  / 3,kViewwidth  / 3);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _LTHelpCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 44) collectionViewLayout:flowLayout];
        [_LTHelpCollectionView setBackgroundColor:[UIColor clearColor]];
        //注册collection的cell
        [_LTHelpCollectionView addHeaderWithTarget:self action:@selector(yhGoodsDataInit)];
      
        [_LTHelpCollectionView headerBeginRefreshing];
        
        UINib *cell = [UINib nibWithNibName:@"LeftToHelpCell" bundle:nil];
        [_LTHelpCollectionView registerNib:cell forCellWithReuseIdentifier:@"LeftToHelpCell"];
        _LTHelpCollectionView.alwaysBounceVertical = YES;
        
        _LTHelpCollectionView.delegate = self;
        _LTHelpCollectionView.dataSource = self;
    }
    return _LTHelpCollectionView;
}
-(void)yhGoodsDataInit
{
    NSString *str1=@"{\"city_id\":\"101\"}";
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    httpService = [[AXHLTHelpHttpService alloc]init];
    httpService.strUrl = kLEFT_TO_HELP_LIST_URL;
    httpService.delegate = self;
    httpService.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [httpService beginQuery];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return lTHelpArr.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:lTHelpArr[indexPath.row]];
    static NSString *CellIdentifier = @"LeftToHelpCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    //cell背景图片
//    UIImageView *backImageView = (UIImageView *)[cell.contentView viewWithTag:3];
//    [backImageView setImage:[[UIImage imageNamed:@"collection_cell_bg"] stretchableImageWithLeftCapWidth:106/4 topCapHeight:106/4]];
    //Icon
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
    [imageView setImageWithURL:[NSURL URLWithString:dict[@"icon"]]
              placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                       options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
   usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //name
    UILabel *nameLab = (UILabel *)[cell.contentView viewWithTag:2];
    nameLab.text = dict[@"name"];
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    }
    return cell;
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
     NSDictionary *dict = [NSDictionary dictionaryWithDictionary:lTHelpArr[indexPath.row]];
    
    if (![dict[@"url"] isEqualToString:@""]) {
         LefeToHelpSubViewController *subViewVCtr = [[LefeToHelpSubViewController alloc]initWithNibName:nil bundle:nil withUrl:dict[@"url"] withTitle:dict[@"name"]];
        [self.navigationController pushViewController:subViewVCtr animated:YES];
    }else{
        
        switch ([dict[@"id"] intValue])
        {
            case 7:
            {
                //节目单
                WoDeViewController *jMDVCtr = [[WoDeViewController alloc]init];
                [self.navigationController presentViewController:jMDVCtr animated:YES completion:NULL];
                
            }
                break;
            case 40:{
                //热推荐
                HitRecommendViewController *rtjVCtr = [[HitRecommendViewController alloc]init];
                [self.navigationController presentViewController:rtjVCtr animated:YES completion:NULL];
            
            }
                break;
            case 41:{
                //爆新鲜
                AXHBXXViewController *BXXVCtr = [[AXHBXXViewController alloc]init];
                [self.navigationController pushViewController:BXXVCtr animated:YES];
            }
                break;
            case 42:{
                //拍屏有礼
                  [SVProgressHUD showErrorWithStatus:@"敬请期待" duration:1.0];
            }
                break;
            case 1:{
                //便民电话
                XiaoQuBiBieViewController *bMDHVCtr = [[XiaoQuBiBieViewController alloc]init];
                [self.navigationController presentViewController:bMDHVCtr animated:YES completion:NULL];
            }
                break;
            case 2:{
                //公积金查询
                ProvidentfundViewController *GJJVCtr = [[ProvidentfundViewController alloc]init];
                [self.navigationController presentViewController:GJJVCtr animated:YES completion:NULL];
            }
                break;
            
            case 4:{
                //公交线路
                GongJiaoXianLuViewController *gJLXVCtr = [[GongJiaoXianLuViewController alloc]init];
                [self.navigationController presentViewController:gJLXVCtr animated:YES completion:NULL];
            }
                break;
            case 5:{
                //长途客车
                ChangTuKeYunViewController *cTKCVCtr = [[ChangTuKeYunViewController alloc]init];
                [self.navigationController presentViewController:cTKCVCtr animated:YES completion:NULL];
            }
                break;
            case 6:{
                //地图导航
                ZhouBianViewController *dTDHVCtr = [[ZhouBianViewController alloc]init];
                [self.navigationController presentViewController:dTDHVCtr animated:YES completion:NULL];
            }
                break;
            default:
                break;
        }
    }
   
}

#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 1:{
            [_LTHelpCollectionView headerEndRefreshing];
            [_LTHelpCollectionView footerEndRefreshing];
            lTHelpArr =[NSMutableArray arrayWithArray:httpService.responDict[@"info"]];
            
            [_LTHelpCollectionView reloadData];
        }
            break;
            
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
    [_LTHelpCollectionView headerEndRefreshing];
    [_LTHelpCollectionView footerEndRefreshing];
}

@end
