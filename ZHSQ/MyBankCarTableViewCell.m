//
//  MyBankCarTableViewCell.m
//  ZHSQ
//
//  Created by 赵贺 on 15-2-4.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "MyBankCarTableViewCell.h"

@implementation MyBankCarTableViewCell
@synthesize beijing_label;
- (void)awakeFromNib
{
    // Initialization code
//    count_label.layer.cornerRadius=10;
//    count_label.layer.masksToBounds = YES;
    beijing_label.layer.masksToBounds=YES;
    beijing_label.layer.cornerRadius=10;
    beijing_label.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
