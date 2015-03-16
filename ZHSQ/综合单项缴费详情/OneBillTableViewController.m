//
//  OneBillTableViewController.m
//  ZHSQ
//
//  Created by lacom on 15/3/16.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "OneBillTableViewController.h"

@interface OneBillTableViewController ()
{
    NSArray *itemTitleArr;
    NSArray *itemDetailArr;
}

@end

@implementation OneBillTableViewController
@synthesize detailDic;
@synthesize billType;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn"] style:UIBarButtonItemStyleBordered target:self action:@selector(backToList)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    switch (billType) {
        //水费
        case 1:
            itemTitleArr = @[@"账单编号",@"收费单位",@"客户姓名",@"客户地址",@"本次抄表日期",@"上次水表数",@"本次水表数",@"用水量",@"单价",@"水费",@"优惠金额",@"应缴金额"];
            itemDetailArr = @[@"pay_id",@"property_name",@"username",@"客户地址",@"peroid_end",@"water_num_start",@"water_num_end",@"watervolume",@"price",@"money1",@"money2",@"money_sum"];
            break;
            //物业费
        case 2:
            itemTitleArr = @[@"账单编号",@"收费单位",@"客户姓名",@"客户地址",@"建筑面积",@"单价",@"缴费期间",@"物业费",@"优惠金额",@"应缴金额"];
            itemDetailArr = @[@"pay_id",@"property_name",@"username",@"客户地址",@"square",@"price",@"缴费期间",@"watervolume",@"price",@"money1",@"money2",@"money_sum"];
            break;
            //暖气费
        case 3:
            itemTitleArr = @[@"账单编号",@"收费单位",@"客户姓名",@"客户地址",@"本次抄表日期",@"上次水表数",@"本次水表数",@"用水量",@"单价",@"水费",@"优惠金额",@"应缴金额"];
            itemDetailArr = @[@"pay_id",@"property_name",@"username",@"客户地址",@"peroid_end",@"water_num_start",@"water_num_end",@"watervolume",@"price",@"money1",@"money2",@"money_sum"];
            break;
            //停车费
        case 4:
            itemTitleArr = @[@"账单编号",@"收费单位",@"客户姓名",@"客户地址",@"本次抄表日期",@"上次水表数",@"本次水表数",@"用水量",@"单价",@"水费",@"优惠金额",@"应缴金额"];
            itemDetailArr = @[@"pay_id",@"property_name",@"username",@"客户地址",@"peroid_end",@"water_num_start",@"water_num_end",@"watervolume",@"price",@"money1",@"money2",@"money_sum"];
            break;
            
        default:
            break;
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSString *str = [NSString stringWithFormat:@"row:%d",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.detailTextLabel.numberOfLines = 0;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"账单编号:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",detailDic[@"pay_id"]];
            break;
        case 1:
            cell.textLabel.text = @"收费单位:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",detailDic[@"property_name"]];
            break;
        case 2:
            cell.textLabel.text = @"客户姓名:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",detailDic[@"username"]];
            break;
        case 3:
            cell.textLabel.text = @"客户地址:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",[detailDic objectForKey:@"community_name"],[detailDic objectForKey:@"quarter_name"],[detailDic objectForKey:@"building_name"],[detailDic objectForKey:@"unit_name"],[detailDic objectForKey:@"room_name"]];
            break;
        case 4:
            cell.textLabel.text = @"建筑面积:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",detailDic[@"pay_id"]];
            break;
        case 5:
            cell.textLabel.text = @"单价:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",detailDic[@"pay_id"]];
            break;
        case 6:
            cell.textLabel.text = @"缴费期间:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@",detailDic[@"period_start"],detailDic[@"peroid_end"]];
            break;
        case 7:
        {
            switch (self.billType) {
                case 1:
                    cell.textLabel.text = @"水费:";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",detailDic[@"pay_id"]];
                    break;
                case 2:
                    cell.textLabel.text = @"物业费:";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",detailDic[@"pay_id"]];
                    break;
                case 3:
                    cell.textLabel.text = @"暖气费:";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",detailDic[@"pay_id"]];
                    break;
                case 4:
                    cell.textLabel.text = @"停车费:";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",detailDic[@"pay_id"]];
                    break;
                    
                default:
                    break;
            }
        }
            
            break;
        case 8:
            cell.textLabel.text = @"优惠金额:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",detailDic[@"money2"]];
            break;
        case 9:
            cell.textLabel.text = @"应缴金额:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",detailDic[@"money_sum"]];
            break;
        
            
        default:
            break;
    }
    
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString *FooterId = @"BillCellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:FooterId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FooterId];
        UIButton *jiaofeiBtn = [[UIButton alloc]initWithFrame:CGRectMake(80, 10, 160, 44)];
        [jiaofeiBtn setBackgroundImage:[UIImage imageNamed:@"navigationBar"] forState:UIControlStateNormal];
        [jiaofeiBtn setTitle:@"缴费" forState:UIControlStateNormal];
        [jiaofeiBtn addTarget:self action:@selector(jiaofei:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
    
}

/*
 单项缴费
 */
- (IBAction)jiaofei:(id)sender
{
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



//返回上一级页面
- (void)backToList{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
