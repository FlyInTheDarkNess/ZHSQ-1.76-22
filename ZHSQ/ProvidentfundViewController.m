//
//  ProvidentfundViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 15-1-5.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "ProvidentfundViewController.h"
#import "FoodMedicineHttpService.h"
#import "Header.h"
extern NSString *Name;
@interface ProvidentfundViewController ()
{
    NSArray *idList;
    //请求
    FoodMedicineHttpService *sqHttpSer;
    //当前列表数据
    NSMutableArray *newsArr;
    
    int startIndex;
    
    BOOL isUp;
    
}

@end

@implementation ProvidentfundViewController

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
    @try
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        CGRect rect=[[UIScreen mainScreen]bounds];
        CGSize size=rect.size;
        CGFloat Width=size.width;//Width 屏幕宽度
        CGFloat Hidth=size.height;//Hidth 屏幕高度
        
        self.view.backgroundColor=[UIColor colorWithRed:198/255.0 green:205/255.0 blue:213/255.0 alpha:1];
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];
        
        label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
        label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        label_title.text=@"我的公积金信息";
        label_title.textColor=[UIColor whiteColor];
        [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        label_title.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:label_title];
        fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
        [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
        [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
        [self.view addSubview:fanhui];
        myview=[[UIView alloc]initWithFrame:CGRectMake(20, 80, 280, Hidth-100)];
        myview.backgroundColor=[UIColor whiteColor];
        myview.layer.masksToBounds = YES;
        myview.layer.cornerRadius = 5;
        myview.layer.borderWidth = 0.5;
        myview.layer.borderColor=[[UIColor grayColor] CGColor];
        [self.view addSubview:myview];
        label1=[[UILabel alloc]initWithFrame:CGRectMake(3, 20, 80, 30)];
        label1.text=@"您的姓名:";
        label1.textAlignment=NSTextAlignmentRight;
        label1.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label1];
        label_xingming=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 180, 30)];
        label_xingming.text=Name;
        label_xingming.textColor=[UIColor blueColor];
        label_xingming.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label_xingming];
        label2=[[UILabel alloc]initWithFrame:CGRectMake(5, 50, 270, 1)];
        label2.backgroundColor=[UIColor grayColor];
        [myview addSubview:label2];
        
        label3=[[UILabel alloc]initWithFrame:CGRectMake(3, 50, 80, 40)];
        label3.text=@"性    别:";
        label3.textAlignment=NSTextAlignmentRight;
        label3.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label3];
        
        label_xingbie=[[UILabel alloc]initWithFrame:CGRectMake(90, 50, 180, 40)];
        
        label_xingbie.textColor=[UIColor blueColor];
        label_xingbie.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label_xingbie];
        
        label4=[[UILabel alloc]initWithFrame:CGRectMake(5, 90, 270, 1)];
        label4.backgroundColor=[UIColor grayColor];
        [myview addSubview:label4];
        
        label5=[[UILabel alloc]initWithFrame:CGRectMake(3, 90, 80, 40)];
        label5.text=@"公积金账号:";
        label5.textAlignment=NSTextAlignmentRight;
        label5.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label5];
        
        label_zhanghao=[[UILabel alloc]initWithFrame:CGRectMake(90, 90, 180, 40)];
        
        label_zhanghao.textColor=[UIColor blueColor];
        label_zhanghao.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label_zhanghao];
        label6=[[UILabel alloc]initWithFrame:CGRectMake(5, 130, 270, 1)];
        label6.backgroundColor=[UIColor grayColor];
        [myview addSubview:label6];
        
        label7=[[UILabel alloc]initWithFrame:CGRectMake(3, 130, 80, 40)];
        label7.text=@"工资基数:";
        label7.textAlignment=NSTextAlignmentRight;
        label7.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label7];
        label_jishu=[[UILabel alloc]initWithFrame:CGRectMake(90, 130, 180, 40)];
        
        label_jishu.textColor=[UIColor blueColor];
        label_jishu.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label_jishu];
        label8=[[UILabel alloc]initWithFrame:CGRectMake(5, 170, 270, 1)];
        label8.backgroundColor=[UIColor grayColor];
        [myview addSubview:label8];
        
        label9=[[UILabel alloc]initWithFrame:CGRectMake(3, 170, 80, 40)];
        label9.text=@"缴交额:";
        label9.textAlignment=NSTextAlignmentRight;
        label9.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label9];
        label_jiaoe=[[UILabel alloc]initWithFrame:CGRectMake(90, 170, 180, 40)];
        
        label_jiaoe.textColor=[UIColor blueColor];
        label_jiaoe.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label_jiaoe];
        label10=[[UILabel alloc]initWithFrame:CGRectMake(5, 210, 270, 1)];
        label10.backgroundColor=[UIColor grayColor];
        [myview addSubview:label10];
        
        label11=[[UILabel alloc]initWithFrame:CGRectMake(3, 210, 80, 40)];
        label11.text=@"缴至日期:";
        label11.textAlignment=NSTextAlignmentRight;
        label11.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label11];
        label_riqi=[[UILabel alloc]initWithFrame:CGRectMake(90, 210, 180, 40)];
        
        label_riqi.textColor=[UIColor blueColor];
        label_riqi.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label_riqi];
        label12=[[UILabel alloc]initWithFrame:CGRectMake(5, 250, 270, 1)];
        label12.backgroundColor=[UIColor grayColor];
        [myview addSubview:label12];
        
        label13=[[UILabel alloc]initWithFrame:CGRectMake(3, 250, 80, 40)];
        label13.text=@"个人余额:";
        label13.textAlignment=NSTextAlignmentRight;
        label13.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label13];
        label_xingming=[[UILabel alloc]initWithFrame:CGRectMake(90, 250, 180, 40)];
        
        label_xingming.textColor=[UIColor blueColor];
        label_xingming.font=[UIFont systemFontOfSize:14];
        [myview addSubview:label_xingming];
        [SVProgressHUD showWithStatus:@"正在查询..." maskType:SVProgressHUDMaskTypeClear];
        [self dataInit];
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
- (void)dataInit
{
    //NSString *str1=@"{\"city_id\":\"101\",\"article_type_id\":\"56\"}";
    GongJiJin*customer =[[GongJiJin alloc]init];
    customer.id_card=[MyMD5 md5:Card_id];
    customer.real_name=Name;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];

    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[FoodMedicineHttpService alloc]init];
    sqHttpSer.strUrl = GongJiJin_m1_04;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    //isUp = YES;
    
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 3:{
            startIndex = 0;
            str_gongjijin=sqHttpSer.responDict[@"ecode"];
            NSLog(@"%@",sqHttpSer.responDict);
            int intb = [str_gongjijin intValue];
            
            if (intb==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据!" duration:1.5];
            }
            if (intb==1000)
            {
                [SVProgressHUD showSuccessWithStatus:@"查询成功" duration:1];
                label_xingbie.text=sqHttpSer.responDict[@"sex"];
                label_zhanghao.text=sqHttpSer.responDict[@"provident_fund_account"];
                label_jishu.text=sqHttpSer.responDict[@"payment_potency"];
                label_jiaoe.text=sqHttpSer.responDict[@"payment_quota"];
                label_riqi.text=sqHttpSer.responDict[@"payment_date"];
                label_xingming.text=sqHttpSer.responDict[@"provident_balance"];
            }

//            NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 10]];
//            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
//            sqHttpSer = [[FoodMedicineHttpService alloc]init];
//            sqHttpSer.strUrl = SheQuDongTai_m7_02;
//            sqHttpSer.delegate = self;
//            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
//            [sqHttpSer beginQuery];
            
        }
            break;
      
        default:
            break;
    }
    
}
-(void)didReceieveFail:(NSInteger)tag{
    
}
//-(NSString *)getFromArr:(NSArray *)arr withNumber:(int)num{
//    if (arr.count == 0) {
//        return @"";
//    }
//    NSMutableString *finalStr =[[NSMutableString alloc] initWithString:@"["];
//    if (arr.count < num) {
//        num = arr.count;
//    }
//    for (int index = startIndex; index < num; index++) {
//        [finalStr appendFormat:@"{\"id\":\"%@\"},",arr[index][@"id"]];
//        startIndex++;
//    }
//    NSUInteger location = [finalStr length]-1;
//    NSRange range = NSMakeRange(location, 1);
//    [finalStr replaceCharactersInRange:range withString:@"]"];
//    return finalStr;
//}
//

-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
