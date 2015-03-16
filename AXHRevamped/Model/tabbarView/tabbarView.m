//
//  tabbarView.m
//  tabbarTest
//
//  Created by Kevin Lee on 13-5-6.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//

#define tViewwidth [UIScreen mainScreen].applicationFrame.size.width
#import "tabbarView.h"

@implementation tabbarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setFrame:frame];

        [self layoutView];
    
    }
    return self;
}

-(void)layoutView
{
    _tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    _tabbarView.backgroundColor = [UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:1];
     [self addSubview:_tabbarView];
    [self layoutBtn];
    
}

-(void)layoutBtn
{
    _button_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button_1 setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    [_button_1 setTitle:@"评论" forState:UIControlStateNormal];
    [_button_1 setFrame:CGRectMake(0, 0, (tViewwidth * 7 /10  ) / 3, 40)];
    [_button_1 setTag:101];
    [_button_1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake((tViewwidth * 7 /10  ) / 3, 10, 0.5, 20)];
    lineView1.backgroundColor = [UIColor whiteColor];
    
    _button_2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button_2 setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
     [_button_2 setTitle:@"收藏" forState:UIControlStateNormal];
    [_button_2 setFrame:CGRectMake((tViewwidth * 7 /10  ) / 3, 0, (tViewwidth * 7 /10  ) / 3, 40)];
    [_button_2 setTag:102];
    [_button_2 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake((tViewwidth * 7 /10  ) / 3 * 2, 10, 0.5, 20)];
    lineView2.backgroundColor = [UIColor whiteColor];
    
    _button_3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button_3 setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [_button_3 setTitle:@"分享" forState:UIControlStateNormal];
    [_button_3 setFrame:CGRectMake((tViewwidth * 7 /10  ) / 3 *2, 0, (tViewwidth * 7 /10  ) / 3, 40)];
    [_button_3 setTag:103];
    [_button_3 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(tViewwidth * 7 /10  , 10, 0.5, 20)];
    lineView3.backgroundColor = [UIColor whiteColor];
    
    _button_4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button_4 setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [_button_4 setFrame:CGRectMake(tViewwidth * 7 /10, 0, (tViewwidth * 3 /10  ) / 2, 40)];
    [_button_4 setTag:104];
    [_button_4 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(tViewwidth - ((tViewwidth * 3 /10  ) / 2), 10, 0.5, 20)];
    lineView4.backgroundColor = [UIColor whiteColor];
    
    _button_5 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button_5 setImage:[UIImage imageNamed:@"cai"] forState:UIControlStateNormal];
    [_button_5 setFrame:CGRectMake(tViewwidth - ((tViewwidth * 3 /10  ) / 2), 0, (tViewwidth * 3 /10  ) / 2, 40)];
    [_button_5 setTag:105];
    [_button_5 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [_tabbarView addSubview:_button_1];
    [_tabbarView addSubview:_button_2];
    [_tabbarView addSubview:_button_3];
    [_tabbarView addSubview:_button_4];
    [_tabbarView addSubview:_button_5];
    
    [_tabbarView addSubview:lineView1];
    [_tabbarView addSubview:lineView2];
    [_tabbarView addSubview:lineView3];
    [_tabbarView addSubview:lineView4];
}
-(void)btn1Click:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
       
        case 101:{
             [self.delegate touchBtnAtIndex:1];
        }
            break;
        case 102:
        {
            [self.delegate touchBtnAtIndex:2];
            
        }break;
        case 103:
        {
            [self.delegate touchBtnAtIndex:3];
          
        }  break;
        case 104:
        {
            [self.delegate touchBtnAtIndex:4];
            
        }break;
        case 105:
        {
            [self.delegate touchBtnAtIndex:5];
        }break;
        default:
            break;
    }
}

@end
