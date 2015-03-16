//
//  YHGoodsDetailCell.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/16.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "YHGoodsDetailCell.h"
static YHGoodsDetailCell *goodsCell;
@implementation YHGoodsDetailCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(YHGoodsDetailCell *)handCellHeight:(id)model{
    
    NSDictionary *dict = model;
    NSLog(@"%@",dict);
    
    goodsCell = nil;
    if (!goodsCell) {
        goodsCell = [[NSBundle mainBundle]loadNibNamed:@"YHGoodsDetailCell" owner:nil options:nil][0];
        }
    
    UIImageView *backCellImage = (UIImageView *)[goodsCell.contentView viewWithTag:5];
    [backCellImage setImage:[[UIImage imageNamed:@"collection_cell_bg"] stretchableImageWithLeftCapWidth:106/4 topCapHeight:106/4]];
        //商家名称
        UILabel *goodsNameLab = (UILabel *)[goodsCell.contentView viewWithTag:1];
        goodsNameLab.text = [NSString stringWithFormat:@"%@",dict[@"store_name"]];
        
      //商品价格
        UILabel *yhPrice = (UILabel *)[goodsCell.contentView viewWithTag:2];
        yhPrice.text = [NSString stringWithFormat:@"优惠价:￥%@",dict[@"price3"]];


    
        LPLabel *hyPrice = (LPLabel *)[goodsCell.contentView viewWithTag:3];
        hyPrice.text = [NSString stringWithFormat:@"会员价:￥%@",dict[@"price2"]];
        hyPrice.strikeThroughEnabled = YES;
        hyPrice.strikeThroughColor = [UIColor redColor];
        
        
        LPLabel *scPrice = (LPLabel *)[goodsCell.contentView viewWithTag:4];
        scPrice.text = [NSString stringWithFormat:@"市场价:￥%@",dict[@"price1"]];
        scPrice.strikeThroughEnabled = YES;
        scPrice.strikeThroughColor = [UIColor redColor];
        
    
        CGRect cellframe = goodsCell.frame;
        cellframe.size.height = 90;
        goodsCell.frame = cellframe;
        goodsCell.contentView.backgroundColor = [UIColor clearColor];

    
    return goodsCell;
}

@end
