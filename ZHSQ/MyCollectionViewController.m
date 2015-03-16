//
//  MyCollectionViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-1-28.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "PersonCenterHttpService.h"
extern NSString *Session;
@interface MyCollectionViewController ()
{
    
    //主键ID
    NSMutableArray *idList;
    //请求
    PersonCenterHttpService *sqHttpSer;
    //当前列表数据
    NSMutableArray *newsArr;
    //NSMutableArray *_fakeData;
    int startIndex;
    
    BOOL isUp;
}

@end

@implementation MyCollectionViewController

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
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];
    
    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label_title.text=@"我的收藏";
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.textColor=[UIColor whiteColor];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    btn_luntan=[[UIButton alloc]initWithFrame:CGRectMake(0, 60, 160, 30)];
    [btn_luntan setTitle:@"论坛" forState:UIControlStateNormal];
    btn_luntan.titleLabel.font=[UIFont systemFontOfSize:14];
    btn_luntan.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [btn_luntan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn_luntan addTarget:self action:@selector(luntan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_luntan];
    btn_shangjia=[[UIButton alloc]initWithFrame:CGRectMake(160, 60, 160, 30)];
    [btn_shangjia setTitle:@"商家" forState:UIControlStateNormal];
    btn_shangjia.titleLabel.font=[UIFont systemFontOfSize:14];
    btn_shangjia.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [btn_shangjia setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_shangjia addTarget:self action:@selector(shangjia) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_shangjia];
    
    NSArray *wk_paceImageNumArray = [[NSArray alloc]initWithObjects:@"emoji_1.png",@"emoji_2.png",@"emoji_3.png",@"emoji_4.png",@"emoji_5.png",@"emoji_6.png",@"emoji_7.png",@"emoji_8.png",@"emoji_9.png",@"emoji_10.png",@"emoji_11.png",@"emoji_12.png",@"emoji_13.png",@"emoji_14.png",@"emoji_15.png",@"emoji_16.png",@"emoji_17.png",@"emoji_18.png",@"emoji_19.png",@"emoji_20.png",@"emoji_21.png",@"emoji_22.png",@"emoji_23.png",@"emoji_24.png",@"emoji_25.png",@"emoji_26.png",@"emoji_27.png",@"emoji_28.png",@"emoji_29.png",@"emoji_30.png",@"emoji_31.png",@"emoji_32.png",@"emoji_33.png",@"emoji_34.png",@"emoji_35.png",@"emoji_36.png",@"emoji_37.png",@"emoji_38.png",@"emoji_39.png",@"emoji_40.png",@"emoji_41.png",@"emoji_42.png",@"emoji_43.png",@"emoji_44.png",@"emoji_45.png",@"emoji_45.png",@"emoji_47.png",@"emoji_48.png",@"emoji_49.png",@"emoji_50.png",@"emoji_51.png",@"emoji_52.png",@"emoji_53.png",@"emoji_54.png",@"emoji_55.png",@"emoji_56.png",@"emoji_57.png",@"emoji_58.png",@"emoji_59.png",@"emoji_60.png",@"emoji_16.png",@"emoji_62.png",@"emoji_63.png",@"emoji_64.png",@"emoji_65.png",@"emoji_66.png",@"emoji_67.png",@"emoji_68.png",@"emoji_69.png",@"emoji_70.png",@"emoji_71.png",@"emoji_179.png",@"emoji_180.png",@"emoji_181.png",@"emoji_182.png",@"emoji_183.png",@"emoji_184.png",@"emoji_185.png",@"emoji_186.png",@"emoji_187.png",@"emoji_188.png",@"emoji_189.png",@"emoji_190.png",@"emoji_191.png",@"emoji_192.png",@"emoji_193.png",@"emoji_194.png",@"emoji_195.png",@"emoji_196.png",@"emoji_197.png",@"emoji_198.png",@"emoji_199.png",@"emoji_200.png",@"emoji_201.png",@"emoji_202.png",@"emoji_203.png",@"emoji_204.png",@"emoji_205.png",@"emoji_206.png",@"emoji_207.png",@"emoji_208.png",@"emoji_209.png",@"emoji_210.png",@"emoji_211.png",@"emoji_212.png",@"emoji_213.png",@"emoji_214.png",@"emoji_215.png",@"emoji_216.png",@"emoji_217.png",@"emoji_218.png",@"emoji_219.png",@"emoji_220.png",@"emoji_221.png",@"emoji_222.png",@"emoji_223.png",@"emoji_224.png", nil];
    NSArray *wk_paceImageNameArray = [[NSArray alloc]initWithObjects:@"[可爱]",@"[笑脸]",@"[囧]",@"[生气]",@"[鬼脸]",@"[花心]",@"[害怕]",@"[我汗]",@"[尴尬]",@"[哼哼]",@"[忧郁]",@"[呲牙]",@"[媚眼]",@"[累]",@"[苦逼]",@"[瞌睡]",@"[哎呀]",@"[刺瞎]",@"[哭]",@"[激动]",@"[难过]",@"[害羞]",@"[高兴]",@"[愤怒]",@"[亲]",@"[飞吻]",@"[得意]",@"[惊恐]",@"[口罩]",@"[惊讶]",@"[委屈]",@"[生病]",@"[红心]",@"[心碎]",@"[玫瑰]",@"[花]",@"[外星人]",@"[金牛座]",@"[双子座]",@"[巨蟹座]",@"[狮子座]",@"[处女座]",@"[天平座]",@"[天蝎座]",@"[射手座]",@"[摩羯座]",@"[水瓶座]",@"[白羊座]",@"[双鱼座]",@"[星座]",@"[男孩]",@"[女孩]",@"[嘴唇]",@"[爸爸]",@"[妈妈]",@"[衣服]",@"[皮鞋]",@"[照相]",@"[电话]",@"[石头]",@"[胜利]",@"[禁止]",@"[滑雪]",@"[高尔夫]",@"[网球]",@"[棒球]",@"[冲浪]",@"[足球]",@"[小鱼]",@"[问号]",@"[叹号]",@"[顶]",@"[写字]",@"[衬衫]",@"[小花]",@"[郁金香]",@"[向日葵]",@"[鲜花]",@"[椰树]",@"[仙人掌]",@"[气球]",@"[炸弹]",@"[喝彩]",@"[剪子]",@"[蝴蝶结]",@"[机密]",@"[铃声]",@"[女帽]",@"[裙子]",@"[理发店]",@"[和服]",@"[比基尼]",@"[拎包]",@"[拍摄]",@"[铃铛]",@"[音乐]",@"[心星]",@"[粉心]",@"[丘比特]",@"[吹气]",@"[口水]",@"[对]",@"[错]",@"[绿茶]",@"[面包]",@"[面条]",@"[咖喱饭]",@"[饭团]",@"[麻辣烫]",@"[寿司]",@"[苹果]",@"[橙子]",@"[草莓]",@"[西瓜]",@"[柿子]",@"[眼睛]",@"[好的]", nil];
    m_emojiDic = [[NSDictionary alloc] initWithObjects:wk_paceImageNumArray forKeys:wk_paceImageNameArray];
    
    arr_MyReply=[[NSMutableArray alloc]init];
    
    
    newsArr = [NSMutableArray array];

    tableview_MyCollection=[[UITableView alloc]initWithFrame:CGRectMake(0, 90, 320, Hidth-90)];
    tableview_MyCollection.delegate=self;
    tableview_MyCollection.dataSource=self;
    [self.view addSubview:tableview_MyCollection];
    [tableview_MyCollection addHeaderWithTarget:self action:@selector(MyCollectionDataInit)];
    [tableview_MyCollection addFooterWithTarget:self action:@selector(MyCollectionAddData)];
    [tableview_MyCollection headerBeginRefreshing];

    Status=1;
}
-(void)MyCollectionDataInit
{
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"business_type\":\"4\"}",Session];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    sqHttpSer.strUrl = WoDeShouCang_m28_03;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;
}
-(void)MyCollectionAddData
{
    if (startIndex == idList.count) {
        [tableview_MyCollection footerEndRefreshing];
        [tableview_MyCollection setFooterHidden:YES];
        [SVProgressHUD showSuccessWithStatus:@"没有更多数据了!" duration:1.5];
        return;
        
    }
    NSString *str1=[NSString stringWithFormat:@"\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 10]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    if (Status==1)
    {
        sqHttpSer.strUrl = SheQuHuDong_m10_03;
    }
    else
    {
        sqHttpSer.strUrl = SheQuFuWu_m3_03;
    }
    

    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = NO;

}
-(void)luntan
{
    Status=1;
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"business_type\":\"4\"}",Session];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    sqHttpSer.strUrl = WoDeShouCang_m28_03;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;
    

}
-(void)shangjia
{
    Status=2;

    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"business_type\":\"2\"}",Session];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    sqHttpSer.strUrl=WoDeShouCang_m28_03;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;
    
}

#pragma mark - UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=nil;
    //[tableview_MyCollection setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        
    }
    else
    {
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview]; //删除并进行重新分配
        }
    }
    if (newsArr.count>0)
    {
        
    if (Status==1)
    {
            
        
         CGFloat gao = 0.0;
         UIImageView *imageview_HeadPortraits=[[UIImageView alloc]init];
         imageview_HeadPortraits.frame=CGRectMake(10, 10, 60, 60);
         imageview_HeadPortraits.layer.masksToBounds=YES;
         imageview_HeadPortraits.layer.borderColor = [UIColor redColor].CGColor;
         imageview_HeadPortraits.layer.borderWidth = 1.0f;
         imageview_HeadPortraits.layer.cornerRadius = 30;
         NSString *icon_path=[newsArr[indexPath.row] objectForKey:@"creator_icon"];
         NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:icon_path]];
        if (data.length>0 && ![icon_path isEqualToString:@""] && ![icon_path isEqualToString:nil])
       {
        
           [imageview_HeadPortraits setImageWithURL:[NSURL URLWithString:icon_path] placeholderImage:[UIImage imageNamed:@"setPerson"] options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
       }
      else
       {
            imageview_HeadPortraits.image=[UIImage imageNamed:@"m_personcenter.png"];
       }
    
        [cell addSubview:imageview_HeadPortraits];
        NSString *nickname_str=[newsArr[indexPath.row] objectForKey:@"nickname"];
        NSString *name_str=[newsArr[indexPath.row] objectForKey:@"name"];
        NSString *mobel_str=[newsArr[indexPath.row] objectForKey:@"mobile_phone"];
        NSString *nicheng;
        if (nickname_str.length>0 &&![nickname_str isEqualToString:@" "])
        {
            nicheng=nickname_str;
        }
        else
        {
            if (name_str.length>0 &&![name_str isEqualToString:@" "])
            {
                nicheng=name_str;
            }
            else
            {
                nicheng=mobel_str;
            }
        }
        UILabel *label_name=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 180, 20)];
        label_name.textColor=[UIColor redColor];
        label_name.font=[UIFont systemFontOfSize:14];
        label_name.text=nicheng;
        [cell addSubview:label_name];
        OHAttributedLabel *label = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
        NSString *text = [CustomMethod escapedString:[newsArr[indexPath.row] objectForKey:@"title"]];
        [self creatAttributedLabel:text Label:label];
        [CustomMethod drawImage:label];
        UIView *view = [[UIView alloc] init];
        OHAttributedLabel *label2 = label;
        view.frame = CGRectMake(0, 80, self.view.frame.size.width, label2.frame.size.height);
        gao=label2.frame.size.height;
        label2.textColor=[UIColor blackColor];
        label2.font=[UIFont systemFontOfSize:14];
        [view addSubview:label2];
        [cell addSubview:view];
    
        OHAttributedLabel *label1 = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
        NSString *text1 = [CustomMethod escapedString:[newsArr[indexPath.row] objectForKey:@"content"]];
        [self creatAttributedLabel:text1 Label:label1];
        [CustomMethod drawImage:label1];
        UIView *view1 = [[UIView alloc] init];
        OHAttributedLabel *labelll = label1;
        view1.frame = CGRectMake(0, 80+gao, self.view.frame.size.height, label2.frame.size.height);
    //gao=labelll.frame.size.width;
        labelll.textColor=[UIColor blackColor];
        labelll.font=[UIFont systemFontOfSize:14];
        [view1 addSubview:labelll];
        [cell addSubview:view1];
    
    
        UILabel *label_time=[[UILabel alloc]initWithFrame:CGRectMake(80, 40, 180, 20)];
        label_time.textColor=[UIColor grayColor];
        label_time.font=[UIFont systemFontOfSize:14];
        label_time.text=[newsArr[indexPath.row] objectForKey:@"create_time"];
        [cell addSubview:label_time];
    
        UILabel *pinglunshu=[[UILabel alloc]initWithFrame:CGRectMake(260, 30, 60, 20)];
        pinglunshu.text=[NSString stringWithFormat:@"评论 %@",[newsArr[indexPath.row] objectForKey:@"feedback_num"]];
        pinglunshu.font=[UIFont systemFontOfSize:12];
        [cell addSubview:pinglunshu];
    
    
    //UILabel *laiyuan=[[UILabel alloc]initWithFrame:CGRectMake(10, gao+90+labelll.frame.size.width, 40, 20)];
        UIImageView *imageview_pic=[[UIImageView alloc]init];
        imageview_pic.frame=CGRectMake(10,  gao+90+labelll.frame.size.height, 80, 50);
        NSArray *array=[newsArr[indexPath.row] objectForKey:@"images"];
        if (array.count>0)
        {
            [imageview_pic setImageWithURL:[NSURL URLWithString:[array[0] objectForKey:@"thumbs_url"]] placeholderImage:[UIImage imageNamed:@"setPerson"]  options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [cell addSubview:imageview_pic];
        
        }
    
        UILabel *shanchu=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, gao+140+labelll.frame.size.height, 60, 20)];
        shanchu.text=@"删除收藏";
        shanchu.font=[UIFont systemFontOfSize:14];
        [cell addSubview:shanchu];
    
      
        CGRect cellFrame = [cell frame];
        cellFrame.size.height =gao+170+labelll.frame.size.height;
        [cell setFrame:cellFrame];
    }
    
    if (Status==2)
    {
        NSString *image_url=[newsArr[indexPath.row] objectForKey:@"image_path"];
        NSData *date=[NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]];
        if (date.length>0)
        {
            UIImageView *imagea=[[UIImageView alloc]init];
            imagea= [[UIImageView alloc]initWithFrame:CGRectMake(5, 1, 85,78)];
            imagea.tag = 1000;
            imagea.userInteractionEnabled=NO;
            [imagea setImageWithURL:[NSURL URLWithString:image_url]
                       placeholderImage:[UIImage imageNamed:@"xiaoqufuwu1"]
                                options:SDWebImageRetryFailed
            usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [cell.contentView addSubview:imagea];
                
            UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(95, 0, 220, 20)];
            labela.text=[newsArr[indexPath.row] objectForKey:@"store_name"];
            labela.font=[UIFont systemFontOfSize:14];
            labela.backgroundColor=[UIColor whiteColor];
            labela.textColor=[UIColor blackColor];
            [cell addSubview:labela];
            UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(95, 18, 220, 40)];
            labelb.text=[newsArr[indexPath.row] objectForKey:@"describtion"];
            labelb.backgroundColor=[UIColor whiteColor];
            labelb.numberOfLines=0;
            labelb.font=[UIFont systemFontOfSize:12];
            labelb.textColor=[UIColor grayColor];
            [cell addSubview:labelb];
            UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(220, 58, 95, 20)];
            labelc.text=[newsArr[indexPath.row] objectForKey:@"phone"];
            labelc.backgroundColor=[UIColor whiteColor];
            labelc.font=[UIFont systemFontOfSize:12];
            labelc.textColor=[UIColor grayColor];
            [cell addSubview:labelc];
            UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(95, 58, 125, 20)];
            labeld.text=[newsArr[indexPath.row] objectForKey:@"store_master_name"];
            labeld.backgroundColor=[UIColor whiteColor];
            labeld.font=[UIFont systemFontOfSize:12];
            labeld.textColor=[UIColor grayColor];
            [cell addSubview:labeld];
            
            }
        if (date.length==0)
        {
            UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 310, 20)];
            labela.text=[newsArr[indexPath.row] objectForKey:@"store_name"];
            labela.font=[UIFont systemFontOfSize:14];
            labela.backgroundColor=[UIColor whiteColor];
            labela.textColor=[UIColor blackColor];
            [cell addSubview:labela];
            UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(5, 18, 310, 40)];
            labelb.text=[newsArr[indexPath.row] objectForKey:@"describtion"];
            labelb.backgroundColor=[UIColor whiteColor];
            labelb.numberOfLines=0;
            labelb.font=[UIFont systemFontOfSize:12];
            labelb.textColor=[UIColor grayColor];
            [cell addSubview:labelb];
            UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(220, 58, 95, 20)];
            labelc.text=[newsArr[indexPath.row] objectForKey:@"phone"];
            labelc.backgroundColor=[UIColor whiteColor];
            labelc.font=[UIFont systemFontOfSize:12];
            labelc.textColor=[UIColor grayColor];
            [cell addSubview:labelc];
            UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(5, 58, 215, 20)];
            labeld.text=[newsArr[indexPath.row] objectForKey:@"store_master_name"];
            labeld.backgroundColor=[UIColor whiteColor];
            labeld.font=[UIFont systemFontOfSize:12];
            labeld.textColor=[UIColor grayColor];
            [cell addSubview:labeld];
                
        
        }

        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsArr.count;
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (Status==1)
    {
       UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
       return cell.frame.size.height;
    }
    else
    {
        return 80;
    }
}


#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 18:{
            @try
            {
            startIndex = 0;
            NSLog(@"%@",sqHttpSer.responDict);
            int inta = [[sqHttpSer.responDict objectForKey:@"ecode"] intValue];
            
            if (inta==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1];
                tableview_MyCollection.hidden=YES;
                return;
            }
            NSArray *shuzu=[NSArray arrayWithArray:sqHttpSer.responDict[@"id_list"]];
            for (int i=0; i<shuzu.count; i++)
            {
                [idList addObject:[shuzu[i] objectForKey:@"source_id"]];
            }
            idList = [NSMutableArray arrayWithArray:sqHttpSer.responDict[@"id_list"]];
            NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 10]];
                NSLog(@"参数：%@",str1);
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[PersonCenterHttpService alloc]init];
            if (Status==1)
            {
                sqHttpSer.strUrl = SheQuHuDong_m10_03;
            }
            else
            {
                sqHttpSer.strUrl = SheQuFuWu_m3_03;
            }
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
               
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
            break;
        case 19:{
            @try
            {
            [tableview_MyCollection headerEndRefreshing];
            [tableview_MyCollection footerEndRefreshing];
            
            if (isUp) {
                [newsArr removeAllObjects];
            }
            NSLog(@"%@",sqHttpSer.responDict);
            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info"]];
            [newsArr addObjectsFromArray:responArr];
            [tableview_MyCollection reloadData];
               //NSLog(@"%@",newsArr);
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
            break;
        case 20:{
                [tableview_MyCollection headerEndRefreshing];
                [tableview_MyCollection footerEndRefreshing];
                
                if (isUp) {
                    [newsArr removeAllObjects];
                }
               // NSLog(@"%@",sqHttpSer.responDict);
                NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"wufu_info"]];
                [newsArr addObjectsFromArray:responArr];
                [tableview_MyCollection reloadData];
               // NSLog(@"%@",newsArr);
            
        }

            break;
        default:
            break;
    }
    
}
-(void)didReceieveFail:(NSInteger)tag{
    [tableview_MyCollection headerEndRefreshing];
    [tableview_MyCollection footerEndRefreshing];
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
        [finalStr appendFormat:@"{\"id\":\"%@\"},",arr[index][@"source_id"]];
        startIndex++;
    }
    NSUInteger location = [finalStr length]-1;
    NSRange range = NSMakeRange(location, 1);
    [finalStr replaceCharactersInRange:range withString:@"]"];
    return finalStr;
}

- (void)creatAttributedLabel:(NSString *)o_text Label:(OHAttributedLabel *)label
{
    
    [label setNeedsDisplay];
    NSMutableArray *httpArr = [CustomMethod addHttpArr:o_text];
    NSMutableArray *phoneNumArr = [CustomMethod addPhoneNumArr:o_text];
    NSMutableArray *emailArr = [CustomMethod addEmailArr:o_text];
    
    NSString *text = [CustomMethod transformString:o_text emojiDic:m_emojiDic];
    text = [NSString stringWithFormat:@"<font color='black' strokeColor='gray' face='Palatino-Roman'>%@",text];
    
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSMutableAttributedString* attString = [wk_markupParser attrStringFromMarkup: text];
    [attString setFont:[UIFont systemFontOfSize:18]];//控制显示字体的大小
    [label setBackgroundColor:[UIColor clearColor]];
    [label setAttString:attString withImages:wk_markupParser.images];
    
    NSString *string = attString.string;
    
    if ([emailArr count]) {
        for (NSString *emailStr in emailArr) {
            [label addCustomLink:[NSURL URLWithString:emailStr] inRange:[string rangeOfString:emailStr]];
        }
    }
    
    if ([phoneNumArr count]) {
        for (NSString *phoneNum in phoneNumArr) {
            [label addCustomLink:[NSURL URLWithString:phoneNum] inRange:[string rangeOfString:phoneNum]];
        }
    }
    
    if ([httpArr count]) {
        for (NSString *httpStr in httpArr) {
            [label addCustomLink:[NSURL URLWithString:httpStr] inRange:[string rangeOfString:httpStr]];
        }
    }
    
    label.delegate = self;
    CGRect labelRect = label.frame;
    labelRect.size.width = [label sizeThatFits:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)].width;
    labelRect.size.height = [label sizeThatFits:CGSizeMake(260, 65)].height;
    label.frame = labelRect;
    label.underlineLinks = YES;//链接是否带下划线
    [label.layer display];
}

- (BOOL)attributedLabel:(OHAttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
    //4
    // NSString *requestString = [linkInfo.URL absoluteString];
    if ([[UIApplication sharedApplication]canOpenURL:linkInfo.URL]) {
        [[UIApplication sharedApplication]openURL:linkInfo.URL];
    }
    
    return NO;
}

-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
