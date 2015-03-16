//
//  GongJiaoXianLuViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-9-23.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "GongJiaoXianLuViewController.h"
#import "LuXianXinXiViewController.h"
extern NSString *LuXianXinXi;
@interface GongJiaoXianLuViewController ()

@end

@implementation GongJiaoXianLuViewController

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
    arr1=[[NSArray alloc]initWithObjects:@"K1路  泰钢宿舍—状元小区",@"2路  北埠煤矿—万泰电气公司",@"3路  姚家岭—传染病医院",@"4路  马庄铁矿—秦家洼",@"K5路  冷轧薄板厂—泰山阳光电器",@"6路  泰钢冷轧薄板厂—汶水源社区",@"7路  西海公园—福莱佳园",@"K8路  望海华城—滨河花苑北门", @"K9路  方下镇政府—莱芜战役纪念馆",@"K10路  福莱佳园—新矿莱芜中心医院",@"101路  市医院北门—职业技术学院",@"K12路  福莱佳园北门—墨埠",@"K16路  方下镇政府—火车站",nil];
    arr2=[[NSArray alloc]initWithObjects:@"泰钢宿舍-马庄-公交加油站-金童幼儿园-格林豪泰酒店-莱城区政府-凤城街百货中心-凤城街长勺路口-老市医院-老干部活动中心-市政府-莱芜宾馆-园丁小区-市行政服务大厅-莲河小区-市交通运输局-戴花园-火车站路口-东昇奇瑞4S店-香山工业园-中和-龙园宾馆-滨河花苑-滨河小学-彩虹桥东-李陈庄-老鸦峪-状元小区",@"北埠煤矿-北埠居委会-万和小区-交警一大队-胜利路鹏泉路口-东风家电街-凤城街百货中心-凤城街长勺路口-市邮政局-吴花园-城东派出所-新汶矿业职工大学-啤酒厂-营中赢小区-故事家园小区-华清园-力创科技-方大公司-金石集团-裕丰小学-南孝义-张庄-万泰电气公司",@"姚家岭-姚家岭东-莱矿医院-泰钢机械厂-曹东-煤机厂-矿煤阳光花园-西秀游园-格林豪泰酒店-莱城区政府-凤城街百货中心-凤城街长勺路口-市邮政局-大峰馥香谷-昊宝西服销售中心-雪龙羽绒广场-孟花园-交警支队-红星建材城-花园学校-区交通局-徐家河-信誉楼商厦-凤城高中-市医院北门-福莱佳园北门-香舍花都-中储粮莱芜库-传染病医院",@"马庄铁矿-马庄矿井-马庄-莱芜铁矿-公交加油站-城西粮店-西关居委会-市物价局-胜利路鹏泉路口-东风家电街-凤城街百货中心-凤城街长勺路口-凤城街道办-华冠集团-东升居民区-石家庄-孙故事-长途汽车站-程故事-红星家具城-大故事-南姜庄-泰通路口-地理沟-玉成数控-普阳集团-秦家洼",@"冷轧薄板厂-泰钢总部-蔺家庄-莱矿医院-汶水学校-曹东-煤机厂-矿煤阳光花园-西秀游园-格林豪泰酒店-莱城区政府-凤城街百货中心-凤城街长勺路口-市邮政局-吴花园-城东派出所-新汶矿业职工大学-吴伯箫学校-长途汽车站-程故事-红星家具城-大故事-南姜庄-北姜庄小区-黄泥沟-泰山阳光电器",@"泰钢冷轧薄板厂-孟家峪-高家洼路口-南北白龙村-刘家庄路口-传染病医院-中储粮莱芜库-香舍花都-福莱佳园北门-市医院北门-凤城高中-信誉楼商厦-徐家河-永馨园小区-戴花园社区-吕花园美食街-吕花园小区-汶阳街路口-万福小区-鑫融小区-军干所-城东派出所-同泽教育学校-孙故事-长途汽车站-官厂社区-月泊湖庄园-汶水源社区",@"西海公园-望海华城-煤机厂-矿煤阳光花园-西秀游园-格林豪泰酒店-莱城区政府-凤城街百货中心-贵和购物中心-金光大厦-红石公园-市政府-莱芜宾馆-园丁小区-清馨园-建设大厦-市委党校-信誉楼商厦-凤城高中-市医院-长勺小区-福莱佳园",@"望海华城-西秀小区-小曹村居委会-矿煤阳光花园-西秀游园-格林豪泰酒店-莱城区政府-东风家电街-胜利路鹏泉路口-交警一大队-十七中-红石公园-兰馨园-齐鲁证券-莱芜战役纪念馆-大桥村小区-公交驾校北门-中舜鲁中国际北站-益寿堂药材公司-冯家林-消防支队-前宋-龙园宾馆-会展中心-新一中-孝义-滨河花苑北门",@"方下镇政府-方下卫生院-方下-方下东-张公清-公清社区-谷家台-化肥厂-北十里铺-鑫盛家园-叶家庄西-叶家庄东-孟家庄-汇融酒业-曹西-曹东-西海公园-汶河名邸-三三公寓-一实小-华联商城-凤城街百货中心-凤城街长勺路口-老市医院-军分区-昊宝西服销售中心-雪龙羽绒广场-孟花园-青草河公园-莱芜战役纪念馆",@"福莱佳园-长勺小区-市医院-柳家店-庞家岭-泰山大酒店-莲河小区-市交通运输局-红星建材城-交警支队-孟花园-齐鲁证券-莱芜战役纪念馆-贵都购物中心-中大纺织公司-吴伯箫学校-长途汽车站-官厂社区-月泊湖庄园-高速路口-公交驾校报名处-安仙莲花河小区-西沟里村-东沟里村-南冶煤矿-南冶-新矿莱芜中心医院",@"市医院北门-凤城高中-信誉楼商厦-市委党校-建设大厦-清馨园-园丁小区-莱芜宾馆-市政府-老干部活动中心-老市医院-凤城街道办-华冠集团-东升居民区-石家庄-孙故事-长途汽车站-程故事-红星家具城-大故事-高新区管委会-力创科技-消防支队-前宋-龙园宾馆-会展中心-世纪城-高级技校-职业技术学院",@"福莱佳园北门-市医院北门-凤城高中-信誉楼商厦-徐家河-区交通局-花园学校-红星建材城-交警支队-孟花园-雪龙羽绒广场-昊宝西服销售中心-东方明珠花园-邮电宿舍-中大纺织公司-吴伯箫学校—长途汽车站-程故事-红星家具城-大故事-高新区管委会-方兴苑-泰丰花苑小区-东海花园-菁华药业-小陈家峪-汶阳北-汶阳南-段盘龙路口-马盘龙-马盘龙南路口-陈盘龙-前盘龙-汇源工业园-墨埠",@"方下镇政府-土楼-明珠园-沈家岭-刘家庙-方赵庄-王方下-嘶马河西-亓氏酱香源-南十里铺-鑫盛家园-北十里铺—化肥厂-姚家岭-姚家岭东-莱矿医院-泰钢厂区-泰钢宿舍-马庄-公交加油站-金童幼儿园-格林豪泰酒店-莱城区政府-东风家电街-胜利路鹏泉路口-交警一大队-十七中-红石公园-市政府-莱芜宾馆-中医院-大润发超市-区法院-吕花园-供销小区-货场-明馨园-火车站", nil];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat height=size.height;
    CGFloat width=size.width;

    self.view.backgroundColor=[UIColor whiteColor];
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label.text=@"公交线路";
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [self.view addSubview:label];
    btn_fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [btn_fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [btn_fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn_fanhui];
    
    mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 70, width, height-70)];
    mytableview.delegate=self;
    mytableview.dataSource=self;
    [self.view addSubview:mytableview];
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
    return arr1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 1, 320, 1)];
    label.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [cell addSubview:label];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text=arr1[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LuXianXinXi=arr2[indexPath.row];
    LuXianXinXiViewController *xinxi=[[LuXianXinXiViewController alloc]init];
    [self presentViewController:xinxi animated:NO completion:nil];
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
