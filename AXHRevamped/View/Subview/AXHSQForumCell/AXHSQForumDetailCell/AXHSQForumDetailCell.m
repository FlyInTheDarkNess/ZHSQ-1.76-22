//
//  AXHSQForumDetailCell.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/26.
//  Copyright (c) 2014年 lacom. All rights reserved.
//
#define kViewwidth [UIScreen mainScreen].applicationFrame.size.width

#import "AXHSQForumDetailCell.h"
#import "CustomMethod.h"
static AXHSQForumDetailCell *formCell;
@implementation AXHSQForumDetailCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(AXHSQForumDetailCell *)handCellHeight:(id)model{
    
    NSDictionary *dict = model;
    
    formCell = nil;
    if (!formCell) {
        formCell = [[NSBundle mainBundle]loadNibNamed:@"AXHSQForumDetailCell" owner:nil options:nil][0];
       
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
        nameLab.font = [UIFont systemFontOfSize:14 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType] ];
        //内容
        OHAttributedLabel *detailLab = (OHAttributedLabel *)[formCell.contentView viewWithTag:5];
        NSString *detailStr = [CustomMethod escapedString:dict[@"content"]];
        [SurveyRunTimeData creatAttributedLabel:detailStr Label:detailLab withFont:15 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType]];
        detailLab.textColor = [UIColor blackColor];
        [CustomMethod drawImage:detailLab];
 
        if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsNight]) {
            nameLab.textColor = nightTextColor;
            detailLab.textColor = nightTextColor;
        }else{
            nameLab.textColor = daytimeTextColor;
            detailLab.textColor = daytimeTextColor;
        }
        
        NSArray *arr;
        arr = [NSArray arrayWithArray:dict[@"images"]];
        NSMutableArray *imageArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            if (![dict[@"pic_url"] isEqualToString:@""]) {
                [imageArr addObject:dict[@"pic_url"]];
            }
        }
        float picContentHeight = detailLab.frame.size.height + 65;
        for (int i = 0; i < imageArr.count; i++) {
           float imageHeight = 150;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, picContentHeight, kViewwidth - 20, imageHeight)];
            
            [imageView setImageWithURL:[NSURL URLWithString:imageArr[i]]
                      placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                               options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
           usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            imageView.contentMode = UIViewContentModeScaleToFill;
            imageView.backgroundColor = [UIColor clearColor];
            [formCell.contentView addSubview:imageView];
            imageView = nil;
            picContentHeight =  10 + imageHeight  + picContentHeight;
        }
        
        CGRect cellframe = formCell.frame;
        if (imageArr.count > 0) {
            cellframe.size.height = picContentHeight;
        }else{
            cellframe.size.height = detailLab.frame.origin.y + detailLab.frame.size.height + 20;
        }
   
        formCell.contentView.backgroundColor = [UIColor clearColor];

        formCell.frame = cellframe;
    }
    return formCell;
}

@end
