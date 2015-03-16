//
//  AXHSQForumCell.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHSQForumCell.h"
#import "CustomMethod.h"
#import "MarkupParser.h"
#import "NSAttributedString+Attributes.h"
static AXHSQForumCell *formCell;
@interface AXHSQForumCell(){
    
}

@end
@implementation AXHSQForumCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
          self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    }else{
          self.backgroundColor = [UIColor whiteColor];
    }
  
    // Configure the view for the selected state
}
+(AXHSQForumCell *)handCellHeight:(id)model{
    
    NSDictionary *dict = model;
  
    formCell = nil;
    if (!formCell) {
        formCell = [[NSBundle mainBundle]loadNibNamed:@"AXHSQForumCell" owner:nil options:nil][0];
        
        UIImageView *peopleImageView = (UIImageView*)[formCell.contentView viewWithTag:1];
        peopleImageView.layer.masksToBounds = YES;
        peopleImageView.layer.cornerRadius = 20.0;
        [peopleImageView setImageWithURL:[NSURL URLWithString:dict[@"creator_icon"]]
                      placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                               options:SDWebImageRetryFailed
           usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
        //名字
        UILabel *nameLab = (UILabel *)[formCell.contentView viewWithTag:2];
        if (![dict[@"nickname"] isEqualToString:@""]) {
            nameLab.text = dict[@"nickname"];
        }else if(![dict[@"mobile_phone"] isEqualToString:@""]){
            NSString *nameMobile = [NSString stringWithFormat:@"%@",dict[@"mobile_phone"]];
           nameMobile =  [nameMobile stringByReplacingCharactersInRange:NSMakeRange(nameMobile.length-8, 4) withString:@"****"];
            nameLab.text = nameMobile;
        }else{
            nameLab.text = @"匿名";
        }

        //日期
        UILabel *dateLab = (UILabel *)[formCell.contentView viewWithTag:3];
        dateLab.text = [NSString stringWithFormat:@"%@",dict[@"create_time"]];;
        
        //标题
        OHAttributedLabel *titleLab = (OHAttributedLabel *)[formCell.contentView viewWithTag:4];
        NSString *titleStr = [CustomMethod escapedString:dict[@"title"]];
        [self creatAttributedLabel:titleStr Label:titleLab withFont:17];
          titleLab.textColor = [UIColor blueColor];
        [CustomMethod drawImage:titleLab];

        //内容
        OHAttributedLabel *detailLab = (OHAttributedLabel *)[formCell.contentView viewWithTag:5];
        NSString *detailStr = [CustomMethod escapedString:dict[@"content"]];
        [self creatAttributedLabel:detailStr Label:detailLab withFont:15];
        detailLab.textColor = [UIColor blackColor];
        [CustomMethod drawImage:detailLab];

        CGRect frame = detailLab.frame;
        frame.origin.y = titleLab.frame.origin.y + titleLab.frame.size.height + 10;
        detailLab.frame = frame;
        NSArray *arr;
        arr = [NSArray arrayWithArray:dict[@"images"]];
        NSMutableArray *imageArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            if (![dict[@"thumbs_url"] isEqualToString:@""]) {
                [imageArr addObject:dict[@"thumbs_url"]];
            }
        }
        
        for (int i = 0; i < imageArr.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(77 + 80 * i, detailLab.frame.origin.y + detailLab.frame.size.height, 80, 80)];
            
            [imageView setImageWithURL:[NSURL URLWithString:imageArr[i]]
                          placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                                   options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
               usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            if (i == 3) {
                break;
            }
            [formCell.contentView addSubview:imageView];
            imageView = nil;
        }
        //评论
        UILabel *plLab = (UILabel *)[formCell.contentView viewWithTag:6];
        plLab.text = [NSString stringWithFormat:@"评论%@条", dict[@"feedback_num"]];
      
        CGRect cellframe = formCell.frame;
        if (imageArr.count > 0) {
              cellframe.size.height = detailLab.frame.origin.y + detailLab.frame.size.height + plLab.frame.size.height + 100;
        }else{
               cellframe.size.height = detailLab.frame.origin.y + detailLab.frame.size.height + plLab.frame.size.height + 20;
            
        }
        formCell.contentView.backgroundColor = [UIColor clearColor];
        formCell.frame = cellframe;
    }
    return formCell;
}




+ (void)creatAttributedLabel:(NSString *)o_text Label:(OHAttributedLabel *)label withFont:(float)font
{
    
    NSArray *wk_paceImageNumArray = [[NSArray alloc]initWithObjects:@"emoji_1.png",@"emoji_2.png",@"emoji_3.png",@"emoji_4.png",@"emoji_5.png",@"emoji_6.png",@"emoji_7.png",@"emoji_8.png",@"emoji_9.png",@"emoji_10.png",@"emoji_11.png",@"emoji_12.png",@"emoji_13.png",@"emoji_14.png",@"emoji_15.png",@"emoji_16.png",@"emoji_17.png",@"emoji_18.png",@"emoji_19.png",@"emoji_20.png",@"emoji_21.png",@"emoji_22.png",@"emoji_23.png",@"emoji_24.png",@"emoji_25.png",@"emoji_26.png",@"emoji_27.png",@"emoji_28.png",@"emoji_29.png",@"emoji_30.png",@"emoji_31.png",@"emoji_32.png",@"emoji_33.png",@"emoji_34.png",@"emoji_35.png",@"emoji_36.png",@"emoji_37.png",@"emoji_38.png",@"emoji_39.png",@"emoji_40.png",@"emoji_41.png",@"emoji_42.png",@"emoji_43.png",@"emoji_44.png",@"emoji_45.png",@"emoji_45.png",@"emoji_47.png",@"emoji_48.png",@"emoji_49.png",@"emoji_50.png",@"emoji_51.png",@"emoji_52.png",@"emoji_53.png",@"emoji_54.png",@"emoji_55.png",@"emoji_56.png",@"emoji_57.png",@"emoji_58.png",@"emoji_59.png",@"emoji_60.png",@"emoji_16.png",@"emoji_62.png",@"emoji_63.png",@"emoji_64.png",@"emoji_65.png",@"emoji_66.png",@"emoji_67.png",@"emoji_68.png",@"emoji_69.png",@"emoji_70.png",@"emoji_71.png",@"emoji_179.png",@"emoji_180.png",@"emoji_181.png",@"emoji_182.png",@"emoji_183.png",@"emoji_184.png",@"emoji_185.png",@"emoji_186.png",@"emoji_187.png",@"emoji_188.png",@"emoji_189.png",@"emoji_190.png",@"emoji_191.png",@"emoji_192.png",@"emoji_193.png",@"emoji_194.png",@"emoji_195.png",@"emoji_196.png",@"emoji_197.png",@"emoji_198.png",@"emoji_199.png",@"emoji_200.png",@"emoji_201.png",@"emoji_202.png",@"emoji_203.png",@"emoji_204.png",@"emoji_205.png",@"emoji_206.png",@"emoji_207.png",@"emoji_208.png",@"emoji_209.png",@"emoji_210.png",@"emoji_211.png",@"emoji_212.png",@"emoji_213.png",@"emoji_214.png",@"emoji_215.png",@"emoji_216.png",@"emoji_217.png",@"emoji_218.png",@"emoji_219.png",@"emoji_220.png",@"emoji_221.png",@"emoji_222.png",@"emoji_223.png",@"emoji_224.png", nil];
    NSArray *wk_paceImageNameArray = [[NSArray alloc]initWithObjects:@"[可爱]",@"[笑脸]",@"[囧]",@"[生气]",@"[鬼脸]",@"[花心]",@"[害怕]",@"[我汗]",@"[尴尬]",@"[哼哼]",@"[忧郁]",@"[呲牙]",@"[媚眼]",@"[累]",@"[苦逼]",@"[瞌睡]",@"[哎呀]",@"[刺瞎]",@"[哭]",@"[激动]",@"[难过]",@"[害羞]",@"[高兴]",@"[愤怒]",@"[亲]",@"[飞吻]",@"[得意]",@"[惊恐]",@"[口罩]",@"[惊讶]",@"[委屈]",@"[生病]",@"[红心]",@"[心碎]",@"[玫瑰]",@"[花]",@"[外星人]",@"[金牛座]",@"[双子座]",@"[巨蟹座]",@"[狮子座]",@"[处女座]",@"[天平座]",@"[天蝎座]",@"[射手座]",@"[摩羯座]",@"[水瓶座]",@"[白羊座]",@"[双鱼座]",@"[星座]",@"[男孩]",@"[女孩]",@"[嘴唇]",@"[爸爸]",@"[妈妈]",@"[衣服]",@"[皮鞋]",@"[照相]",@"[电话]",@"[石头]",@"[胜利]",@"[禁止]",@"[滑雪]",@"[高尔夫]",@"[网球]",@"[棒球]",@"[冲浪]",@"[足球]",@"[小鱼]",@"[问号]",@"[叹号]",@"[顶]",@"[写字]",@"[衬衫]",@"[小花]",@"[郁金香]",@"[向日葵]",@"[鲜花]",@"[椰树]",@"[仙人掌]",@"[气球]",@"[炸弹]",@"[喝彩]",@"[剪子]",@"[蝴蝶结]",@"[机密]",@"[铃声]",@"[女帽]",@"[裙子]",@"[理发店]",@"[和服]",@"[比基尼]",@"[拎包]",@"[拍摄]",@"[铃铛]",@"[音乐]",@"[心星]",@"[粉心]",@"[丘比特]",@"[吹气]",@"[口水]",@"[对]",@"[错]",@"[绿茶]",@"[面包]",@"[面条]",@"[咖喱饭]",@"[饭团]",@"[麻辣烫]",@"[寿司]",@"[苹果]",@"[橙子]",@"[草莓]",@"[西瓜]",@"[柿子]",@"[眼睛]",@"[好的]", nil];
  NSDictionary *m_emojiDic = [[NSDictionary alloc] initWithObjects:wk_paceImageNumArray forKeys:wk_paceImageNameArray];
    
    
    //3
    [label setNeedsDisplay];
    NSMutableArray *httpArr = [CustomMethod addHttpArr:o_text];
    NSMutableArray *phoneNumArr = [CustomMethod addPhoneNumArr:o_text];
    NSMutableArray *emailArr = [CustomMethod addEmailArr:o_text];
    
    NSString *text = [CustomMethod transformString:o_text emojiDic:m_emojiDic];
    text = [NSString stringWithFormat:@"<font color='black' strokeColor='gray' face='Palatino-Roman'>%@",text];
    
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSMutableAttributedString* attString = [wk_markupParser attrStringFromMarkup: text];
    [attString setFont:[UIFont fontWithName:@"AppleGothic" size:font]];//控制显示字体的大小
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
    
    CGRect labelRect = label.frame;
    labelRect.size = [label sizeThatFits:CGSizeMake(label.frame.size.width, CGFLOAT_MAX)];
    label.frame = labelRect;
    label.underlineLinks = YES;//链接是否带下划线
    [label.layer display];
}
@end
