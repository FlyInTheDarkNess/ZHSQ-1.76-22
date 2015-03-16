//
//  MyBankCardViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-2-4.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "MyBankCardViewController.h"
#import "PersonCenterHttpService.h"
#import "MyBankCarTableViewCell.h"
#import "AddBankCardViewController.h"
#import "AXHButton.h"
extern NSString *Session;
@interface MyBankCardViewController ()
{
    
    //评论ID
    NSArray *idList;
    //请求
    PersonCenterHttpService  *sqLtHttpSer;
    //当前列表数据
    NSMutableArray *postArr;
    
    int startIndex;
    NSInteger btnIndexPath;
    BOOL isUp;
}

@end

@implementation MyBankCardViewController
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
    // Do any additional setup after loading the view from its nib.
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customRightNarvigationBarWithImageName:@"plus0529.png" highlightedName:nil];
    [self customViewBackImageWithImageName:nil];
    self.navigationItem.title = @"我的联名卡";
    Mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 44) style:UITableViewStylePlain];
    Mytableview.backgroundColor = [UIColor whiteColor];
    Mytableview.delegate = self;
    
    Mytableview.dataSource = self;
    [self.view addSubview:Mytableview];
    
    [Mytableview addHeaderWithTarget:self action:@selector(DataInit)];
   // [Mytableview addFooterWithTarget:self action:@selector(AddData)];
    [Mytableview headerBeginRefreshing];
    
    postArr = [NSMutableArray array];

}
-(void)backUpper
{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];

}
-(void)nextControl
{
    AddBankCardViewController *tianjia=[[AddBankCardViewController alloc]initWithNibName:@"AddBankCardViewController" bundle:nil];
   [tianjia setDelegate_:self];
    UINavigationController *naVCtr = [[UINavigationController alloc]initWithRootViewController:tianjia];
    [self presentViewController:naVCtr animated:YES completion:NULL];


}
-(void)DataInit
{
    
    NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,}",Session];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqLtHttpSer = [[PersonCenterHttpService alloc]init];
    sqLtHttpSer.strUrl = YinHangKa_m1_22;
    sqLtHttpSer.delegate = self;
    sqLtHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqLtHttpSer beginQuery];
    isUp = YES;

}
-(void)AddData
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"MyBankCarTableViewCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (cell==nil)
    {
        NSArray *nibsArr = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
        cell  = nibsArr[0];
    }
    cell.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:0.73];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:postArr[indexPath.row]];
    
    UILabel *titleLab = (UILabel *)[cell.contentView viewWithTag:4];
    NSString *str=[dic objectForKey:@"card"];
    titleLab.text =[NSString stringWithFormat:@"卡  号：%@",str];
    
    AXHButton *seckillBtn = (AXHButton *)[cell.contentView viewWithTag:5];
    NSInteger a=indexPath.row;
    seckillBtn.tag=a;
    seckillBtn.layer.masksToBounds = YES;
    seckillBtn.layer.cornerRadius = 3;
    [seckillBtn addTarget:self action:@selector(Remove:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;

   
}
-(void)Remove:(AXHButton *)btn
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:postArr[btn.tag]];
    NSLog(@"%@",dict);
    btnIndexPath = btn.tag;
    NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"card\":%@}",Session,[dict objectForKey:@"card"]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqLtHttpSer = [[PersonCenterHttpService alloc]init];
    sqLtHttpSer.strUrl = YinHangKa_m1_23;
    sqLtHttpSer.delegate = self;
    sqLtHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqLtHttpSer beginQuery];
    isUp = YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:postArr[indexPath.row]];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return postArr.count;
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 340;
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 22:{
            NSLog(@"%@",sqLtHttpSer.responDict);
            NSDictionary *dic=sqLtHttpSer.responDict;
            int ecode=[[dic objectForKey:@"ecode"] intValue];
            if (ecode==3007)
            {
                [Mytableview reloadData];
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1.5];
                [Mytableview headerEndRefreshing];
                
                return;

            }
            [postArr removeAllObjects];
             NSArray *responArr = [NSArray arrayWithArray:sqLtHttpSer.responDict[@"info"]];
            for (int i = responArr.count - 1; i >= 0; i--) {
                [postArr addObject:responArr[i]];
            }
            [Mytableview reloadData];
            [Mytableview headerEndRefreshing];            
        }
            break;
        case 23:{
            [Mytableview headerEndRefreshing];
            [Mytableview footerEndRefreshing];
            NSLog(@"   23   %@",sqLtHttpSer.responDict);

            //NSString *ecode=sqLtHttpSer.responDict[ecode];
            NSDictionary *dic=sqLtHttpSer.responDict;
            int ecode=[[dic objectForKey:@"ecode"] intValue];
            NSLog(@"%d",ecode);
            if (ecode==1000)
            {
                [SVProgressHUD showSuccessWithStatus:@"解绑成功" duration:1];
                [self DataInit];
            }
            //[Mytableview reloadData];
        }
            break;
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
    [Mytableview headerEndRefreshing];
    [Mytableview footerEndRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
