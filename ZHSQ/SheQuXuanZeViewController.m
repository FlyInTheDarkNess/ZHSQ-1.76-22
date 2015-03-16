//
//  SheQuXuanZeViewController.m
//  ZHSQ
//
//  Created by lacom on 14-7-4.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "SheQuXuanZeViewController.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "Customer.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "CheckNetwork.h"
#import "DengLuHouZhuYeViewController.h"
#import "jieguoViewController.h"
#import "URL.h"
#import "JiaMiJieMi.h"
extern NSMutableArray *searchResults;
extern NSString *rowString;
extern NSString *xiaoquIDString;
extern NSString *xiaoquming;
extern int CommunitySelectionSource;
extern int IsFiirst;
extern NSString *area_id;
@interface SheQuXuanZeViewController ()

@end

@implementation SheQuXuanZeViewController
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
   
    @try
    {
        
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat height=size.height;
    CGFloat width=size.width;
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 57,320, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"搜索列表"];
    mySearchBar.keyboardType=UIKeyboardTypeEmailAddress;
    [mySearchBar setTintColor:[UIColor orangeColor]];
    mySearchBar.backgroundColor=[UIColor clearColor];
    [self.view addSubview:mySearchBar];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    xiaoquliebiao=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 30)];
    xiaoquliebiao.text=@"    小区列表";
   [xiaoquliebiao setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    xiaoquliebiao.font=[UIFont systemFontOfSize:18];
    xiaoquliebiao.layer.borderWidth=0.5;
    xiaoquliebiao.layer.borderColor=[[UIColor grayColor] CGColor];
    xiaoquliebiao.layer.masksToBounds=YES;
    [self.view addSubview:xiaoquliebiao];
    
    mytableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 130, width, height-130)];
    mytableView.dataSource = self;
    mytableView.delegate = self;
    dataArray=[[NSMutableArray alloc]init];
    dataArray2=[[NSMutableArray alloc]init];
   // searchResults2=[[NSMutableArray alloc]init];
     arr=[[NSMutableArray alloc]init];
    if([CheckNetwork isExistenceNetwork]==1)
    {
        NSString *str1=@"{\"session\":\"\",\"city_id\":\"101\",\" search\":\"\"}";
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];

        [HttpPostExecutor postExecuteWithUrlStr:SheQuXuanZe_m24_02 Paramters:Str FinishCallbackBlock:^(NSString *result){
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {

            NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                NSLog(@"  Llllllll  %@",str_jiemi);
            arr=[[NSMutableArray alloc]init];
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error = nil;
            NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
            
            NSString *str_tishi=[rootDic objectForKey:@"ecode"];
            int intb = [str_tishi intValue];
            if (intb==1000)
            {
                dataArray=[rootDic objectForKey:@"info_array"];
                [self.view addSubview:mytableView];
            }
            if (intb==4000)
            {
                [self showWithCustomView:@"服务器内部错误"];
                
            }
            }
           
        }];

    }

     xuanze=[[XuanZeChengShiViewController alloc]init];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        UIAlertView * alert =
        [[UIAlertView alloc]
         initWithTitle:@"错误"
         message: [[NSString alloc] initWithFormat:@"%@",e]
         delegate:self
         cancelButtonTitle:nil
         otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count;
    }
    else {
        return dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [mytableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        //cell.textLabel.text = searchResults[indexPath.row];
        UILabel *a=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 300, 30)];
        a.backgroundColor=[UIColor whiteColor];
        a.text=[searchResults[indexPath.row] objectForKey:@"quarter_name"];
        [cell addSubview:a];
        UILabel *b=[[UILabel alloc]initWithFrame:CGRectMake(20, 30, 300, 30)];
        b.backgroundColor=[UIColor whiteColor];
        b.textColor=[UIColor grayColor];
        b.text=[searchResults[indexPath.row] objectForKey:@"adress"];
        [cell addSubview:b];
    }
    else {
        UILabel *a=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 300, 30)];
        a.backgroundColor=[UIColor whiteColor];
        a.text=[dataArray[indexPath.row] objectForKey:@"quarter_name"];
        [cell addSubview:a];
        UILabel *b=[[UILabel alloc]initWithFrame:CGRectMake(20, 30, 300, 30)];
        b.backgroundColor=[UIColor whiteColor];
        b.textColor=[UIColor grayColor];
        b.text=[dataArray[indexPath.row] objectForKey:@"adress"];
        [cell addSubview:b];
    }
    label_line=[[UILabel alloc]initWithFrame:CGRectMake(0, 59, 320, 1)];
    label_line.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];

    [cell addSubview:label_line];
        return cell;
}
#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    @try
    {

    
    searchResults = [[NSMutableArray alloc]init];
    
    if (mySearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
        for (int i=0; i<dataArray.count; i++) {
            if ([ChineseInclude isIncludeChineseInString:[dataArray[i] objectForKey:@"quarter_name"]])
            {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:[dataArray[i] objectForKey:@"quarter_name"]];
                NSRange titleResult=[tempPinYinStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:[dataArray[i] objectForKey:@"quarter_name"]];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                }
            }
            else {
                NSRange titleResult=[[dataArray[i] objectForKey:@"quarter_name"] rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                }
            }
        }
    }
    else if (mySearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
        for (int i=0; i<dataArray.count; i++)
        {
            NSString *tempStr=[dataArray[i] objectForKey:@"quarter_name"];
            NSRange titleResult=[tempStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0)
            {
                [searchResults addObject:dataArray[i]];
                
            }
            
            
        }
    }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        UIAlertView * alert =
        [[UIAlertView alloc]
         initWithTitle:@"错误"
         message: [[NSString alloc] initWithFormat:@"%@",e]
         delegate:self
         cancelButtonTitle:nil
         otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
    //NSLog(@"%@",searchResults);
}
- (void)showWithCustomView:(NSString*)aString
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    @try
    {
        

    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        rowString = [searchResults[indexPath.row] objectForKey:@"quarter_name"];
        xiaoquIDString = [searchResults[indexPath.row] objectForKey:@"quarter_id"];
        xiaoquming=[searchResults[indexPath.row] objectForKey:@"quarter_name"];
        NSString *xianquId=[searchResults[indexPath.row] objectForKey:@"area_id"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:xiaoquming forKey:@"xiaoqu"];
        [userDefaults setObject:xiaoquIDString forKey:@"xiaoquID"];
        [userDefaults setObject:xianquId forKey:@"xianquId"];

        [SurveyRunTimeData sharedInstance].quarter_id = xiaoquIDString;
        [SurveyRunTimeData sharedInstance].area_id = xianquId;
        
        
        if (CommunitySelectionSource==1)
        {
            DengLuHouZhuYeViewController *zhuye=[[DengLuHouZhuYeViewController alloc]init];
            [self presentViewController:zhuye animated:NO completion:nil];
        }
        if (CommunitySelectionSource==2)
        {
            [self dismissViewControllerAnimated:NO completion:nil];

        }
        
    }
    else
    {
        rowString = [dataArray[indexPath.row] objectForKey:@"quarter_name"];
        xiaoquIDString = [dataArray[indexPath.row] objectForKey:@"quarter_id"];
        xiaoquming=[dataArray[indexPath.row] objectForKey:@"quarter_name"];
        NSString *xianquId=[dataArray[indexPath.row] objectForKey:@"area_id"];

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:xiaoquming forKey:@"xiaoqu"];
        [userDefaults setObject:xiaoquIDString forKey:@"xiaoquID"];
        [userDefaults setObject:xianquId forKey:@"xianquId"];

        [SurveyRunTimeData sharedInstance].quarter_id = xiaoquIDString;
        [SurveyRunTimeData sharedInstance].area_id = xianquId;

        if (CommunitySelectionSource==1)
        {
            DengLuHouZhuYeViewController *zhuye=[[DengLuHouZhuYeViewController alloc]init];
            [self presentViewController:zhuye animated:NO completion:nil];
        }
         if (CommunitySelectionSource==2)
         {
            [self dismissViewControllerAnimated:NO completion:nil];
            
        }

    }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        UIAlertView * alert =
        [[UIAlertView alloc]
         initWithTitle:@"错误"
         message: [[NSString alloc] initWithFormat:@"%@",e]
         delegate:self
         cancelButtonTitle:nil
         otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.frame = CGRectMake(-320, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    [UIView animateWithDuration:0.7 animations:^{
        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    } completion:^(BOOL finished) {
        ;
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fanhui:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)guanbi:(id)sender
{
    [mySearchBar resignFirstResponder];

}
//IOS 6.0 以上禁止横屏
- (BOOL)shouldAutorotate
{
    return NO;
}
//IOS 6.0 以下禁止横屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (IBAction)xuanzechengshi:(id)sender {
    [self presentViewController:xuanze animated:NO completion:nil];
    
}
@end
