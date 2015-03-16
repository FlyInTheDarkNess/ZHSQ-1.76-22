//
//  MyBrokeTheNewsViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-2-12.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "MyBrokeTheNewsViewController.h"
#import "PersonCenterHttpService.h"
#import "AXHButton.h"
extern NSString *UserName;
extern NSString *icon_path;
extern NSString *Session;

@interface MyBrokeTheNewsViewController ()
{
    //主键ID
    NSArray *idList;
    //请求
    PersonCenterHttpService *sqHttpSer;
    //当前列表数据
    NSMutableArray *newsArr;
    //NSMutableArray *_fakeData;
    int startIndex;
    
    BOOL isUp;
}

@end

@implementation MyBrokeTheNewsViewController

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
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];
    
    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label_title.text=@"我的报料";
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.textColor=[UIColor whiteColor];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    
    NSArray *wk_paceImageNumArray = [[NSArray alloc]initWithObjects:@"emoji_1.png",@"emoji_2.png",@"emoji_3.png",@"emoji_4.png",@"emoji_5.png",@"emoji_6.png",@"emoji_7.png",@"emoji_8.png",@"emoji_9.png",@"emoji_10.png",@"emoji_11.png",@"emoji_12.png",@"emoji_13.png",@"emoji_14.png",@"emoji_15.png",@"emoji_16.png",@"emoji_17.png",@"emoji_18.png",@"emoji_19.png",@"emoji_20.png",@"emoji_21.png",@"emoji_22.png",@"emoji_23.png",@"emoji_24.png",@"emoji_25.png",@"emoji_26.png",@"emoji_27.png",@"emoji_28.png",@"emoji_29.png",@"emoji_30.png",@"emoji_31.png",@"emoji_32.png",@"emoji_33.png",@"emoji_34.png",@"emoji_35.png",@"emoji_36.png",@"emoji_37.png",@"emoji_38.png",@"emoji_39.png",@"emoji_40.png",@"emoji_41.png",@"emoji_42.png",@"emoji_43.png",@"emoji_44.png",@"emoji_45.png",@"emoji_45.png",@"emoji_47.png",@"emoji_48.png",@"emoji_49.png",@"emoji_50.png",@"emoji_51.png",@"emoji_52.png",@"emoji_53.png",@"emoji_54.png",@"emoji_55.png",@"emoji_56.png",@"emoji_57.png",@"emoji_58.png",@"emoji_59.png",@"emoji_60.png",@"emoji_16.png",@"emoji_62.png",@"emoji_63.png",@"emoji_64.png",@"emoji_65.png",@"emoji_66.png",@"emoji_67.png",@"emoji_68.png",@"emoji_69.png",@"emoji_70.png",@"emoji_71.png",@"emoji_179.png",@"emoji_180.png",@"emoji_181.png",@"emoji_182.png",@"emoji_183.png",@"emoji_184.png",@"emoji_185.png",@"emoji_186.png",@"emoji_187.png",@"emoji_188.png",@"emoji_189.png",@"emoji_190.png",@"emoji_191.png",@"emoji_192.png",@"emoji_193.png",@"emoji_194.png",@"emoji_195.png",@"emoji_196.png",@"emoji_197.png",@"emoji_198.png",@"emoji_199.png",@"emoji_200.png",@"emoji_201.png",@"emoji_202.png",@"emoji_203.png",@"emoji_204.png",@"emoji_205.png",@"emoji_206.png",@"emoji_207.png",@"emoji_208.png",@"emoji_209.png",@"emoji_210.png",@"emoji_211.png",@"emoji_212.png",@"emoji_213.png",@"emoji_214.png",@"emoji_215.png",@"emoji_216.png",@"emoji_217.png",@"emoji_218.png",@"emoji_219.png",@"emoji_220.png",@"emoji_221.png",@"emoji_222.png",@"emoji_223.png",@"emoji_224.png", nil];
    NSArray *wk_paceImageNameArray = [[NSArray alloc]initWithObjects:@"[可爱]",@"[笑脸]",@"[囧]",@"[生气]",@"[鬼脸]",@"[花心]",@"[害怕]",@"[我汗]",@"[尴尬]",@"[哼哼]",@"[忧郁]",@"[呲牙]",@"[媚眼]",@"[累]",@"[苦逼]",@"[瞌睡]",@"[哎呀]",@"[刺瞎]",@"[哭]",@"[激动]",@"[难过]",@"[害羞]",@"[高兴]",@"[愤怒]",@"[亲]",@"[飞吻]",@"[得意]",@"[惊恐]",@"[口罩]",@"[惊讶]",@"[委屈]",@"[生病]",@"[红心]",@"[心碎]",@"[玫瑰]",@"[花]",@"[外星人]",@"[金牛座]",@"[双子座]",@"[巨蟹座]",@"[狮子座]",@"[处女座]",@"[天平座]",@"[天蝎座]",@"[射手座]",@"[摩羯座]",@"[水瓶座]",@"[白羊座]",@"[双鱼座]",@"[星座]",@"[男孩]",@"[女孩]",@"[嘴唇]",@"[爸爸]",@"[妈妈]",@"[衣服]",@"[皮鞋]",@"[照相]",@"[电话]",@"[石头]",@"[胜利]",@"[禁止]",@"[滑雪]",@"[高尔夫]",@"[网球]",@"[棒球]",@"[冲浪]",@"[足球]",@"[小鱼]",@"[问号]",@"[叹号]",@"[顶]",@"[写字]",@"[衬衫]",@"[小花]",@"[郁金香]",@"[向日葵]",@"[鲜花]",@"[椰树]",@"[仙人掌]",@"[气球]",@"[炸弹]",@"[喝彩]",@"[剪子]",@"[蝴蝶结]",@"[机密]",@"[铃声]",@"[女帽]",@"[裙子]",@"[理发店]",@"[和服]",@"[比基尼]",@"[拎包]",@"[拍摄]",@"[铃铛]",@"[音乐]",@"[心星]",@"[粉心]",@"[丘比特]",@"[吹气]",@"[口水]",@"[对]",@"[错]",@"[绿茶]",@"[面包]",@"[面条]",@"[咖喱饭]",@"[饭团]",@"[麻辣烫]",@"[寿司]",@"[苹果]",@"[橙子]",@"[草莓]",@"[西瓜]",@"[柿子]",@"[眼睛]",@"[好的]", nil];
    m_emojiDic = [[NSDictionary alloc] initWithObjects:wk_paceImageNumArray forKeys:wk_paceImageNameArray];
    
    arr_MyPosts=[[NSMutableArray alloc]init];
    
    
    
    tableview_MyPosts=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, 320, Hidth-60)];
    tableview_MyPosts.delegate=self;
    tableview_MyPosts.dataSource=self;
    [self.view addSubview:tableview_MyPosts];
    [tableview_MyPosts addHeaderWithTarget:self action:@selector(MyReplyDataInit)];
    [tableview_MyPosts addFooterWithTarget:self action:@selector(MyReplyAddData)];
    [tableview_MyPosts headerBeginRefreshing];
    newsArr = [NSMutableArray array];

}
-(void)MyReplyDataInit
{
    NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"count_per_page\":\"500\",\"pagenum\":\"1\"}",Session];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    sqHttpSer.strUrl = BaoLiao_m44_08;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;
}
-(void)MyReplyAddData
{
    if (startIndex == idList.count) {
        [tableview_MyPosts footerEndRefreshing];
        [tableview_MyPosts setFooterHidden:YES];
        [SVProgressHUD showSuccessWithStatus:@"没有更多数据了!" duration:1.5];
        return;
    }
    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 4]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    sqHttpSer.strUrl = BaoLiao_m44_03;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    
    isUp = NO;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CGFloat gao = 0.0;
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
    
    UILabel *label_name=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 180, 20)];
    label_name.textColor=[UIColor redColor];
    label_name.font=[UIFont systemFontOfSize:14];
    label_name.text=UserName;
    [cell addSubview:label_name];
    OHAttributedLabel *label = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    NSString *text = [CustomMethod escapedString:[arr_MyPosts[indexPath.row] objectForKey:@"fnews_title"]];
    label.backgroundColor=[UIColor whiteColor];
    [self creatAttributedLabel:text Label:label];
    [CustomMethod drawImage:label];
    UIView *view = [[UIView alloc] init];
    OHAttributedLabel *label2 = label;
    view.frame = CGRectMake(10, 80, self.view.frame.size.width-20, label2.frame.size.height);
    gao=label2.frame.size.height;
    view.backgroundColor=[UIColor whiteColor];
    label2.textColor=[UIColor blueColor];
    [view addSubview:label2];
    [cell addSubview:view];
    
    OHAttributedLabel *label1 = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    NSString *text1 = [CustomMethod escapedString:[arr_MyPosts[indexPath.row] objectForKey:@"fnews_content"]];
    label1.backgroundColor=[UIColor whiteColor];
    [self creatAttributedLabel:text1 Label:label1];
    [CustomMethod drawImage:label1];
    UIView *view1 = [[UIView alloc] init];
    OHAttributedLabel *labelll = label1;
    view1.frame = CGRectMake(10, 80+gao, self.view.frame.size.height-20, label2.frame.size.height);
    view1.backgroundColor=[UIColor whiteColor];
    //gao=labelll.frame.size.width;
    labelll.textColor=[UIColor blueColor];
    [view1 addSubview:labelll];
    [cell addSubview:view1];
    
    
    UILabel *label_time=[[UILabel alloc]initWithFrame:CGRectMake(80, 40, 180, 20)];
    label_time.textColor=[UIColor grayColor];
    label_time.backgroundColor=[UIColor whiteColor];
    label_time.font=[UIFont systemFontOfSize:14];
    label_time.text=[arr_MyPosts[indexPath.row] objectForKey:@"fnews_addtime"];
    [cell addSubview:label_time];
    
    UIImageView *imageview_pic=[[UIImageView alloc]init];
    imageview_pic.frame=CGRectMake(10,  gao+90+labelll.frame.size.height, 80, 50);
    NSArray *array=[arr_MyPosts[indexPath.row] objectForKey:@"detail_info"];
    if (array.count>0)
    {
        [imageview_pic setImageWithURL:[NSURL URLWithString:[array[0] objectForKey:@"phone_thumbs_url"]] placeholderImage:[UIImage imageNamed:@"setPerson"]  options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell addSubview:imageview_pic];
        
    }
    
//    UILabel *shanchu=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, gao+140+labelll.frame.size.height, 60, 20)];
//    shanchu.text=@"删除帖子";
//    shanchu.font=[UIFont systemFontOfSize:14];
//    [cell addSubview:shanchu];
    AXHButton *delete_btn=[[AXHButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, gao+140+labelll.frame.size.height, 60, 20)];
    delete_btn.tag=indexPath.row;
    [delete_btn setTitle:@"删除帖子" forState:UIControlStateNormal];
    delete_btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [delete_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delete_btn addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:delete_btn];
        
    
    
    
    
    CGRect cellFrame = [cell frame];
    cellFrame.size.height =gao+170+labelll.frame.size.height;
    [cell setFrame:cellFrame];
    
    return cell;
}
-(void)shanchu:(AXHButton *)btn
{
    NSLog(@"删除序列：%d",btn.tag);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arr_MyPosts.count;
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
    //3
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
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 24:{
            startIndex = 0;
            
            NSString *a=sqHttpSer.responDict[@"ecode"];
            NSLog(@"我的消息 :%@",sqHttpSer.responDict);
            intb = [a intValue];
            if (intb==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1.5];
                [tableview_MyPosts headerEndRefreshing];
                
                return;
                
            }
            if (intb==3005)
            {
                [SVProgressHUD showErrorWithStatus:@"重复登录" duration:1.5];
                [tableview_MyPosts headerEndRefreshing];
                
                return;
                
            }

            
            NSArray *array1= [NSArray arrayWithArray:sqHttpSer.responDict[@"bl"]];
            idList=[NSArray arrayWithArray:[array1[0] objectForKey:@"id_list"]];
            NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
            NSLog(@"   canshu   %@",str1);
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[PersonCenterHttpService alloc]init];
            sqHttpSer.strUrl = BaoLiao_m44_03;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
            
        }
            break;
        case 25:{
            [tableview_MyPosts headerEndRefreshing];
            [tableview_MyPosts footerEndRefreshing];
            
            if (isUp) {
                [arr_MyPosts removeAllObjects];
            }
            NSLog(@"我的消息 2:%@",sqHttpSer.responDict);
            NSString *a=sqHttpSer.responDict[@"ecode"];
            intb = [a intValue];
            if (intb==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1.5];
                [tableview_MyPosts headerEndRefreshing];
                
                return;
                
            }
            
            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info"]];
            [arr_MyPosts addObjectsFromArray:responArr];
            [tableview_MyPosts reloadData];
        }
            break;
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
    [tableview_MyPosts headerEndRefreshing];
    [tableview_MyPosts footerEndRefreshing];
   

}

-(NSString *)getFromArr:(NSArray *)arr withNumber:(int)num{
    if (arr.count == 0) {
        return @"";
    }
    NSMutableString *finalStr =[[NSMutableString alloc] initWithString:@"["];
    if (arr.count < num) {
        num = arr.count;
    }
    NSLog(@" >>>> %d",num);
       for (int index = startIndex; index < num; index++) {
        [finalStr appendFormat:@"{\"id\":\"%@\"},",arr[index][@"id"]];
        startIndex++;
    }
    NSUInteger location = [finalStr length]-1;
    NSRange range = NSMakeRange(location, 1);
    [finalStr replaceCharactersInRange:range withString:@"]"];
    return finalStr;
}


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
