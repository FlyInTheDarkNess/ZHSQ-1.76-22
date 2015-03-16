//
//  MyReplyViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-26.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "MyReplyViewController.h"
#import "SVProgressHUD.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "MyReply.h"
#import "UIScrollView+MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "AXHButton.h"
#import "RegexKitLite.h"
#import "SCGIFImageView.h"
#import "CustomLongPressGestureRecognizer.h"
#import <QuartzCore/QuartzCore.h>
extern NSString *UserName;
extern NSString *icon_path;
extern NSString *Session;
@interface MyReplyViewController ()

@end

@implementation MyReplyViewController

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
    // Do any additional setup after loading the view.
    @try
    {
        
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        self.view.backgroundColor=[UIColor whiteColor];
        CGRect rect=[[UIScreen mainScreen]bounds];
        CGSize size=rect.size;
        CGFloat Width=size.width;
        CGFloat Hidth=size.height;//Hidth 屏幕高度
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];
        
        label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
        label_title.text=@"我的回复";
        [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        label_title.textAlignment=NSTextAlignmentCenter;
        label_title.textColor=[UIColor whiteColor];
        label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_title];
        fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
        [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
        [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:fanhui];
        btn_weijiaofeizhangdan=[[UIButton alloc]initWithFrame:CGRectMake(0, 60, 160, 30)];
        [btn_weijiaofeizhangdan setTitle:@"论坛" forState:UIControlStateNormal];
        btn_weijiaofeizhangdan.titleLabel.font=[UIFont systemFontOfSize:14];
        btn_weijiaofeizhangdan.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [btn_weijiaofeizhangdan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn_weijiaofeizhangdan addTarget:self action:@selector(luntan) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_weijiaofeizhangdan];
        btn_lishizhangdan=[[UIButton alloc]initWithFrame:CGRectMake(160, 60, 160, 30)];
        [btn_lishizhangdan setTitle:@"商家" forState:UIControlStateNormal];
        btn_lishizhangdan.titleLabel.font=[UIFont systemFontOfSize:14];
        btn_lishizhangdan.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [btn_lishizhangdan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn_lishizhangdan addTarget:self action:@selector(shangjia) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_lishizhangdan];
        
        NSArray *wk_paceImageNumArray = [[NSArray alloc]initWithObjects:@"emoji_1.png",@"emoji_2.png",@"emoji_3.png",@"emoji_4.png",@"emoji_5.png",@"emoji_6.png",@"emoji_7.png",@"emoji_8.png",@"emoji_9.png",@"emoji_10.png",@"emoji_11.png",@"emoji_12.png",@"emoji_13.png",@"emoji_14.png",@"emoji_15.png",@"emoji_16.png",@"emoji_17.png",@"emoji_18.png",@"emoji_19.png",@"emoji_20.png",@"emoji_21.png",@"emoji_22.png",@"emoji_23.png",@"emoji_24.png",@"emoji_25.png",@"emoji_26.png",@"emoji_27.png",@"emoji_28.png",@"emoji_29.png",@"emoji_30.png",@"emoji_31.png",@"emoji_32.png",@"emoji_33.png",@"emoji_34.png",@"emoji_35.png",@"emoji_36.png",@"emoji_37.png",@"emoji_38.png",@"emoji_39.png",@"emoji_40.png",@"emoji_41.png",@"emoji_42.png",@"emoji_43.png",@"emoji_44.png",@"emoji_45.png",@"emoji_45.png",@"emoji_47.png",@"emoji_48.png",@"emoji_49.png",@"emoji_50.png",@"emoji_51.png",@"emoji_52.png",@"emoji_53.png",@"emoji_54.png",@"emoji_55.png",@"emoji_56.png",@"emoji_57.png",@"emoji_58.png",@"emoji_59.png",@"emoji_60.png",@"emoji_16.png",@"emoji_62.png",@"emoji_63.png",@"emoji_64.png",@"emoji_65.png",@"emoji_66.png",@"emoji_67.png",@"emoji_68.png",@"emoji_69.png",@"emoji_70.png",@"emoji_71.png",@"emoji_179.png",@"emoji_180.png",@"emoji_181.png",@"emoji_182.png",@"emoji_183.png",@"emoji_184.png",@"emoji_185.png",@"emoji_186.png",@"emoji_187.png",@"emoji_188.png",@"emoji_189.png",@"emoji_190.png",@"emoji_191.png",@"emoji_192.png",@"emoji_193.png",@"emoji_194.png",@"emoji_195.png",@"emoji_196.png",@"emoji_197.png",@"emoji_198.png",@"emoji_199.png",@"emoji_200.png",@"emoji_201.png",@"emoji_202.png",@"emoji_203.png",@"emoji_204.png",@"emoji_205.png",@"emoji_206.png",@"emoji_207.png",@"emoji_208.png",@"emoji_209.png",@"emoji_210.png",@"emoji_211.png",@"emoji_212.png",@"emoji_213.png",@"emoji_214.png",@"emoji_215.png",@"emoji_216.png",@"emoji_217.png",@"emoji_218.png",@"emoji_219.png",@"emoji_220.png",@"emoji_221.png",@"emoji_222.png",@"emoji_223.png",@"emoji_224.png", nil];
        NSArray *wk_paceImageNameArray = [[NSArray alloc]initWithObjects:@"[可爱]",@"[笑脸]",@"[囧]",@"[生气]",@"[鬼脸]",@"[花心]",@"[害怕]",@"[我汗]",@"[尴尬]",@"[哼哼]",@"[忧郁]",@"[呲牙]",@"[媚眼]",@"[累]",@"[苦逼]",@"[瞌睡]",@"[哎呀]",@"[刺瞎]",@"[哭]",@"[激动]",@"[难过]",@"[害羞]",@"[高兴]",@"[愤怒]",@"[亲]",@"[飞吻]",@"[得意]",@"[惊恐]",@"[口罩]",@"[惊讶]",@"[委屈]",@"[生病]",@"[红心]",@"[心碎]",@"[玫瑰]",@"[花]",@"[外星人]",@"[金牛座]",@"[双子座]",@"[巨蟹座]",@"[狮子座]",@"[处女座]",@"[天平座]",@"[天蝎座]",@"[射手座]",@"[摩羯座]",@"[水瓶座]",@"[白羊座]",@"[双鱼座]",@"[星座]",@"[男孩]",@"[女孩]",@"[嘴唇]",@"[爸爸]",@"[妈妈]",@"[衣服]",@"[皮鞋]",@"[照相]",@"[电话]",@"[石头]",@"[胜利]",@"[禁止]",@"[滑雪]",@"[高尔夫]",@"[网球]",@"[棒球]",@"[冲浪]",@"[足球]",@"[小鱼]",@"[问号]",@"[叹号]",@"[顶]",@"[写字]",@"[衬衫]",@"[小花]",@"[郁金香]",@"[向日葵]",@"[鲜花]",@"[椰树]",@"[仙人掌]",@"[气球]",@"[炸弹]",@"[喝彩]",@"[剪子]",@"[蝴蝶结]",@"[机密]",@"[铃声]",@"[女帽]",@"[裙子]",@"[理发店]",@"[和服]",@"[比基尼]",@"[拎包]",@"[拍摄]",@"[铃铛]",@"[音乐]",@"[心星]",@"[粉心]",@"[丘比特]",@"[吹气]",@"[口水]",@"[对]",@"[错]",@"[绿茶]",@"[面包]",@"[面条]",@"[咖喱饭]",@"[饭团]",@"[麻辣烫]",@"[寿司]",@"[苹果]",@"[橙子]",@"[草莓]",@"[西瓜]",@"[柿子]",@"[眼睛]",@"[好的]", nil];
        m_emojiDic = [[NSDictionary alloc] initWithObjects:wk_paceImageNumArray forKeys:wk_paceImageNameArray];
        
        arr_MyReply=[[NSMutableArray alloc]init];

        
        
        tableview_MyReply=[[UITableView alloc]initWithFrame:CGRectMake(0, 90, 320, Hidth-90)];
        tableview_MyReply.delegate=self;
        tableview_MyReply.dataSource=self;
        [self.view addSubview:tableview_MyReply];
        [tableview_MyReply addHeaderWithTarget:self action:@selector(MyReplyDataInit)];
        [tableview_MyReply addFooterWithTarget:self action:@selector(MyReplyAddData)];
        [tableview_MyReply headerBeginRefreshing];
        

        
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
-(void)MyReplyDataInit
{
    Status=1;
    NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"1\",\"count_per_page\":\"10000\",\"pagenum\":\"1\"}",Session];
    
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    [HttpPostExecutor postExecuteWithUrlStr:MyReply_m22_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
        if (result.length<=0)
        {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
        }
        else
        {
            
            NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
            NSLog(@"第1次: %@", str_jiemi);
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error=nil;
            NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
            NSString *str_tishi=[rootDic objectForKey:@"ecode"];
            intb =[str_tishi intValue];
            if (intb==3007)
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 30)];
                label.text=@"未查找到数据";
                label.textAlignment=NSTextAlignmentCenter;
                label.font=[UIFont systemFontOfSize:14];
                [self.view addSubview:label];
                [tableview_MyReply headerEndRefreshing];
            }
            
            if (intb==1000)
            {
                int IdNum;
                arr_ForumId=[rootDic objectForKey:@"id_list"];
                MyReply *zhangdanid=[[MyReply alloc]init];
                
                if (arr_ForumId.count<4)
                {
                    zhangdanid.id_array=arr_ForumId;
                    IdNum=arr_ForumId.count;
                    
                }
                else
                {
                    NSMutableArray *arr=[[NSMutableArray alloc]init];
                    for (int i=0; i<3; i++)
                    {
                        [arr addObject:arr_ForumId[i]];
                    }
                    zhangdanid.id_array=arr;
                    IdNum=3;
                }
                zhangdanid.session=Session;
                
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:zhangdanid childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:MyReply_m22_02 Paramters:Str FinishCallbackBlock:^(NSString *result)
                 {
                     // 执行post请求完成后的逻辑
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {
                         
                         NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                         NSLog(@"第二次:sssssssssss %@", str_jiemi);
                         
                         SBJsonParser *parser=[[SBJsonParser alloc]init];
                         NSError *error=nil;
                         NSDictionary *Dic=[parser objectWithString:str_jiemi error:&error];
                         NSString *str_tishi=[Dic objectForKey:@"ecode"];
                         intb =[str_tishi intValue];
                         if (intb==1000)
                         {
                             [arr_ForumId removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_ForumId.count, IdNum))]];
                             arr_Forum=[Dic objectForKey:@"info_array"];
                             arr_MyReply=arr_Forum;
                             [tableview_MyReply reloadData];
                             [tableview_MyReply headerEndRefreshing];

                             
                         }
                         if (intb==4000)
                         {
                             [SVProgressHUD showSuccessWithStatus:@"服务器内部错误" duration:1.5];
                             [tableview_MyReply headerEndRefreshing];
                         }
                         
                         
                     }
                 }];
                
                
            }
        }
    }];

}
-(void)MyReplyAddData
{
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (intb==3007)
    {
        
            labelll=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 30)];
            labelll.text=@"未查找到数据";
            labelll.textAlignment=NSTextAlignmentCenter;
            labelll.backgroundColor=[UIColor whiteColor];
            labelll.font=[UIFont systemFontOfSize:14];
            [cell addSubview:labelll];
    }

    if (arr_MyReply.count==0)
    {
        
    }
    if (arr_MyReply.count>0)
    {
        if (intb==3007)
        {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 30)];
            label.text=@"未查找到数据";
            label.textAlignment=NSTextAlignmentCenter;
            label.font=[UIFont systemFontOfSize:14];
            [cell addSubview:label];
        }
        else
        {
            CGFloat gao = 0.0;
            if (Status==1)
            {
                UIImageView *imageview_HeadPortraits=[[UIImageView alloc]init];
                imageview_HeadPortraits.frame=CGRectMake(10, 10, 60, 60);
                imageview_HeadPortraits.layer.masksToBounds=YES;
                imageview_HeadPortraits.layer.borderColor = [UIColor redColor].CGColor;
                imageview_HeadPortraits.layer.borderWidth = 1.0f;
                imageview_HeadPortraits.layer.cornerRadius = 30;
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
                
                UILabel *label_name=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, self.view.frame.size.width-80, 20)];
                label_name.textColor=[UIColor redColor];
                label_name.text=UserName;
                [cell addSubview:label_name];
                OHAttributedLabel *label = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
                NSString *text = [CustomMethod escapedString:[arr_MyReply[indexPath.row] objectForKey:@"card_content"]];
                [self creatAttributedLabel:text Label:label];
                [CustomMethod drawImage:label];
                UIView *view = [[UIView alloc] init];
                OHAttributedLabel *label2 = label;
                view.frame = CGRectMake(0, 80, self.view.frame.size.width, label2.frame.size.height);
                //NSLog(@"%f",label2.frame.size.width);
                gao=label2.frame.size.height;
                label2.textColor=[UIColor blueColor];
                // label2.backgroundColor=[UIColor orangeColor];
                [view addSubview:label2];
                
                UILabel *label_time=[[UILabel alloc]initWithFrame:CGRectMake(80, 40, self.view.frame.size.width-80, 20)];
                label_time.textColor=[UIColor grayColor];
                label_time.text=[arr_MyReply[indexPath.row] objectForKey:@"card_publishtime"];
                [cell addSubview:label_time];
                UILabel *laiyuan=[[UILabel alloc]initWithFrame:CGRectMake(10, gao+90, 40, 20)];
                laiyuan.text=@"原帖:";
                laiyuan.font=[UIFont systemFontOfSize:14];
                [cell addSubview:laiyuan];
                UILabel *card_title=[[UILabel alloc]initWithFrame:CGRectMake(50, gao+90, self.view.frame.size.width-120, 20)];
                card_title.text=[arr_MyReply[indexPath.row] objectForKey:@"replay_card_title"];
                card_title.textColor=[UIColor blueColor];
                card_title.font=[UIFont systemFontOfSize:14];
                [cell addSubview:card_title];
//                
//                UILabel *shanchu=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, gao+90, 60, 20)];
//                shanchu.text=@"删除回复";
//                shanchu.font=[UIFont systemFontOfSize:14];
//                [cell addSubview:shanchu];
//                [cell addSubview:view];
                
                AXHButton *delete_btn=[[AXHButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, gao+90, 60, 20)];
                delete_btn.backgroundColor=[UIColor whiteColor];
                delete_btn.tag=indexPath.row;
                [delete_btn setTitle:@"删除回复" forState:UIControlStateNormal];
                delete_btn.titleLabel.font=[UIFont systemFontOfSize:14];
                [delete_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [delete_btn addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:delete_btn];


            }
            if (Status==2)
            {
                
                
                UILabel *label_name=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, self.view.frame.size.width-80, 20)];
                label_name.textColor=[UIColor redColor];
                label_name.text=UserName;
                [cell addSubview:label_name];
                OHAttributedLabel *label = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
                NSString *text = [CustomMethod escapedString:[arr_MyReply[indexPath.row] objectForKey:@"card_content"]];
                [self creatAttributedLabel:text Label:label];
                [CustomMethod drawImage:label];
                UIView *view = [[UIView alloc] init];
                OHAttributedLabel *label2 = label;
                view.frame = CGRectMake(0, 80, self.view.frame.size.width, label2.frame.size.height);
                //NSLog(@"%f",label2.frame.size.width);
                gao=label2.frame.size.width;
                label2.textColor=[UIColor blueColor];
                // label2.backgroundColor=[UIColor orangeColor];
                [view addSubview:label2];
                
                UILabel *label_time=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, self.view.frame.size.width-80, 20)];
                label_time.textColor=[UIColor grayColor];
                label_time.text=[arr_MyReply[indexPath.row] objectForKey:@"card_publishtime"];
                [cell addSubview:label_time];
                UILabel *laiyuan=[[UILabel alloc]initWithFrame:CGRectMake(10, gao+90, 40, 20)];
                laiyuan.text=@"原帖:";
                laiyuan.font=[UIFont systemFontOfSize:14];
                [cell addSubview:laiyuan];
                UILabel *card_title=[[UILabel alloc]initWithFrame:CGRectMake(50, gao+90, self.view.frame.size.width-120, 20)];
                card_title.text=[arr_MyReply[indexPath.row] objectForKey:@"replay_card_title"];
                card_title.textColor=[UIColor blueColor];
                card_title.font=[UIFont systemFontOfSize:14];
                [cell addSubview:card_title];
                
//                UILabel *shanchu=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, gao+90, 60, 20)];
//                shanchu.text=@"删除回复";
//                shanchu.font=[UIFont systemFontOfSize:14];
//                [cell addSubview:shanchu];
//                [cell addSubview:view];
                
                AXHButton *delete_btn=[[AXHButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, gao+90, 60, 20)];
                delete_btn.backgroundColor=[UIColor whiteColor];
                delete_btn.tag=indexPath.row;
                [delete_btn setTitle:@"删除回复" forState:UIControlStateNormal];
                delete_btn.titleLabel.font=[UIFont systemFontOfSize:14];
                [delete_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [delete_btn addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:delete_btn];

            }
            
            
            CGRect cellFrame = [cell frame];
            cellFrame.size.height =gao+110;
            [cell setFrame:cellFrame];

            
        }

    }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}
-(void)shanchu:(AXHButton *)btn
{
    
    if (Status==1)
    {
        sanchu_url=SheQuHuDong_m10_09;
        NSLog(@"论坛 %d",btn.tag);
    }
    if (Status==2)
    {
        sanchu_url=SheQuFuWu_m3_10;
    }
    tieziID=[arr_MyReply[btn.tag] objectForKey:@"card_id"];
    NSLog(@"%@",tieziID);
    NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"id_list\":[{\"id\":\"%@\"}]}",Session,tieziID];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    [HttpPostExecutor postExecuteWithUrlStr:sanchu_url Paramters:Str FinishCallbackBlock:^(NSString *result)
     {
         // 执行post请求完成后的逻辑
         if (result.length<=0)
         {
             UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [aler show];
         }
         else
         {
             
             NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
             NSLog(@"第二次:sssssssssss %@", str_jiemi);
             
             SBJsonParser *parser=[[SBJsonParser alloc]init];
             NSError *error=nil;
             NSDictionary *Dic=[parser objectWithString:str_jiemi error:&error];
             NSString *str_tishi=[Dic objectForKey:@"ecode"];
             intb =[str_tishi intValue];
             if (intb==1000)
             {
                 [SVProgressHUD showSuccessWithStatus:@"删除成功" duration:1];
                 if (Status==1)
                 {
                     [self luntan];
                 }
                 if (Status==2)
                 {
                     [self shangjia];
                 }

             }
         }
     }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arr_MyReply.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)shangjia
{
     Status=2;
    @try
    {
        
        [btn_lishizhangdan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn_weijiaofeizhangdan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [arr_Forum removeAllObjects];
        [arr_MyReply removeAllObjects];

        
        NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"2\",\"count_per_page\":\"10000\",\"pagenum\":\"1\"}",Session];
        
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
        [HttpPostExecutor postExecuteWithUrlStr:MyReply_m22_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {
                
                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                NSLog(@"第1次: %@", str_jiemi);
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSError *error=nil;
                NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                NSString *str_tishi=[rootDic objectForKey:@"ecode"];
                intb =[str_tishi intValue];
                if (intb==3007)
                {
                    [tableview_MyReply headerEndRefreshing];
                    [tableview_MyReply reloadData];
                }
                
                if (intb==1000)
                {
                    int IdNum;
                    arr_ShopsId=[rootDic objectForKey:@"id_list"];
                    MyReply *zhangdanid=[[MyReply alloc]init];
                    
                    if (arr_ShopsId.count<4)
                    {
                        zhangdanid.id_array=arr_ShopsId;
                        IdNum=arr_ShopsId.count;
                        
                    }
                    else
                    {
                        NSMutableArray *arr=[[NSMutableArray alloc]init];
                        for (int i=0; i<3; i++)
                        {
                            arr=arr_ShopsId[i];
                        }
                        zhangdanid.id_array=arr;
                        IdNum=3;
                    }
                    zhangdanid.session=Session;
                    
                    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:zhangdanid childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                    
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    [HttpPostExecutor postExecuteWithUrlStr:MyReply_m22_02 Paramters:Str FinishCallbackBlock:^(NSString *result)
                     {
                         // 执行post请求完成后的逻辑
                         if (result.length<=0)
                         {
                             UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                             [aler show];
                         }
                         else
                         {
                             
                             NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                             NSLog(@"删除: %@", str_jiemi);
                             
                             SBJsonParser *parser=[[SBJsonParser alloc]init];
                             NSError *error=nil;
                             NSDictionary *Dic=[parser objectWithString:str_jiemi error:&error];
                             NSString *str_tishi=[Dic objectForKey:@"ecode"];
                             intb =[str_tishi intValue];
                             if (intb==1000)
                                     
                             {
                                 [arr_ShopsId removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_ShopsId.count, IdNum))]];
                                 arr_Forum=[Dic objectForKey:@"info_array"];
                                 arr_MyReply=arr_Forum;
                                 [tableview_MyReply reloadData];
                                 [tableview_MyReply headerEndRefreshing];
                                 
                             }
                             if (intb==3007)
                             {
                                 [SVProgressHUD showSuccessWithStatus:@"没有查找到数据" duration:1.5];
                                 [tableview_MyReply reloadData];
                                 [tableview_MyReply headerEndRefreshing];


                             }
                             if (intb==4000)
                             {
                                 [SVProgressHUD showSuccessWithStatus:@"服务器内部错误" duration:1.5];
                                 [tableview_MyReply headerEndRefreshing];

                             }
                             
                             
                         }
                     }];
                    
                    
                }
            }
        }];
        
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
-(void)luntan
{
     Status=1;
    @try
    {
        
        [btn_lishizhangdan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn_weijiaofeizhangdan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [arr_Forum removeAllObjects];
        [arr_MyReply removeAllObjects];

        NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"1\",\"count_per_page\":\"10000\",\"pagenum\":\"1\"}",Session];
        
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
        [HttpPostExecutor postExecuteWithUrlStr:MyReply_m22_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {
                
                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                NSLog(@"第1次: %@", str_jiemi);
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSError *error=nil;
                NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                NSString *str_tishi=[rootDic objectForKey:@"ecode"];
                intb =[str_tishi intValue];
                if (intb==3007)
                {
                    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 30)];
                    label.text=@"未查找到数据";
                    label.textAlignment=NSTextAlignmentCenter;
                    label.font=[UIFont systemFontOfSize:14];
                    [self.view addSubview:label];
                    [tableview_MyReply headerEndRefreshing];
                }
                
                if (intb==1000)
                {
                    int IdNum;
                    arr_ForumId=[rootDic objectForKey:@"id_list"];
                    MyReply *zhangdanid=[[MyReply alloc]init];
                    
                    if (arr_ForumId.count<4)
                    {
                        zhangdanid.id_array=arr_ForumId;
                        IdNum=arr_ForumId.count;
                        
                    }
                    else
                    {
                        NSMutableArray *arr=[[NSMutableArray alloc]init];
                        for (int i=0; i<3; i++)
                        {
                            [arr addObject:arr_ForumId[i]];
                        }
                        zhangdanid.id_array=arr;
                        IdNum=3;
                    }
                    zhangdanid.session=Session;
                    
                    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:zhangdanid childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                    
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    [HttpPostExecutor postExecuteWithUrlStr:MyReply_m22_02 Paramters:Str FinishCallbackBlock:^(NSString *result)
                     {
                         // 执行post请求完成后的逻辑
                         if (result.length<=0)
                         {
                             UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                             [aler show];
                         }
                         else
                         {
                             
                             NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                             NSLog(@"第二次:sssssssssss %@", str_jiemi);
                             
                             SBJsonParser *parser=[[SBJsonParser alloc]init];
                             NSError *error=nil;
                             NSDictionary *Dic=[parser objectWithString:str_jiemi error:&error];
                             NSString *str_tishi=[Dic objectForKey:@"ecode"];
                             intb =[str_tishi intValue];
                             if (intb==1000)
                             {
                                 [arr_ForumId removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_ForumId.count, IdNum))]];
                                 arr_Forum=[Dic objectForKey:@"info_array"];
                                 arr_MyReply=arr_Forum;
                                 [tableview_MyReply reloadData];
                                 [tableview_MyReply headerEndRefreshing];
                                 
                                 
                             }
                             if (intb==4000)
                             {
                                 [SVProgressHUD showSuccessWithStatus:@"服务器内部错误" duration:1.5];
                                 [tableview_MyReply headerEndRefreshing];
                             }
                             
                             
                         }
                     }];
                    
                    
                }
            }
        }];
        
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
