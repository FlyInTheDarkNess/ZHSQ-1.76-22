//
//  ChangTuKeYunViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-11-11.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ChangTuKeYunViewController.h"
extern NSMutableArray *arr_ChangTuKeYun;
@interface ChangTuKeYunViewController ()

@end

@implementation ChangTuKeYunViewController



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
    self.view.backgroundColor=[UIColor whiteColor];
    
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat height=size.height;
    CGFloat width=size.width;
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];

    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, width, 40)];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label_title.text=@"长途客运";
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.textColor=[UIColor whiteColor];
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    btn_changtu=[[UIButton alloc]initWithFrame:CGRectMake(0, 70, 80, 20)];
    [btn_changtu setTitle:@"长途" forState:UIControlStateNormal];
    [btn_changtu setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn_changtu addTarget:self action:@selector(changtu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_changtu];
    
    biaoxian=[[UILabel alloc]initWithFrame:CGRectMake(0, 90, 80, 1)];
    biaoxian.backgroundColor=[UIColor redColor];
    [self.view addSubview:biaoxian];
    
    btn_guolu=[[UIButton alloc]initWithFrame:CGRectMake(80, 70, 80, 20)];
    [btn_guolu setTitle:@"过路" forState:UIControlStateNormal];
    [btn_guolu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_guolu addTarget:self action:@selector(guolu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_guolu];

    btn_shinei=[[UIButton alloc]initWithFrame:CGRectMake(160, 70, 80, 20)];
    [btn_shinei setTitle:@"市内" forState:UIControlStateNormal];
    [btn_shinei setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_shinei addTarget:self action:@selector(shinei) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_shinei];

    btn_chengxiang=[[UIButton alloc]initWithFrame:CGRectMake(240, 70, 80, 20)];
    [btn_chengxiang setTitle:@"城乡" forState:UIControlStateNormal];
    [btn_chengxiang setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_chengxiang addTarget:self action:@selector(chengxiang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_chengxiang];

    hengxian=[[UILabel alloc]initWithFrame:CGRectMake(0, 91, 320, 0.5)];
    hengxian.backgroundColor=[UIColor grayColor];
    [self.view addSubview:hengxian];
        
        
        {
            //   北京-莱芜
            NSMutableArray *Arr1=[NSMutableArray array];
            
            {
                NSArray *arr1=[NSArray arrayWithObjects:@"德州", @"258", @"154", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"献县", @"354", @"154", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"河涧", @"385", @"154", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"任丘", @"418", @"154", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"霸县", @"479", @"154", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"北京", @"576", @"154", nil];
                [Arr1 addObject:arr1];
                [Arr1 addObject:arr2];
                [Arr1 addObject:arr3];
                [Arr1 addObject:arr4];
                [Arr1 addObject:arr5];
                [Arr1 addObject:arr6];
            }
            NSMutableDictionary *dic1=[NSMutableDictionary dictionaryWithObject:Arr1 forKey:@"tujing"];
            [dic1 setValue:@"北京-莱芜" forKey:@"qishizhan"];
            //   莱芜-温州
            NSMutableArray *Arr2=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"郯城", @"224", @"70", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"新沂", @"253", @"76", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"沭阳", @"305", @"100", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"淮安", @"330", @"105", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"淮阴", @"365", @"120", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"江都", @"520", @"170", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"江阴", @"624", @"193", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"无锡", @"654", @"198", nil];
                NSArray *arr9=[NSArray arrayWithObjects:@"苏州", @"706", @"210", nil];
                NSArray *arr10=[NSArray arrayWithObjects:@"嘉兴", @"774",@"218", nil];
                NSArray *arr11=[NSArray arrayWithObjects:@"杭州", @"881", @"230", nil];
                NSArray *arr12=[NSArray arrayWithObjects:@"绍兴", @"957", @"248", nil];
                NSArray *arr13=[NSArray arrayWithObjects:@"临海", @"1167", @"303", nil];
                NSArray *arr14=[NSArray arrayWithObjects:@"黄岩", @"1199", @"312", nil];
                NSArray *arr15=[NSArray arrayWithObjects:@"乐清", @"1331", @"346", nil];
                NSArray *arr16=[NSArray arrayWithObjects:@"温州", @"1402", @"360", nil];
                [Arr2 addObject:arr1];
                [Arr2 addObject:arr2];
                [Arr2 addObject:arr3];
                [Arr2 addObject:arr4];
                [Arr2 addObject:arr5];
                [Arr2 addObject:arr6];
                [Arr2 addObject:arr7];
                [Arr2 addObject:arr8];
                [Arr2 addObject:arr9];
                [Arr2 addObject:arr10];
                [Arr2 addObject:arr11];
                [Arr2 addObject:arr12];
                [Arr2 addObject:arr13];
                [Arr2 addObject:arr14];
                [Arr2 addObject:arr15];
                [Arr2 addObject:arr16];
            }
            NSMutableDictionary *dic2=[NSMutableDictionary dictionaryWithObject:Arr2 forKey:@"tujing"];
            [dic2 setValue:@"莱芜-温州" forKey:@"qishizhan"];
            
            //   莱芜-上海
            NSMutableArray *Arr3=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"郯城", @"224", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"新沂", @"253", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"沭阳", @"305", @"100", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"淮阴", @"365", @"120", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"宝应", @"430", @"138", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"江都", @"520", @"170", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"靖江", @"608", @"188", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"江阴", @"624", @"193", nil];
                NSArray *arr9=[NSArray arrayWithObjects:@"无锡", @"654", @"198", nil];
                NSArray *arr10=[NSArray arrayWithObjects:@"苏州", @"706", @"210", nil];
                NSArray *arr11=[NSArray arrayWithObjects:@"昆山", @"740", @"222", nil];
                NSArray *arr12=[NSArray arrayWithObjects:@"上海", @"780", @"232", nil];
                [Arr3 addObject:arr1];
                [Arr3 addObject:arr2];
                [Arr3 addObject:arr3];
                [Arr3 addObject:arr4];
                [Arr3 addObject:arr5];
                [Arr3 addObject:arr6];
                [Arr3 addObject:arr7];
                [Arr3 addObject:arr8];
                [Arr3 addObject:arr9];
                [Arr3 addObject:arr10];
                [Arr3 addObject:arr11];
                [Arr3 addObject:arr12];
            }
            NSMutableDictionary *dic3=[NSMutableDictionary dictionaryWithObject:Arr3 forKey:@"tujing"];
            [dic3 setValue:@"莱芜-上海" forKey:@"qishizhan"];
            
            //   莱芜-商丘
            NSMutableArray *Arr4=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"楼德", @"96", @" ", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"曲阜", @"148", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"兖州", @"164", @"73", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"济宁", @"195", @"85", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"金乡", @"253", @"92", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"单县", @"291", @"98", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"青固集", @"320", @" ", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"商丘", @"355", @" ", nil];
                [Arr4 addObject:arr1];
                [Arr4 addObject:arr2];
                [Arr4 addObject:arr3];
                [Arr4 addObject:arr4];
                [Arr4 addObject:arr5];
                [Arr4 addObject:arr6];
                [Arr4 addObject:arr7];
                [Arr4 addObject:arr8];
            }
            NSMutableDictionary *dic4=[NSMutableDictionary dictionaryWithObject:Arr4 forKey:@"tujing"];
            [dic4 setValue:@"莱芜-商丘" forKey:@"qishizhan"];
            
            //   莱芜-青岛
            NSMutableArray *Arr5=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"沂源", @"53", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"九山", @"92", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"上流庄", @"108", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"东于沟", @"113", @"50", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"马站", @"128", @"", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"孟疃", @"157", @"65", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"贾悦", @"170", @"84", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"诸城", @"192", @"107", nil];
                NSArray *arr9=[NSArray arrayWithObjects:@"卜集", @"225", @"", nil];
                NSArray *arr10=[NSArray arrayWithObjects:@"胶州", @"260", @"", nil];
                NSArray *arr11=[NSArray arrayWithObjects:@"城阳", @"295", @"", nil];
                NSArray *arr12=[NSArray arrayWithObjects:@"青岛", @"340", @"", nil];
                [Arr5 addObject:arr1];
                [Arr5 addObject:arr2];
                [Arr5 addObject:arr3];
                [Arr5 addObject:arr4];
                [Arr5 addObject:arr5];
                [Arr5 addObject:arr6];
                [Arr5 addObject:arr7];
                [Arr5 addObject:arr8];
                [Arr5 addObject:arr9];
                [Arr5 addObject:arr10];
                [Arr5 addObject:arr11];
                [Arr5 addObject:arr12];
            }
            NSMutableDictionary *dic5=[NSMutableDictionary dictionaryWithObject:Arr5 forKey:@"tujing"];
            [dic5 setValue:@"莱芜-青岛" forKey:@"qishizhan"];
            
            //   莱芜-烟台
            NSMutableArray *Arr6=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"潍坊", @"186", @"63", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"寒亭", @"201", @"65", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"昌邑", @"219", @"68", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"新河", @"243", @"73", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"沙河", @"262", @"78", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"莱州", @"285", @"85", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"龙口", @"356", @"103", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"黄县", @"372", @"108", nil];
                NSArray *arr9=[NSArray arrayWithObjects:@"蓬莱", @"403", @"116", nil];
                NSArray *arr10=[NSArray arrayWithObjects:@"三十里堡", @"453", @"139", nil];
                NSArray *arr11=[NSArray arrayWithObjects:@"烟台", @"467", @"", nil];
                [Arr6 addObject:arr1];
                [Arr6 addObject:arr2];
                [Arr6 addObject:arr3];
                [Arr6 addObject:arr4];
                [Arr6 addObject:arr5];
                [Arr6 addObject:arr6];
                [Arr6 addObject:arr7];
                [Arr6 addObject:arr8];
                [Arr6 addObject:arr9];
                [Arr6 addObject:arr10];
                [Arr6 addObject:arr11];
            }
            NSMutableDictionary *dic6=[NSMutableDictionary dictionaryWithObject:Arr6 forKey:@"tujing"];
            [dic6 setValue:@"莱芜-烟台" forKey:@"qishizhan"];
            
            //   莱芜-威海
            NSMutableArray *Arr7=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"潍坊", @"186", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"寒亭", @"201", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"昌邑", @"219", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"沙河", @"262", @"103", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"莱州", @"285", @"108", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"龙口", @"356", @"116", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"黄县", @"372", @"139", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"蓬莱", @"403", @"153", nil];
                NSArray *arr9=[NSArray arrayWithObjects:@"烟台", @"467", @"158", nil];
                NSArray *arr10=[NSArray arrayWithObjects:@"牟平", @"507", @"", nil];
                NSArray *arr11=[NSArray arrayWithObjects:@"威海", @"559", @"", nil];
                [Arr7 addObject:arr1];
                [Arr7 addObject:arr2];
                [Arr7 addObject:arr3];
                [Arr7 addObject:arr4];
                [Arr7 addObject:arr5];
                [Arr7 addObject:arr6];
                [Arr7 addObject:arr7];
                [Arr7 addObject:arr8];
                [Arr7 addObject:arr9];
                [Arr7 addObject:arr10];
                [Arr7 addObject:arr11];
            }
            NSMutableDictionary *dic7=[NSMutableDictionary dictionaryWithObject:Arr7 forKey:@"tujing"];
            [dic7 setValue:@"莱芜-威海" forKey:@"qishizhan"];
            
            //   莱芜-石岛
            NSMutableArray *Arr8=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"昌乐", @"163", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"潍坊", @"186", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"石埠", @"259", @"88", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"平度", @"303", @"98", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"莱西", @"349", @"108", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"莱阳", @"377", @"128", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"海阳", @"428", @"148", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"乳山", @"486", @"158", nil];
                NSArray *arr9=[NSArray arrayWithObjects:@"文登", @"530", @"168", nil];
                NSArray *arr10=[NSArray arrayWithObjects:@"荣城", @"563", @"175", nil];
                NSArray *arr11=[NSArray arrayWithObjects:@"石岛", @"588", @"", nil];
                
                [Arr8 addObject:arr1];
                [Arr8 addObject:arr2];
                [Arr8 addObject:arr3];
                [Arr8 addObject:arr4];
                [Arr8 addObject:arr5];
                [Arr8 addObject:arr6];
                [Arr8 addObject:arr7];
                [Arr8 addObject:arr8];
                [Arr8 addObject:arr9];
                [Arr8 addObject:arr10];
                [Arr8 addObject:arr11];
            }
            NSMutableDictionary *dic8=[NSMutableDictionary dictionaryWithObject:Arr8 forKey:@"tujing"];
            [dic8 setValue:@"莱芜-石岛" forKey:@"qishizhan"];
            
            //   莱芜-黄岛
            NSMutableArray *Arr9=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"九山", @"104", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"马站", @"128", @"50", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"孟疃", @"157", @"58", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"贾悦", @"170", @"60", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"诸城", @"192", @"65", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"朱解", @"201", @"", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"瓦店", @"208", @"", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"杜家村", @"215", @"88", nil];
                NSArray *arr9=[NSArray arrayWithObjects:@"柏乡", @"219", @"95", nil];
                NSArray *arr10=[NSArray arrayWithObjects:@"六旺", @"228", @"", nil];
                NSArray *arr11=[NSArray arrayWithObjects:@"胶南", @"260", @"", nil];
                NSArray *arr12=[NSArray arrayWithObjects:@"黄岛", @"316", @"", nil];
                [Arr9 addObject:arr1];
                [Arr9 addObject:arr2];
                [Arr9 addObject:arr3];
                [Arr9 addObject:arr4];
                [Arr9 addObject:arr5];
                [Arr9 addObject:arr6];
                [Arr9 addObject:arr7];
                [Arr9 addObject:arr8];
                [Arr9 addObject:arr9];
                [Arr9 addObject:arr10];
                [Arr9 addObject:arr11];
                [Arr9 addObject:arr12];
            }
            NSMutableDictionary *dic9=[NSMutableDictionary dictionaryWithObject:Arr9 forKey:@"tujing"];
            [dic9 setValue:@"莱芜-黄岛" forKey:@"qishizhan"];
            
            //   莱芜-胶南
            NSMutableArray *Arr10=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"九山", @"104", @"50", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"马站", @"128", @"58", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"孟疃", @"157", @"60", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"贾悦", @"170", @"65", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"诸城（服务区）", @"192", @"88", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"胶南", @"260", @"", nil];
                
                [Arr10 addObject:arr1];
                [Arr10 addObject:arr2];
                [Arr10 addObject:arr3];
                [Arr10 addObject:arr4];
                [Arr10 addObject:arr5];
                [Arr10 addObject:arr6];
            }
            NSMutableDictionary *dic10=[NSMutableDictionary dictionaryWithObject:Arr10 forKey:@"tujing"];
            [dic10 setValue:@"莱芜-胶南" forKey:@"qishizhan"];
            
            //   莱芜-莱阳
            NSMutableArray *Arr11=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"临朐", @"135", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"青州路口", @"150", @"45", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"寿光路口", @"172", @"62", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"昌乐", @"203", @"73", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"潍坊", @"226", @"88", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"石埠", @"259", @"88", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"明村路口", @"275", @"98", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"平度", @"303", @"108", nil];
                NSArray *arr9=[NSArray arrayWithObjects:@"莱西", @"349", @"", nil];
                NSArray *arr10=[NSArray arrayWithObjects:@"莱阳", @"377", @"", nil];
                [Arr11 addObject:arr1];
                [Arr11 addObject:arr2];
                [Arr11 addObject:arr3];
                [Arr11 addObject:arr4];
                [Arr11 addObject:arr5];
                [Arr11 addObject:arr6];
                [Arr11 addObject:arr7];
                [Arr11 addObject:arr8];
                [Arr11 addObject:arr9];
                [Arr11 addObject:arr10];
            }
            NSMutableDictionary *dic11=[NSMutableDictionary dictionaryWithObject:Arr11 forKey:@"tujing"];
            [dic11 setValue:@"莱芜-莱阳" forKey:@"qishizhan"];
            
            //   莱芜-日照
            NSMutableArray *Arr12=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"张庄", @"42", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"贾庄", @"63", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"东指", @"69", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"代古", @"77", @"", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"高庄", @"95", @"31", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"夏蔚", @"113", @"36", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"沂水", @"154", @"44", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"莒县", @"186", @"55", nil];
                NSArray *arr9=[NSArray arrayWithObjects:@"竖旗", @"217", @"63", nil];
                NSArray *arr10=[NSArray arrayWithObjects:@"陈疃", @"239", @"68", nil];
                NSArray *arr11=[NSArray arrayWithObjects:@"日照", @"260", @"73", nil];
                [Arr12 addObject:arr1];
                [Arr12 addObject:arr2];
                [Arr12 addObject:arr3];
                [Arr12 addObject:arr4];
                [Arr12 addObject:arr5];
                [Arr12 addObject:arr6];
                [Arr12 addObject:arr7];
                [Arr12 addObject:arr8];
                [Arr12 addObject:arr9];
                [Arr12 addObject:arr10];
                [Arr12 addObject:arr11];
                
            }
            NSMutableDictionary *dic12=[NSMutableDictionary dictionaryWithObject:Arr12 forKey:@"tujing"];
            [dic12 setValue:@"莱芜-日照" forKey:@"qishizhan"];
            
            //   莱芜-莒县
            NSMutableArray *Arr13=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"张庄", @"42", @"20", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"贾庄", @"63", @"26", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"东指", @"69", @"27", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"代古", @"77", @"29", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"高庄", @"95", @"31", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"夏蔚", @"113", @"36", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"沂水", @"154", @"44", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"莒县", @"186", @"55", nil];
                
                [Arr13 addObject:arr1];
                [Arr13 addObject:arr2];
                [Arr13 addObject:arr3];
                [Arr13 addObject:arr4];
                [Arr13 addObject:arr5];
                [Arr13 addObject:arr6];
                [Arr13 addObject:arr7];
                [Arr13 addObject:arr8];
            }
            NSMutableDictionary *dic13=[NSMutableDictionary dictionaryWithObject:Arr13 forKey:@"tujing"];
            [dic13 setValue:@"莱芜-莒县" forKey:@"qishizhan"];
            
            //   莱芜-济宁
            NSMutableArray *Arr14=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"楼德", @"96", @"29", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"曲阜", @"148", @"43", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"兖州", @"164", @"48", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"济宁", @"195", @"57", nil];
                
                [Arr14 addObject:arr1];
                [Arr14 addObject:arr2];
                [Arr14 addObject:arr3];
                [Arr14 addObject:arr4];
            }
            NSMutableDictionary *dic14=[NSMutableDictionary dictionaryWithObject:Arr14 forKey:@"tujing"];
            [dic14 setValue:@"莱芜-济宁(7：30、8：30不去楼德，下午车去)" forKey:@"qishizhan"];
            
            //   莱芜-曹县
            NSMutableArray *Arr15=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"宁阳", @"132", @"42", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"汶上", @"162", @"46", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"梁山", @"205", @"59", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"郓城", @"258", @"78", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"荷泽", @"297", @"88", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"定陶", @"318", @"93", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"曹县", @"348", @"103", nil];
                
                [Arr15 addObject:arr1];
                [Arr15 addObject:arr2];
                [Arr15 addObject:arr3];
                [Arr15 addObject:arr4];
                [Arr15 addObject:arr5];
                [Arr15 addObject:arr6];
                [Arr15 addObject:arr7];
                
            }
            NSMutableDictionary *dic15=[NSMutableDictionary dictionaryWithObject:Arr15 forKey:@"tujing"];
            [dic15 setValue:@"莱芜-曹县" forKey:@"qishizhan"];
            
            //   莱芜-荷泽
            NSMutableArray *Arr16=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"汶上服务区", @"", @"46", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"嘉祥", @"", @"63", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"巨野高速路口", @"237", @"75", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"郓城", @"258", @"78", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"荷泽", @"297", @"88", nil];
                [Arr16 addObject:arr1];
                [Arr16 addObject:arr2];
                [Arr16 addObject:arr3];
                [Arr16 addObject:arr4];
                [Arr16 addObject:arr5];
            }
            NSMutableDictionary *dic16=[NSMutableDictionary dictionaryWithObject:Arr16 forKey:@"tujing"];
            [dic16 setValue:@"莱芜-荷泽" forKey:@"qishizhan"];
            
            //   莱芜-明水
            NSMutableArray *Arr17=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"兴无", @"42", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"大寨", @"46", @"15", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"青野", @"47", @"18", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"文祖", @"54", @"20", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"明水", @"68", @"", nil];
                
                [Arr17 addObject:arr1];
                [Arr17 addObject:arr2];
                [Arr17 addObject:arr3];
                [Arr17 addObject:arr4];
                [Arr17 addObject:arr5];
            }
            NSMutableDictionary *dic17=[NSMutableDictionary dictionaryWithObject:Arr17 forKey:@"tujing"];
            [dic17 setValue:@"莱芜-明水" forKey:@"qishizhan"];
            
            //   莱芜-泰安
            NSMutableArray *Arr18=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"泰安", @"55", @"17", nil];
                
                [Arr18 addObject:arr1];
            }
            NSMutableDictionary *dic18=[NSMutableDictionary dictionaryWithObject:Arr18 forKey:@"tujing"];
            [dic18 setValue:@"莱芜-泰安" forKey:@"qishizhan"];
            
            //   莱芜-新汶
            NSMutableArray *Arr19=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"高庄", @"26", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"北师店", @"33", @"10", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"新泰", @"43", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"新汶", @"52", @"", nil];
                
                [Arr19 addObject:arr1];
                [Arr19 addObject:arr2];
                [Arr19 addObject:arr3];
                [Arr19 addObject:arr4];
            }
            NSMutableDictionary *dic19=[NSMutableDictionary dictionaryWithObject:Arr19 forKey:@"tujing"];
            [dic19 setValue:@"莱芜-新汶" forKey:@"qishizhan"];
            
            //   莱芜-临沂
            NSMutableArray *Arr20=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"蒙阴", @"71", @"34", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"界牌", @"96", @"35", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"垛庄", @"103", @"42", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"青驼", @"123", @"47", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"半程", @"144", @"52", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"临沂", @"176", @"56", nil];
                [Arr20 addObject:arr1];
                [Arr20 addObject:arr2];
                [Arr20 addObject:arr3];
                [Arr20 addObject:arr4];
                [Arr20 addObject:arr5];
                [Arr20 addObject:arr6];
            }
            NSMutableDictionary *dic20=[NSMutableDictionary dictionaryWithObject:Arr20 forKey:@"tujing"];
            [dic20 setValue:@"莱芜-临沂" forKey:@"qishizhan"];
            
            //   莱芜-莱州
            NSMutableArray *Arr21=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"青州路口", @"150", @"45", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"寿光路口", @"172", @"62", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"寒亭", @"201", @"68", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"昌邑", @"229", @"73", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"灰埠路口", @"240", @"74", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"新河路口", @"242", @"76", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"沙河", @"262", @"78", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"莱州", @"285", @"85", nil];
                
                [Arr21 addObject:arr1];
                [Arr21 addObject:arr2];
                [Arr21 addObject:arr3];
                [Arr21 addObject:arr4];
                [Arr21 addObject:arr5];
                [Arr21 addObject:arr6];
                [Arr21 addObject:arr7];
                [Arr21 addObject:arr8];
            }
            NSMutableDictionary *dic21=[NSMutableDictionary dictionaryWithObject:Arr21 forKey:@"tujing"];
            [dic21 setValue:@"莱芜-莱州" forKey:@"qishizhan"];
            
            //   莱芜-济南
            NSMutableArray *Arr22=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"济南", @"130", @"20", nil];
                [Arr22 addObject:arr1];
            }
            NSMutableDictionary *dic22=[NSMutableDictionary dictionaryWithObject:Arr22 forKey:@"tujing"];
            [dic22 setValue:@"莱芜-济南" forKey:@"qishizhan"];
            
            //   莱芜-聊城
            NSMutableArray *Arr23=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"道郎", @"73", @"28", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"渔池", @"78", @"29", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"新肥城", @"89", @"33", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"石横", @"115", @"37", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"平阴", @"128", @"39", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"东阿", @"154", @"48", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"聊城", @"185", @"59", nil];
                [Arr23 addObject:arr1];
                [Arr23 addObject:arr2];
                [Arr23 addObject:arr3];
                [Arr23 addObject:arr4];
                [Arr23 addObject:arr5];
                [Arr23 addObject:arr6];
                [Arr23 addObject:arr7];
            }
            NSMutableDictionary *dic23=[NSMutableDictionary dictionaryWithObject:Arr23 forKey:@"tujing"];
            [dic23 setValue:@"莱芜-聊城" forKey:@"qishizhan"];
            
            //   莱芜-沂源
            NSMutableArray *Arr24=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"草埠", @"35", @"13", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"鲁村", @"41", @"14", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"沂源", @"53", @"16", nil];
                [Arr24 addObject:arr1];
                [Arr24 addObject:arr2];
                [Arr24 addObject:arr3];
            }
            NSMutableDictionary *dic24=[NSMutableDictionary dictionaryWithObject:Arr24 forKey:@"tujing"];
            [dic24 setValue:@"莱芜-沂源" forKey:@"qishizhan"];
            
            //   莱芜-潍坊
            NSMutableArray *Arr25=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"沂源", @"53", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"悦庄", @"62", @"20", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"三岔", @"82", @"26", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"嵩山", @"90", @"30", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"五井", @"100", @"40", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"临朐", @"135", @"50", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"乔官", @"157", @"63", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"徐将军", @"165", @"", nil];
                NSArray *arr9=[NSArray arrayWithObjects:@"潍坊", @"186", @"", nil];
                [Arr25 addObject:arr1];
                [Arr25 addObject:arr2];
                [Arr25 addObject:arr3];
                [Arr25 addObject:arr4];
                [Arr25 addObject:arr5];
                [Arr25 addObject:arr6];
                [Arr25 addObject:arr7];
                [Arr25 addObject:arr8];
                [Arr25 addObject:arr9];
            }
            NSMutableDictionary *dic25=[NSMutableDictionary dictionaryWithObject:Arr25 forKey:@"tujing"];
            [dic25 setValue:@"莱芜-潍坊" forKey:@"qishizhan"];
            
            //   莱芜-潍坊
            NSMutableArray *Arr26=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"白沙", @"82", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"吕匣", @"94", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"冶源", @"117", @"40", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"临朐", @"135", @"50", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"乔官", @"157", @"63", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"潍坊", @"186", @"", nil];
                [Arr26 addObject:arr1];
                [Arr26 addObject:arr2];
                [Arr26 addObject:arr3];
                [Arr26 addObject:arr4];
                [Arr26 addObject:arr5];
                [Arr26 addObject:arr6];
            }
            NSMutableDictionary *dic26=[NSMutableDictionary dictionaryWithObject:Arr26 forKey:@"tujing"];
            [dic26 setValue:@"莱芜-潍坊" forKey:@"qishizhan"];
            
            //   莱芜-沂南
            NSMutableArray *Arr27=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"蒙阴", @"75", @"34", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"岸提", @"125", @"38", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"沂南", @"155", @"50", nil];
                [Arr27 addObject:arr1];
                [Arr27 addObject:arr2];
                [Arr27 addObject:arr3];
            }
            NSMutableDictionary *dic27=[NSMutableDictionary dictionaryWithObject:Arr27 forKey:@"tujing"];
            [dic27 setValue:@"莱芜-沂南" forKey:@"qishizhan"];
            
            //   莱芜-滕州
            NSMutableArray *Arr28=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"曲阜", @"120", @"43", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"邹城", @"153", @"48", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"滕州", @"192", @"58", nil];
                [Arr28 addObject:arr1];
                [Arr28 addObject:arr2];
                [Arr28 addObject:arr3];
            }
            NSMutableDictionary *dic28=[NSMutableDictionary dictionaryWithObject:Arr28 forKey:@"tujing"];
            [dic28 setValue:@"莱芜-滕州" forKey:@"qishizhan"];
            
            //   莱芜-淄川
            NSMutableArray *Arr29=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"博山", @"46", @"17", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"淄川", @"66", @"24", nil];
                [Arr29 addObject:arr1];
                [Arr29 addObject:arr2];
            }
            NSMutableDictionary *dic29=[NSMutableDictionary dictionaryWithObject:Arr29 forKey:@"tujing"];
            [dic29 setValue:@"莱芜-淄川" forKey:@"qishizhan"];
            
            //   莱芜-沙河
            NSMutableArray *Arr30=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"新肥城", @"89", @"33", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"平阴", @"128", @"39", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"东阿", @"154", @"48", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"聊城", @"185", @"59", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"临清", @"239", @"80", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"童村", @"269", @"85", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"威县", @"285", @"90", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"平乡县", @"320", @"96", nil];
                NSArray *arr9=[NSArray arrayWithObjects:@"南和", @"345", @"105", nil];
                NSArray *arr10=[NSArray arrayWithObjects:@"邢台", @"361", @"110", nil];
                NSArray *arr11=[NSArray arrayWithObjects:@"沙河", @"391", @"113", nil];
                
                [Arr30 addObject:arr1];
                [Arr30 addObject:arr2];
                [Arr30 addObject:arr3];
                [Arr30 addObject:arr4];
                [Arr30 addObject:arr5];
                [Arr30 addObject:arr6];
                [Arr30 addObject:arr7];
                [Arr30 addObject:arr8];
                [Arr30 addObject:arr9];
                [Arr30 addObject:arr10];
                [Arr30 addObject:arr11];
            }
            NSMutableDictionary *dic30=[NSMutableDictionary dictionaryWithObject:Arr30 forKey:@"tujing"];
            [dic30 setValue:@"莱芜-沙河" forKey:@"qishizhan"];
            
            //   莱芜-淄博
            NSMutableArray *Arr31=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"淄博", @"100", @"30", nil];
                [Arr31 addObject:arr1];
            }
            NSMutableDictionary *dic31=[NSMutableDictionary dictionaryWithObject:Arr31 forKey:@"tujing"];
            [dic31 setValue:@"莱芜-淄博" forKey:@"qishizhan"];
            
            
            //   最后一步
            Array_changtu=[NSMutableArray array];
            [Array_changtu addObject:dic1];
            [Array_changtu addObject:dic2];
            [Array_changtu addObject:dic3];
            [Array_changtu addObject:dic4];
            [Array_changtu addObject:dic5];
            [Array_changtu addObject:dic6];
            [Array_changtu addObject:dic7];
            [Array_changtu addObject:dic8];
            [Array_changtu addObject:dic9];
            [Array_changtu addObject:dic10];
            [Array_changtu addObject:dic11];
            [Array_changtu addObject:dic12];
            [Array_changtu addObject:dic13];
            [Array_changtu addObject:dic14];
            [Array_changtu addObject:dic15];
            [Array_changtu addObject:dic16];
            [Array_changtu addObject:dic17];
            [Array_changtu addObject:dic18];
            [Array_changtu addObject:dic19];
            [Array_changtu addObject:dic20];
            [Array_changtu addObject:dic21];
            [Array_changtu addObject:dic22];
            [Array_changtu addObject:dic23];
            [Array_changtu addObject:dic24];
            [Array_changtu addObject:dic25];
            [Array_changtu addObject:dic26];
            [Array_changtu addObject:dic27];
            [Array_changtu addObject:dic28];
            [Array_changtu addObject:dic29];
            [Array_changtu addObject:dic30];
            [Array_changtu addObject:dic31];
        }
        // NSDictionary *ChangTu_Dictionary=[NSDictionary dictionaryWithObject:Array forKey:@"changtu_info"];
        
        
        /*
         **********              过路
         */
        {
            //   青州—曲阜
            NSMutableArray *Arr1=[NSMutableArray array];
            
            {
                NSArray *arr1=[NSArray arrayWithObjects:@"曲阜", @"", @"", nil];
                [Arr1 addObject:arr1];
            }
            NSMutableDictionary *dic1=[NSMutableDictionary dictionaryWithObject:Arr1 forKey:@"tujing"];
            [dic1 setValue:@"青州—曲阜" forKey:@"qishizhan"];
            //   曲阜—青州
            NSMutableArray *Arr2=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"临朐", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"青州", @"", @"", nil];
                [Arr2 addObject:arr1];
                [Arr2 addObject:arr2];
            }
            NSMutableDictionary *dic2=[NSMutableDictionary dictionaryWithObject:Arr2 forKey:@"tujing"];
            [dic2 setValue:@"曲阜—青州" forKey:@"qishizhan"];
            
            //   淄博—成武
            NSMutableArray *Arr3=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"曲阜", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"济宁", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"嘉祥", @"", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"荷泽", @"", @"", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"成武", @"", @"", nil];
                [Arr3 addObject:arr1];
                [Arr3 addObject:arr2];
                [Arr3 addObject:arr3];
                [Arr3 addObject:arr4];
                [Arr3 addObject:arr5];
            }
            NSMutableDictionary *dic3=[NSMutableDictionary dictionaryWithObject:Arr3 forKey:@"tujing"];
            [dic3 setValue:@"淄博—成武" forKey:@"qishizhan"];
            
            //   淄博—郑州
            NSMutableArray *Arr4=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"郓城", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"菏泽", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"兰考", @"", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"开封", @"", @"", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"郑州", @"", @"", nil];
                [Arr4 addObject:arr1];
                [Arr4 addObject:arr2];
                [Arr4 addObject:arr3];
                [Arr4 addObject:arr4];
                [Arr4 addObject:arr5];
            }
            NSMutableDictionary *dic4=[NSMutableDictionary dictionaryWithObject:Arr4 forKey:@"tujing"];
            [dic4 setValue:@"淄博—郑州" forKey:@"qishizhan"];
            
            //   泰安—东营
            NSMutableArray *Arr5=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"临朐", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"广饶", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"东营", @"", @"", nil];
                [Arr5 addObject:arr1];
                [Arr5 addObject:arr2];
                [Arr5 addObject:arr3];
            }
            NSMutableDictionary *dic5=[NSMutableDictionary dictionaryWithObject:Arr5 forKey:@"tujing"];
            [dic5 setValue:@"泰安—东营" forKey:@"qishizhan"];
            
            //   泰安—莱阳
            NSMutableArray *Arr6=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"潍坊", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"石埠", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"明村", @"", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"平度", @"", @"", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"莱西", @"", @"", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"莱阳", @"", @"", nil];
                [Arr6 addObject:arr1];
                [Arr6 addObject:arr2];
                [Arr6 addObject:arr3];
                [Arr6 addObject:arr4];
                [Arr6 addObject:arr5];
                [Arr6 addObject:arr6];
            }
            NSMutableDictionary *dic6=[NSMutableDictionary dictionaryWithObject:Arr6 forKey:@"tujing"];
            [dic6 setValue:@"泰安—莱阳" forKey:@"qishizhan"];
            
            //   泰安—邹平
            NSMutableArray *Arr7=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"周村", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"邹平", @"", @"", nil];
                [Arr7 addObject:arr1];
                [Arr7 addObject:arr2];
            }
            NSMutableDictionary *dic7=[NSMutableDictionary dictionaryWithObject:Arr7 forKey:@"tujing"];
            [dic7 setValue:@"泰安—邹平" forKey:@"qishizhan"];
            
            //   泰安—邹平
            NSMutableArray *Arr8=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"沂源", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"临朐", @"", @"", nil];
                
                [Arr8 addObject:arr1];
                [Arr8 addObject:arr2];
            }
            NSMutableDictionary *dic8=[NSMutableDictionary dictionaryWithObject:Arr8 forKey:@"tujing"];
            [dic8 setValue:@"泰安—邹平" forKey:@"qishizhan"];
            
            //   济宁—淄川
            NSMutableArray *Arr9=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"泰安", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"曲阜", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"兖州", @"", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"济宁", @"", @"", nil];
                [Arr9 addObject:arr1];
                [Arr9 addObject:arr2];
                [Arr9 addObject:arr3];
                [Arr9 addObject:arr4];
            }
            NSMutableDictionary *dic9=[NSMutableDictionary dictionaryWithObject:Arr9 forKey:@"tujing"];
            [dic9 setValue:@"济宁—淄川" forKey:@"qishizhan"];
            
            //   济宁—淄川
            NSMutableArray *Arr10=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"巨野", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"菏泽", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"兰考", @"", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"开封", @"", @"", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"郑州", @"", @"", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"洛阳", @"", @"", nil];
                NSArray *arr7=[NSArray arrayWithObjects:@"三门峡", @"", @"", nil];
                NSArray *arr8=[NSArray arrayWithObjects:@"西安", @"", @"", nil];
                
                [Arr10 addObject:arr1];
                [Arr10 addObject:arr2];
                [Arr10 addObject:arr3];
                [Arr10 addObject:arr4];
                [Arr10 addObject:arr5];
                [Arr10 addObject:arr6];
                [Arr10 addObject:arr7];
                [Arr10 addObject:arr8];
            }
            NSMutableDictionary *dic10=[NSMutableDictionary dictionaryWithObject:Arr10 forKey:@"tujing"];
            [dic10 setValue:@"济宁—淄川" forKey:@"qishizhan"];
            
            //   淄博—淮北
            NSMutableArray *Arr11=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"徐州", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"萧县", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"淮北", @"", @"", nil];
                [Arr11 addObject:arr1];
                [Arr11 addObject:arr2];
                [Arr11 addObject:arr3];
            }
            NSMutableDictionary *dic11=[NSMutableDictionary dictionaryWithObject:Arr11 forKey:@"tujing"];
            [dic11 setValue:@"淄博—淮北" forKey:@"qishizhan"];
            
            //   淄博—菏泽
            NSMutableArray *Arr12=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"嘉祥", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"巨野", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"菏泽", @"", @"", nil];
                [Arr12 addObject:arr1];
                [Arr12 addObject:arr2];
                [Arr12 addObject:arr3];
            }
            NSMutableDictionary *dic12=[NSMutableDictionary dictionaryWithObject:Arr12 forKey:@"tujing"];
            [dic12 setValue:@"淄博—菏泽" forKey:@"qishizhan"];
            
            //   淄博—南京
            NSMutableArray *Arr13=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"淮阴", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"宝应", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"江都", @"", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"扬州", @"", @"", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"南京", @"", @"", nil];
                
                [Arr13 addObject:arr1];
                [Arr13 addObject:arr2];
                [Arr13 addObject:arr3];
                [Arr13 addObject:arr4];
                [Arr13 addObject:arr5];
            }
            NSMutableDictionary *dic13=[NSMutableDictionary dictionaryWithObject:Arr13 forKey:@"tujing"];
            [dic13 setValue:@"淄博—南京" forKey:@"qishizhan"];
            
            //   淄博—汶上
            NSMutableArray *Arr14=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"汶上", @"", @"", nil];
                
                [Arr14 addObject:arr1];
            }
            NSMutableDictionary *dic14=[NSMutableDictionary dictionaryWithObject:Arr14 forKey:@"tujing"];
            [dic14 setValue:@"淄博—汶上" forKey:@"qishizhan"];
            
            //   泰安—寿光
            NSMutableArray *Arr15=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"寿光", @"", @"", nil];
                
                [Arr15 addObject:arr1];
                
            }
            NSMutableDictionary *dic15=[NSMutableDictionary dictionaryWithObject:Arr15 forKey:@"tujing"];
            [dic15 setValue:@"泰安—寿光" forKey:@"qishizhan"];
            
            //   莱钢—牟平
            NSMutableArray *Arr16=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"牟平", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"莱州", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"黄县", @"", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"蓬莱", @"", @"", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"三十里堡", @"", @"", nil];
                NSArray *arr6=[NSArray arrayWithObjects:@"烟台", @"", @"", nil];
                
                [Arr16 addObject:arr1];
                [Arr16 addObject:arr2];
                [Arr16 addObject:arr3];
                [Arr16 addObject:arr4];
                [Arr16 addObject:arr5];
                [Arr16 addObject:arr6];
            }
            NSMutableDictionary *dic16=[NSMutableDictionary dictionaryWithObject:Arr16 forKey:@"tujing"];
            [dic16 setValue:@"莱钢—牟平" forKey:@"qishizhan"];
            
            //   淄博—临泉
            NSMutableArray *Arr17=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"商丘", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"亳州", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"三角元", @"", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"界首", @"", @"", nil];
                NSArray *arr5=[NSArray arrayWithObjects:@"临泉", @"", @"", nil];
                
                [Arr17 addObject:arr1];
                [Arr17 addObject:arr2];
                [Arr17 addObject:arr3];
                [Arr17 addObject:arr4];
                [Arr17 addObject:arr5];
            }
            NSMutableDictionary *dic17=[NSMutableDictionary dictionaryWithObject:Arr17 forKey:@"tujing"];
            [dic17 setValue:@"淄博—临泉" forKey:@"qishizhan"];
            
            //   济宁—滨州
            NSMutableArray *Arr18=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"博兴", @"", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"滨州", @"", @"", nil];
                [Arr18 addObject:arr1];
                [Arr18 addObject:arr2];
            }
            NSMutableDictionary *dic18=[NSMutableDictionary dictionaryWithObject:Arr18 forKey:@"tujing"];
            [dic18 setValue:@"济宁—滨州" forKey:@"qishizhan"];
            
            
            
            //   最后一步
            Array_guolu=[NSMutableArray array];
            [Array_guolu addObject:dic1];
            [Array_guolu addObject:dic2];
            [Array_guolu addObject:dic3];
            [Array_guolu addObject:dic4];
            [Array_guolu addObject:dic5];
            [Array_guolu addObject:dic6];
            [Array_guolu addObject:dic7];
            [Array_guolu addObject:dic8];
            [Array_guolu addObject:dic9];
            [Array_guolu addObject:dic10];
            [Array_guolu addObject:dic11];
            [Array_guolu addObject:dic12];
            [Array_guolu addObject:dic13];
            [Array_guolu addObject:dic14];
            [Array_guolu addObject:dic15];
            [Array_guolu addObject:dic16];
            [Array_guolu addObject:dic17];
            [Array_guolu addObject:dic18];
            
        }
        /*
         **********              市内
         */
        {
            //   大王庄—独 路
            NSMutableArray *Arr1=[NSMutableArray array];
            
            {
                NSArray *arr1=[NSArray arrayWithObjects:@"大王庄", @"【独路】9:40  13:10  18:00(冬17:40)【店子】7:30  12:00  16:00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"店 子", @"9:00  12:30  16:30", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"独 路", @"6:00  10:40  14:40", @"", nil];
                [Arr1 addObject:arr1];
                [Arr1 addObject:arr2];
                [Arr1 addObject:arr3];
            }
            NSMutableDictionary *dic1=[NSMutableDictionary dictionaryWithObject:Arr1 forKey:@"tujing"];
            [dic1 setValue:@"大王庄—独 路" forKey:@"qishizhan"];
            //   大王庄—潘家沟
            NSMutableArray *Arr2=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"大王庄", @"【潘家沟】5:50  11:10  16:40【店子】  8:00  9:10   10:00  14:10  15:20", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"店 子", @"8:30  9:30  10:30  14:40  16:00", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"潘家沟", @"6:40 13:10  17:20", @"", nil];
                [Arr2 addObject:arr1];
                [Arr2 addObject:arr2];
                [Arr2 addObject:arr3];
            }
            NSMutableDictionary *dic2=[NSMutableDictionary dictionaryWithObject:Arr2 forKey:@"tujing"];
            [dic2 setValue:@"大王庄—潘家沟" forKey:@"qishizhan"];
            
            //   大王庄—宅科
            NSMutableArray *Arr3=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"大王庄", @"【店子】5:40 7:00 10:30 13:30 14:50  17:10【宅科】8:30", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"店 子", @"6:10  7:50  10:00  11:00  14:10  15:30  17:30", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"宅科", @"9:30", @"", nil];
                [Arr3 addObject:arr1];
                [Arr3 addObject:arr2];
                [Arr3 addObject:arr3];
            }
            NSMutableDictionary *dic3=[NSMutableDictionary dictionaryWithObject:Arr3 forKey:@"tujing"];
            [dic3 setValue:@"大王庄—宅科" forKey:@"qishizhan"];
            
            //   大王庄—龙 尾
            NSMutableArray *Arr4=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"大王庄", @"6:10  8:00  10:00  14:00  16:30", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"龙尾", @"6:20  8:30  10:30  14:30  16:40", @"", nil];
                [Arr4 addObject:arr1];
                [Arr4 addObject:arr2];
            }
            NSMutableDictionary *dic4=[NSMutableDictionary dictionaryWithObject:Arr4 forKey:@"tujing"];
            [dic4 setValue:@"大王庄—龙 尾" forKey:@"qishizhan"];
            
            //   大王庄—华山林场
            NSMutableArray *Arr5=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"大王庄", @"7:40  16:00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"华山林场", @"7:50  16:10", @"", nil];
                [Arr5 addObject:arr1];
                [Arr5 addObject:arr2];
            }
            NSMutableDictionary *dic5=[NSMutableDictionary dictionaryWithObject:Arr5 forKey:@"tujing"];
            [dic5 setValue:@"大王庄—华山林场" forKey:@"qishizhan"];
            
            //   大王庄—陡崖
            NSMutableArray *Arr6=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"大王庄", @"5:40  9:00  11:00  15:30  17:10", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"陡崖", @"5:50  9:30  11:20  15:45  17:20", @"", nil];
                [Arr6 addObject:arr1];
                [Arr6 addObject:arr2];
            }
            NSMutableDictionary *dic6=[NSMutableDictionary dictionaryWithObject:Arr6 forKey:@"tujing"];
            [dic6 setValue:@"大王庄—陡崖" forKey:@"qishizhan"];
            
            //   寨里—金井—贾家庄
            NSMutableArray *Arr7=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"寨 里", @"5:30 6:30 7:30 8:30 9:00 9:35 10:00 10:30 11:40 14:00 14:30 15:30 16:00 16:30 17:00 18:00（冬17:30）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"贾家庄", @"6:00 7:00 8:00 9:00 9:30 10:00 10:30 11:30 13:30 14:30 15:00 16:00   16:30 17:30 （冬17:00）", @"", nil];
                [Arr7 addObject:arr1];
                [Arr7 addObject:arr2];
            }
            NSMutableDictionary *dic7=[NSMutableDictionary dictionaryWithObject:Arr7 forKey:@"tujing"];
            [dic7 setValue:@"寨里—金井—贾家庄" forKey:@"qishizhan"];
            
            //   寨里—水北—燕家汶
            NSMutableArray *Arr8=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"寨 里", @"【燕家汶】5:40 7:00 9:00 10;30 13:30 15:30 18:00（冬16:40）水北】5:40 6:30 —11:30 每30分钟一班；12:20 13:30 14:00 14:30 15:00 15:30 16:00 16:40 17:20 18:00 （冬17:30）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"水 北", @"6:00 — 12:00 每30分钟一班；   13:30 — 16:30 每30分钟一班；17:10 18:00 18:30（冬18:00）", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"燕家汶", @"6:00  7;20  9:20  10:50  13:50  15:50  18:20 （冬17:00）",@"", nil];
                [Arr8 addObject:arr1];
                [Arr8 addObject:arr2];
                [Arr8 addObject:arr3];
            }
            NSMutableDictionary *dic8=[NSMutableDictionary dictionaryWithObject:Arr8 forKey:@"tujing"];
            [dic8 setValue:@"寨里—水北—燕家汶" forKey:@"qishizhan"];
            
            //   寨里—止凤
            NSMutableArray *Arr9=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"寨 里", @"7:00  8:00  9:30  11:30  14:30  16:00  17:30", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"止凤", @"6:00  7:30  8:30  9:50   14:00  15:00  16:30", @"", nil];
                
                [Arr9 addObject:arr1];
                [Arr9 addObject:arr2];
            }
            NSMutableDictionary *dic9=[NSMutableDictionary dictionaryWithObject:Arr9 forKey:@"tujing"];
            [dic9 setValue:@"寨里—止凤" forKey:@"qishizhan"];
            
            //   寨里—下河
            NSMutableArray *Arr10=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"寨里 ",@"5:30  7:00  8:00  9:30  11:00  13:30  15:00  17:30 （冬17:00）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"前卞庄", @"6:00  7:30  8:30  10:00  11:30  14:30  15:30", @"", nil];
                
                [Arr10 addObject:arr1];
                [Arr10 addObject:arr2];
            }
            NSMutableDictionary *dic10=[NSMutableDictionary dictionaryWithObject:Arr10 forKey:@"tujing"];
            [dic10 setValue:@"寨里—下河" forKey:@"qishizhan"];
            
            //   寨里—房干
            NSMutableArray *Arr11=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"寨里 ",@"8:00  15:00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"房干", @"9:00  16:00", @"", nil];
                [Arr11 addObject:arr1];
                [Arr11 addObject:arr2];
            }
            NSMutableDictionary *dic11=[NSMutableDictionary dictionaryWithObject:Arr11 forKey:@"tujing"];
            [dic11 setValue:@"寨里—房干" forKey:@"qishizhan"];
            
            //   杨庄—尹家庄
            NSMutableArray *Arr12=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"杨 庄 ",@"6:00（冬6:30）8:00 10:00 11:30 14:00 15:00 16:30 17:30（冬16:00）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"尹家庄", @"5:30（冬6:00 7:00）6:30 8:30 10:30 13;30 14:30 15:3017:00（冬16:30）", @"", nil];
                [Arr12 addObject:arr1];
                [Arr12 addObject:arr2];
            }
            NSMutableDictionary *dic12=[NSMutableDictionary dictionaryWithObject:Arr12 forKey:@"tujing"];
            [dic12 setValue:@"杨庄—尹家庄" forKey:@"qishizhan"];
            
            //   圣井—蒲洼—白塔
            NSMutableArray *Arr13=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"圣 井 ",@"6:20（冬6:30）9:00 12:00 14:4018:00（冬16:30）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"蒲 洼", @"8:20  10:40  14:20  16:15", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"白 塔", @"（冬6:00）7:00 9:40 13:30 15:40 18:40（冬17;20）", @"", nil];
                
                [Arr13 addObject:arr1];
                [Arr13 addObject:arr2];
                [Arr13 addObject:arr3];
            }
            NSMutableDictionary *dic13=[NSMutableDictionary dictionaryWithObject:Arr13 forKey:@"tujing"];
            [dic13 setValue:@"圣井—蒲洼—白塔" forKey:@"qishizhan"];
            
            //   圣井—徐 冶
            NSMutableArray *Arr14=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"圣 井",@" 5:20  6:00  7;00  7:50  8:40  9:30  10:20  11:10  12;40 13:30 15:10 16:00 16:40 17:00 18:00（冬17:30）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"徐 冶", @"6:00  6:40  7:40  8:30  9:10  10:00 11;00  11:40 13:00 14:00 15:00 15:40 16:30 17:10 18:00（冬17:30）", @"", nil];
                
                [Arr14 addObject:arr1];
                [Arr14 addObject:arr2];
                
            }
            NSMutableDictionary *dic14=[NSMutableDictionary dictionaryWithObject:Arr14 forKey:@"tujing"];
            [dic14 setValue:@"圣井—徐 冶" forKey:@"qishizhan"];
            
            //   圣井—青沙沟
            NSMutableArray *Arr15=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"圣 井 ",@"【范庄】5:40 8:20 9:50 11:20 13:20 15:00 16:20 18:00（冬17:30【青沙沟】6;40 9:00 10:20 11:50 14:00 15:30 17:00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"范 庄", @"6:00 8:30 10:00 11;30 13:30 15:10 16:30 18:20（冬17:40）", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"青沙沟", @"7:00 9:20 10:40 12:10 14:30 15:50 17:20", @"", nil];
                
                [Arr15 addObject:arr1];
                [Arr15 addObject:arr2];
                [Arr15 addObject:arr3];
                
            }
            NSMutableDictionary *dic15=[NSMutableDictionary dictionaryWithObject:Arr15 forKey:@"tujing"];
            [dic15 setValue:@"圣井—青沙沟" forKey:@"qishizhan"];
            
            //   牛泉—小庄
            NSMutableArray *Arr16=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"牛泉 ",@"5:30 5:40 6:40 7:40 8:20 9:00 9:40 10:20  11:00 12:00 13:30 14:00  14:40 15:20 16:00 16:40 17:00 18:00 18:10（冬17:30）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"小庄", @"6:00 6:20 7:00 7:40 8:20 9:00 9:50 10:20 11:00 12:30 14:00 14:40  15:10 16:00 16:30 17:00 17:40 18:50 19;00（冬17:50）", @"", nil];
                [Arr16 addObject:arr1];
                [Arr16 addObject:arr2];
            }
            NSMutableDictionary *dic16=[NSMutableDictionary dictionaryWithObject:Arr16 forKey:@"tujing"];
            [dic16 setValue:@"牛泉—小庄" forKey:@"qishizhan"];
            
            //   牛泉—李条庄
            NSMutableArray *Arr17=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"牛泉 ",@"6:00  6:30  7:00  7:40  8:10  8:50  9:30  10:00  10:40  11:30 12:20  13:10  14:20 14:50 15:30 16:10 17:00  18:00（冬17:30）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"李条庄", @"6:30 7:00 7:30 8:10 8:40 9:20 10:00  10:40 11:10 11:50 12:50 13:50  14:40 15:10 15:40 16:10 16:30 17:30 18:30（冬17:50） ", @"", nil];
                
                [Arr17 addObject:arr1];
                [Arr17 addObject:arr2];
            }
            NSMutableDictionary *dic17=[NSMutableDictionary dictionaryWithObject:Arr17 forKey:@"tujing"];
            [dic17 setValue:@"牛泉—李条庄" forKey:@"qishizhan"];
            
            //   和庄—小英章 —马杓湾
            NSMutableArray *Arr18=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"和 庄 ",@"【大英章】8:00 10:30（冬14:00) 14:30 17:30（冬16:00)  【马杓湾】7:00 9:30 13:30 16:30 (冬15:00）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"小英章", @"6:30  9:00  13:00  16:00 （冬14:30）", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"马杓湾", @"7:30  10:00  14:00  17:00（冬15:30）", @"", nil];
                [Arr18 addObject:arr1];
                [Arr18 addObject:arr2];
                [Arr18 addObject:arr3];
                
            }
            NSMutableDictionary *dic18=[NSMutableDictionary dictionaryWithObject:Arr18 forKey:@"tujing"];
            [dic18 setValue:@"和庄—小英章 —马杓湾" forKey:@"qishizhan"];
            
            //   苗山—杓山
            NSMutableArray *Arr19=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"苗山",@"早7:00—晚17:30（冬17:00）每30分钟一班", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"杓山", @"早6:30—晚17:00 每30分钟一班", @"", nil];
                
                [Arr19 addObject:arr1];
                [Arr19 addObject:arr2];
            }
            NSMutableDictionary *dic19=[NSMutableDictionary dictionaryWithObject:Arr19 forKey:@"tujing"];
            [dic19 setValue:@"苗山—杓山" forKey:@"qishizhan"];
            
            //   苗山—老姑—和庄
            NSMutableArray *Arr20=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"苗山",@"6:00  8:00  13:30  17:00（冬16:40）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"老姑峪", @"6:30  8:00  11:00  14:00  16:00（冬15:00）", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"和庄", @"10:30  15:30 （冬14:30）", @"", nil];
                [Arr20 addObject:arr1];
                [Arr20 addObject:arr2];
                [Arr20 addObject:arr3];
            }
            NSMutableDictionary *dic20=[NSMutableDictionary dictionaryWithObject:Arr20 forKey:@"tujing"];
            [dic20 setValue:@"苗山—老姑—和庄" forKey:@"qishizhan"];
            
            //   茶业—卧铺
            NSMutableArray *Arr21=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"茶业",@"5:30  8:00  10:00  15:00  17:00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"卧铺", @"5:45  8:20  10:20  15:20  17:20", @"", nil];
                [Arr21 addObject:arr1];
                [Arr21 addObject:arr2];
            }
            NSMutableDictionary *dic21=[NSMutableDictionary dictionaryWithObject:Arr21 forKey:@"tujing"];
            [dic21 setValue:@"茶业—卧铺" forKey:@"qishizhan"];
            
            //   茶业—石城—上宅科—崖下
            NSMutableArray *Arr22=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"茶业",@"【石城】6:00  16:00   【宅科】6:00  9:00  11:00  16:00 崖下】6:00  16:00 ", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"石城", @"6:10  16:10", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"上宅科", @"6:25  9:20  11:20  16:40", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"崖下", @"6:40  16:25", @"", nil];
                [Arr22 addObject:arr1];
                [Arr22 addObject:arr2];
                [Arr22 addObject:arr3];
                [Arr22 addObject:arr4];
            }
            NSMutableDictionary *dic22=[NSMutableDictionary dictionaryWithObject:Arr22 forKey:@"tujing"];
            [dic22 setValue:@"茶业—石城—上宅科—崖下" forKey:@"qishizhan"];
            
            //  茶业—温峪
            NSMutableArray *Arr23=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"茶业 ",@"6:50  10:00  17:00（冬16:30）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"温峪 ",@"7:10  10:20  17:20（冬16:50）", @"", nil];
                [Arr23 addObject:arr1];
                [Arr23 addObject:arr2];
            }
            NSMutableDictionary *dic23=[NSMutableDictionary dictionaryWithObject:Arr23 forKey:@"tujing"];
            [dic23 setValue:@"茶业—温峪" forKey:@"qishizhan"];
            
            //   茶业—李白杨
            NSMutableArray *Arr24=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"茶业",@"5:30  7:00  9:10  14:00  16:00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"李白杨" ,@"5:40  7:20  9:30  14:20  16:20", @"", nil];
                [Arr24 addObject:arr1];
                [Arr24 addObject:arr2];
            }
            NSMutableDictionary *dic24=[NSMutableDictionary dictionaryWithObject:Arr24 forKey:@"tujing"];
            [dic24 setValue:@"茶业—李白杨" forKey:@"qishizhan"];
            
            //   茶业—龙子
            NSMutableArray *Arr25=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"茶业",@"6:00  8:00  11:00  15:00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"龙子",@"6:30  8:30  11:30  15:30", @"", nil];
                [Arr25 addObject:arr1];
                [Arr25 addObject:arr2];
            }
            NSMutableDictionary *dic25=[NSMutableDictionary dictionaryWithObject:Arr25 forKey:@"tujing"];
            [dic25 setValue:@"茶业—龙子" forKey:@"qishizhan"];
            
            //   姜家峪—西嵬石—船厂
            NSMutableArray *Arr26=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"西嵬石",@"【姜家峪】8:30  11:50  15:00  17:30（冬17:00）船厂】6:40（冬7:00） 10:20（进腰关）16:20（冬15:50）（进腰关）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"姜家峪",@"6:10 （冬6:30） 9:00  14:10  16:00 （冬15:30）",@"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"船厂",@"7:10（冬7:30）（进腰关）11:00（进腰关）17:00（冬16:30）（进腰关）", @"", nil];
                [Arr26 addObject:arr1];
                [Arr26 addObject:arr2];
                [Arr26 addObject:arr3];
            }
            NSMutableDictionary *dic26=[NSMutableDictionary dictionaryWithObject:Arr26 forKey:@"tujing"];
            [dic26 setValue:@"姜家峪—西嵬石—船厂" forKey:@"qishizhan"];
            
            //   上游—栾宫—鲁地
            NSMutableArray *Arr27=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"上游",@"【北栾宫】6:00 7:20 9:30 11:30 14:00 15:30 17:30  （冬17:10）【鲁 地】 6:50  11:00 16:30", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"北栾宫",@"6:10 （冬6:30） 9:00  14:10  16:00 （冬15:30）",@"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"鲁地",@"7:00  11:10  16:40", @"", nil];
                [Arr27 addObject:arr1];
                [Arr27 addObject:arr2];
                [Arr27 addObject:arr3];
            }
            NSMutableDictionary *dic27=[NSMutableDictionary dictionaryWithObject:Arr27 forKey:@"tujing"];
            [dic27 setValue:@"上游—栾宫—鲁地" forKey:@"qishizhan"];
            
            //   上游—胡多萝
            NSMutableArray *Arr28=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"上游",@"6:00  8:20  9:20  11:00  13:30  14:30  16:30  17:30 （冬17:10）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"胡多萝",@"6:30  8:50  9:50  11:30  14:00  15:00  17:00  18:00 （冬17:40）",@"", nil];
                [Arr28 addObject:arr1];
                [Arr28 addObject:arr2];
            }
            NSMutableDictionary *dic28=[NSMutableDictionary dictionaryWithObject:Arr28 forKey:@"tujing"];
            [dic28 setValue:@"上游—胡多萝" forKey:@"qishizhan"];
            
            //   上游—酉坡
            NSMutableArray *Arr29=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"上游",@"6:00  8:30  10:40  13:50  16:00  17:30（冬17:10）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"酉 坡",@"7:30 10:00  15:30",@"", nil];
                [Arr29 addObject:arr1];
                [Arr29 addObject:arr2];
            }
            NSMutableDictionary *dic29=[NSMutableDictionary dictionaryWithObject:Arr29 forKey:@"tujing"];
            [dic29 setValue:@"上游—酉坡" forKey:@"qishizhan"];
            
            //   上游—酉坡
            NSMutableArray *Arr30=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"上游",@"6:00  8:30  10:40  13:50  16:00  17:30（冬17:10）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"房干",@"6:30 9:00 11:10 14:20 16:20 17:50（冬17:30）【进胡家庄14:30、16:30】",@"", nil];
                
                [Arr30 addObject:arr1];
                [Arr30 addObject:arr2];
            }
            NSMutableDictionary *dic30=[NSMutableDictionary dictionaryWithObject:Arr30 forKey:@"tujing"];
            [dic30 setValue:@"上游—酉坡" forKey:@"qishizhan"];
            
            //   上游—小楼
            NSMutableArray *Arr31=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"上游",@"6:00  9:30   14:00  17:30   （冬17:10）",@"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"小楼",@"6:20  10:00  15:00  17:50   （冬17:30）",@"", nil];
                
                [Arr31 addObject:arr1];
                [Arr31 addObject:arr2];
            }
            NSMutableDictionary *dic31=[NSMutableDictionary dictionaryWithObject:Arr31 forKey:@"tujing"];
            [dic31 setValue:@"上游—小楼" forKey:@"qishizhan"];
            
            //   上游—雪野
            NSMutableArray *Arr32=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"上游",@"6:30  8:00  10:50  15:30  16:30", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"雪野",@"7:00  9:00  12:00  16:00  17:00",@"", nil];
                
                [Arr32 addObject:arr1];
                [Arr32 addObject:arr2];
            }
            NSMutableDictionary *dic32=[NSMutableDictionary dictionaryWithObject:Arr32 forKey:@"tujing"];
            [dic32 setValue:@"上游—雪野" forKey:@"qishizhan"];
            
            
            //   里辛—东马泉
            NSMutableArray *Arr33=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"里辛",@"7:40  10:00  12:00  15:30  18:00（冬15:00 17:00）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"东马泉",@"6:40  8:40   10:40  14:30  17:00（冬14:10 16:00）",@"", nil];
                
                [Arr33 addObject:arr1];
                [Arr33 addObject:arr2];
            }
            NSMutableDictionary *dic33=[NSMutableDictionary dictionaryWithObject:Arr33 forKey:@"tujing"];
            [dic33 setValue:@"里辛—东马泉" forKey:@"qishizhan"];
            
            //   里辛—黄金篮
            NSMutableArray *Arr34=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"里辛",@"8:10  10:20  14:00  16:00  17:50（冬16:50）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"黄金篮",@"6:40  8:50   11:00  15:00  16:50（冬15:30）",@"", nil];
                
                [Arr34 addObject:arr1];
                [Arr34 addObject:arr2];
            }
            NSMutableDictionary *dic34=[NSMutableDictionary dictionaryWithObject:Arr34 forKey:@"tujing"];
            [dic34 setValue:@"里辛—黄金篮" forKey:@"qishizhan"];
            
            //   城子坡—罗汉峪—双阳桥
            NSMutableArray *Arr35=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"破子城",@"6:00  8:00   9:50  14:00  17:50（冬16:30）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"罗汉峪",@"6:50  9:00   10:40  14:50  18:10（冬17:20）",@"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"双阳桥",@"6:40  8:50   10:30  14:40  18:00（冬17:10）",@"", nil];
                
                [Arr35 addObject:arr1];
                [Arr35 addObject:arr2];
                [Arr35 addObject:arr3];
            }
            NSMutableDictionary *dic35=[NSMutableDictionary dictionaryWithObject:Arr35 forKey:@"tujing"];
            [dic35 setValue:@"城子坡—罗汉峪—双阳桥" forKey:@"qishizhan"];
            
            //   城子坡—清泉岭
            NSMutableArray *Arr36=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"破子城",@"6:00  7:40   15:00  17:40 （冬14:20 16:20）", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"清泉岭",@"6:30  8:30   15:50  18:30 （冬8:20 14:50 17:10）",@"", nil];
                
                [Arr36 addObject:arr1];
                [Arr36 addObject:arr2];
            }
            NSMutableDictionary *dic36=[NSMutableDictionary dictionaryWithObject:Arr36 forKey:@"tujing"];
            [dic36 setValue:@"城子坡—清泉岭" forKey:@"qishizhan"];
            
            
            
            //   最后一步
            Array_shinei=[NSMutableArray array];
            [Array_shinei addObject:dic1];
            [Array_shinei addObject:dic2];
            [Array_shinei addObject:dic3];
            [Array_shinei addObject:dic4];
            [Array_shinei addObject:dic5];
            [Array_shinei addObject:dic6];
            [Array_shinei addObject:dic7];
            [Array_shinei addObject:dic8];
            [Array_shinei addObject:dic9];
            [Array_shinei addObject:dic10];
            [Array_shinei addObject:dic11];
            [Array_shinei addObject:dic12];
            [Array_shinei addObject:dic13];
            [Array_shinei addObject:dic14];
            [Array_shinei addObject:dic15];
            [Array_shinei addObject:dic16];
            [Array_shinei addObject:dic17];
            [Array_shinei addObject:dic18];
            [Array_shinei addObject:dic19];
            [Array_shinei addObject:dic20];
            [Array_shinei addObject:dic21];
            [Array_shinei addObject:dic22];
            [Array_shinei addObject:dic23];
            [Array_shinei addObject:dic24];
            [Array_shinei addObject:dic25];
            [Array_shinei addObject:dic26];
            [Array_shinei addObject:dic27];
            [Array_shinei addObject:dic28];
            [Array_shinei addObject:dic29];
            [Array_shinei addObject:dic30];
            [Array_shinei addObject:dic31];
            [Array_shinei addObject:dic32];
            [Array_shinei addObject:dic33];
            [Array_shinei addObject:dic34];
            [Array_shinei addObject:dic35];
            [Array_shinei addObject:dic36];
            
        }
        /*
         **********              城乡
         */
        {
            //   K201
            NSMutableArray *Arr1=[NSMutableArray array];
            
            {
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"首班车6:00 　末班车18:50（冬18:00）", @"每8分钟一班", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"颜庄", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"钢城", @"", @"", nil];
                [Arr1 addObject:arr1];
                [Arr1 addObject:arr2];
                [Arr1 addObject:arr3];
            }
            NSMutableDictionary *dic1=[NSMutableDictionary dictionaryWithObject:Arr1 forKey:@"tujing"];
            [dic1 setValue:@"K201" forKey:@"qishizhan"];
            //   K202
            NSMutableArray *Arr2=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"首班车6:00（冬6:30）　末班车18:00（冬17:30）", @"每15分钟一班", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"苗山", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"和庄", @"", @"", nil];
                [Arr2 addObject:arr1];
                [Arr2 addObject:arr2];
                [Arr2 addObject:arr3];
            }
            NSMutableDictionary *dic2=[NSMutableDictionary dictionaryWithObject:Arr2 forKey:@"tujing"];
            [dic2 setValue:@"K202" forKey:@"qishizhan"];
            
            //   K203
            NSMutableArray *Arr3=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"首班车6:00（冬6:30）　末班车18:00（冬17:30）", @"每20分钟一班", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"雪野", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"茶业", @"", @"", nil];
                [Arr3 addObject:arr1];
                [Arr3 addObject:arr2];
                [Arr3 addObject:arr3];
            }
            NSMutableDictionary *dic3=[NSMutableDictionary dictionaryWithObject:Arr3 forKey:@"tujing"];
            [dic3 setValue:@"K203" forKey:@"qishizhan"];
            
            //   K204
            NSMutableArray *Arr4=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"首班车6:00（冬6:30）　末班车18:00（冬17:30）", @"每20分钟一班", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"雪野", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"上游", @"", @"", nil];
                [Arr4 addObject:arr1];
                [Arr4 addObject:arr2];
                [Arr4 addObject:arr3];
            }
            NSMutableDictionary *dic4=[NSMutableDictionary dictionaryWithObject:Arr4 forKey:@"tujing"];
            [dic4 setValue:@"K204" forKey:@"qishizhan"];
            
            //   K205
            NSMutableArray *Arr5=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"首班车6:00　 末班车18:00（冬17:40）", @"每20分钟一班", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"杨庄", @"", @"", nil];
                [Arr5 addObject:arr1];
                [Arr5 addObject:arr2];
            }
            NSMutableDictionary *dic5=[NSMutableDictionary dictionaryWithObject:Arr5 forKey:@"tujing"];
            [dic5 setValue:@"K205" forKey:@"qishizhan"];
            
            //   K206
            NSMutableArray *Arr6=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"首班车6:00　 末班车18:00（冬17:40）", @"每15分钟一班", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"寨里", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"大王庄", @"", @"", nil];
                [Arr6 addObject:arr1];
                [Arr6 addObject:arr2];
                [Arr6 addObject:arr3];
            }
            NSMutableDictionary *dic6=[NSMutableDictionary dictionaryWithObject:Arr6 forKey:@"tujing"];
            [dic6 setValue:@"K206" forKey:@"qishizhan"];
            
            //   K207
            NSMutableArray *Arr7=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"首班车6:00　 末班车18:00（冬17:40）", @"每20分钟一班", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"牛泉", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"圣井", @"", @"", nil];
                [Arr7 addObject:arr1];
                [Arr7 addObject:arr2];
                [Arr7 addObject:arr3];
            }
            NSMutableDictionary *dic7=[NSMutableDictionary dictionaryWithObject:Arr7 forKey:@"tujing"];
            [dic7 setValue:@"K207" forKey:@"qishizhan"];
            
            //   K208
            NSMutableArray *Arr8=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"首班车6:00　 末班车18:00（冬17:40）", @"每10分钟一班", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"羊里", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"寨里", @"", @"", nil];
                
                [Arr8 addObject:arr1];
                [Arr8 addObject:arr2];
                [Arr8 addObject:arr3];
            }
            NSMutableDictionary *dic8=[NSMutableDictionary dictionaryWithObject:Arr8 forKey:@"tujing"];
            [dic8 setValue:@"K208" forKey:@"qishizhan"];
            
            //   K210
            NSMutableArray *Arr9=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"首班车6:15 末班车（往）16:45（返）17:25", @"每45分钟一班", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"苗山", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"常庄", @"", @"", nil];
                [Arr9 addObject:arr1];
                [Arr9 addObject:arr2];
                [Arr9 addObject:arr3];
            }
            NSMutableDictionary *dic9=[NSMutableDictionary dictionaryWithObject:Arr9 forKey:@"tujing"];
            [dic9 setValue:@"K210" forKey:@"qishizhan"];
            
            //   K302
            NSMutableArray *Arr10=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"里辛", @"首班车6:20　 末班车18:20（冬17:15）", @"每20分钟一班", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"钢城车站", @"", @"", nil];
                
                [Arr10 addObject:arr1];
                [Arr10 addObject:arr2];
            }
            NSMutableDictionary *dic10=[NSMutableDictionary dictionaryWithObject:Arr10 forKey:@"tujing"];
            [dic10 setValue:@"K302" forKey:@"qishizhan"];
            
            //   莱城-陈楼
            NSMutableArray *Arr11=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"6:30  7:20  8:00  8:50  9:30  10:30  11:30 ", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"陈楼", @"", @"", nil];
                
                [Arr11 addObject:arr1];
                [Arr11 addObject:arr2];
            }
            NSMutableDictionary *dic11=[NSMutableDictionary dictionaryWithObject:Arr11 forKey:@"tujing"];
            [dic11 setValue:@"莱城-陈楼" forKey:@"qishizhan"];
            
            //   莱城-郭庄
            NSMutableArray *Arr12=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"6:00 6:40 7:30  9:00  9:50 12:30 13:30 15:00 16:00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"郭庄", @"", @"", nil];
                [Arr12 addObject:arr1];
                [Arr12 addObject:arr2];
            }
            NSMutableDictionary *dic12=[NSMutableDictionary dictionaryWithObject:Arr12 forKey:@"tujing"];
            [dic12 setValue:@"莱城-郭庄" forKey:@"qishizhan"];
            
            //   莱城-孙家
            NSMutableArray *Arr13=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"6:00  8:30  14:00  16:30", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"孙家", @"", @"", nil];
                
                
                [Arr13 addObject:arr1];
                [Arr13 addObject:arr2];
            }
            NSMutableDictionary *dic13=[NSMutableDictionary dictionaryWithObject:Arr13 forKey:@"tujing"];
            [dic13 setValue:@"莱城-孙家" forKey:@"qishizhan"];
            
            //   莱城-西当峪
            NSMutableArray *Arr14=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"5:50  7:30  10:00  14:30  17:00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"西当峪", @"", @"", nil];
                
                [Arr14 addObject:arr1];
                [Arr14 addObject:arr2];
            }
            NSMutableDictionary *dic14=[NSMutableDictionary dictionaryWithObject:Arr14 forKey:@"tujing"];
            [dic14 setValue:@"莱城-西当峪" forKey:@"qishizhan"];
            
            //   莱城-东孟家峪
            NSMutableArray *Arr15=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"6:30  9:00  14:00  16:00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"东孟家峪", @"", @"", nil];
                [Arr15 addObject:arr1];
                [Arr15 addObject:arr2];
            }
            NSMutableDictionary *dic15=[NSMutableDictionary dictionaryWithObject:Arr15 forKey:@"tujing"];
            [dic15 setValue:@"莱城-东孟家峪" forKey:@"qishizhan"];
            
            //   莱城-八里沟
            NSMutableArray *Arr16=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"7；30 8:30 9:30 10：30  11：30  13：30  15：30  16：00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"八里沟", @"", @"", nil];
                [Arr16 addObject:arr1];
                [Arr16 addObject:arr2];
                
            }
            NSMutableDictionary *dic16=[NSMutableDictionary dictionaryWithObject:Arr16 forKey:@"tujing"];
            [dic16 setValue:@"莱城-八里沟" forKey:@"qishizhan"];
            
            //   莱城-九羊度假村-址坊
            NSMutableArray *Arr17=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"7；00  8:20  9:40  11:00 13；30  14:40   16:00  17:00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"九羊度假村", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"址坊", @"", @"", nil];
                [Arr17 addObject:arr1];
                [Arr17 addObject:arr2];
                [Arr17 addObject:arr3];
                
                
            }
            NSMutableDictionary *dic17=[NSMutableDictionary dictionaryWithObject:Arr17 forKey:@"tujing"];
            [dic17 setValue:@"莱城-九羊度假村-址坊" forKey:@"qishizhan"];
            
            //   莱城-王石
            NSMutableArray *Arr18=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"6:30  7:40  9:00   10:30  14:30  16:30", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"王石", @"", @"", nil];
                
                [Arr18 addObject:arr1];
                [Arr18 addObject:arr2];
            }
            NSMutableDictionary *dic18=[NSMutableDictionary dictionaryWithObject:Arr18 forKey:@"tujing"];
            [dic18 setValue:@"莱城-王石" forKey:@"qishizhan"];
            
            //   莱城-土屋
            NSMutableArray *Arr19=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"8:30  11:00 14:30  17:20", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"土屋", @"", @"", nil];
                
                [Arr19 addObject:arr1];
                [Arr19 addObject:arr2];
            }
            NSMutableDictionary *dic19=[NSMutableDictionary dictionaryWithObject:Arr19 forKey:@"tujing"];
            [dic19 setValue:@"莱城-土屋" forKey:@"qishizhan"];
            
            //   莱城-址坊
            NSMutableArray *Arr20=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"7:00  8:20  9:40   11:00  13:30  14:40  16:00  17:00", @"", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"址坊", @"", @"", nil];
                [Arr20 addObject:arr1];
                [Arr20 addObject:arr2];
            }
            NSMutableDictionary *dic20=[NSMutableDictionary dictionaryWithObject:Arr20 forKey:@"tujing"];
            [dic20 setValue:@"莱城-址坊" forKey:@"qishizhan"];
            
            //   莱城-铁车
            NSMutableArray *Arr21=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"首班车5:50（冬5:50） 末班车17:30（冬17:00）", @"每30分钟一班", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"郎郡", @"", @"", nil];
                NSArray *arr3=[NSArray arrayWithObjects:@"砟峪", @"", @"", nil];
                NSArray *arr4=[NSArray arrayWithObjects:@"铁车", @"", @"", nil];
                
                [Arr21 addObject:arr1];
                [Arr21 addObject:arr2];
                [Arr21 addObject:arr3];
                [Arr21 addObject:arr4];
                
            }
            NSMutableDictionary *dic21=[NSMutableDictionary dictionaryWithObject:Arr21 forKey:@"tujing"];
            [dic21 setValue:@"莱城-铁车" forKey:@"qishizhan"];
            
            //   莱城-黄庄
            NSMutableArray *Arr22=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"莱城", @"首班车6:40 末班车18:20（冬17:20）", @"每20分钟一班", nil];
                NSArray *arr2=[NSArray arrayWithObjects:@"黄庄", @"", @"", nil];
                [Arr22 addObject:arr1];
                [Arr22 addObject:arr2];
            }
            NSMutableDictionary *dic22=[NSMutableDictionary dictionaryWithObject:Arr22 forKey:@"tujing"];
            [dic22 setValue:@"莱城-黄庄" forKey:@"qishizhan"];
            
            //   金 鼎 环 行
            NSMutableArray *Arr23=[NSMutableArray array];
            {
                
                NSArray *arr1=[NSArray arrayWithObjects:@"金 鼎 环 行", @"首班车6:45 末班车18:20（冬17:30）每15分钟一班", @"每15分钟一班", nil];
                
                [Arr23 addObject:arr1];
                
            }
            NSMutableDictionary *dic23=[NSMutableDictionary dictionaryWithObject:Arr23 forKey:@"tujing"];
            [dic23 setValue:@"金 鼎 环 行" forKey:@"qishizhan"];
            
            
            //   最后一步
            Array_chengxiang=[NSMutableArray array];
            [Array_chengxiang addObject:dic1];
            [Array_chengxiang addObject:dic2];
            [Array_chengxiang addObject:dic3];
            [Array_chengxiang addObject:dic4];
            [Array_chengxiang addObject:dic5];
            [Array_chengxiang addObject:dic6];
            [Array_chengxiang addObject:dic7];
            [Array_chengxiang addObject:dic8];
            [Array_chengxiang addObject:dic9];
            [Array_chengxiang addObject:dic10];
            [Array_chengxiang addObject:dic11];
            [Array_chengxiang addObject:dic12];
            [Array_chengxiang addObject:dic13];
            [Array_chengxiang addObject:dic14];
            [Array_chengxiang addObject:dic15];
            [Array_chengxiang addObject:dic16];
            [Array_chengxiang addObject:dic17];
            [Array_chengxiang addObject:dic18];
            [Array_chengxiang addObject:dic19];
            [Array_chengxiang addObject:dic20];
            [Array_chengxiang addObject:dic21];
            [Array_chengxiang addObject:dic22];
            [Array_chengxiang addObject:dic23];
            
        }
        changtu=[[ChangTuKeYunXiangQing_ChangTuViewController alloc]init];
        guolu=[[ChangTuKeYunXiangQing_GuoLuViewController alloc]init];
        shinei=[[ChangTuKeYunXiangQing_ShiNeiViewController alloc]init];
        chengxiang=[[ChangTuKeYunXiangQing_ChengXiangViewController alloc]init];
        
        Array=Array_changtu;

    mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 92, width, height-92)];
    mytableview.delegate=self;
    mytableview.dataSource=self;
    [self.view addSubview:mytableview];
        i=1;
    
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
-(void)changtu
{
    Array=Array_changtu;
    i=1;
    [btn_changtu setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn_guolu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_shinei setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_chengxiang setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mytableview reloadData];
    biaoxian.frame=CGRectMake(0, 90, 80, 1);
    

}
-(void)guolu
{
    Array=Array_guolu;
    i=2;
    [btn_changtu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_guolu setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn_shinei setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_chengxiang setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [mytableview reloadData];
   biaoxian.frame=CGRectMake(80, 90, 80, 1);}
-(void)shinei
{
    Array=Array_shinei;
    i=4;
    [btn_changtu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_guolu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_shinei setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn_chengxiang setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [mytableview reloadData];
    biaoxian.frame=CGRectMake(160, 90, 80, 1);
}
-(void)chengxiang
{
    Array=Array_chengxiang;
    i=3;
    [btn_changtu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_guolu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_shinei setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_chengxiang setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    [mytableview reloadData];
    biaoxian.frame=CGRectMake(240, 90, 80, 1);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 39, 320, 1)];
    label.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [cell addSubview:label];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text=[Array[indexPath.row] objectForKey:@"qishizhan"];
    cell.textLabel.font=[UIFont systemFontOfSize:16];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (i==1)
    {
        arr_ChangTuKeYun=[Array_changtu[indexPath.row] objectForKey:@"tujing"];
        NSLog(@"%@",arr_ChangTuKeYun);
        [self presentViewController:changtu animated:NO completion:nil];
    }
    else if (i==2)
    {
        arr_ChangTuKeYun=[Array_guolu[indexPath.row] objectForKey:@"tujing"];
        [self presentViewController:guolu animated:NO completion:nil];


    }
    else if (i==3)
    {
        arr_ChangTuKeYun=[Array_chengxiang[indexPath.row] objectForKey:@"tujing"];
        [self presentViewController:chengxiang animated:NO completion:nil];


    }
    else
    {
        arr_ChangTuKeYun=[Array_shinei[indexPath.row] objectForKey:@"tujing"];
        [self presentViewController:shinei animated:NO completion:nil];


    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fanhui
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
