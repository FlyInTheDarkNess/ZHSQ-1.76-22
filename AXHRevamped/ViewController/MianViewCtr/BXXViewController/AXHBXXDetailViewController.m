//
//  AXHBXXDetailViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 15/1/24.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBXXDetailViewController.h"

@interface AXHBXXDetailViewController (){
    NSDictionary *detailDict;
}

@end

@implementation AXHBXXDetailViewController
@synthesize mainScrollView;
@synthesize headView;
@synthesize contentView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDetailDict:(NSDictionary *)dict
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        detailDict = [NSDictionary dictionaryWithDictionary:dict];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil];
    self.navigationItem.title = @"报新鲜";
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 44)];
    [mainScrollView addSubview:[self headViewInit]];
    [mainScrollView addSubview:[self contentViewInit]];
    [mainScrollView setContentSize:CGSizeMake(0, headView.frame.size.height + contentView.frame.size.height)];
    [self.view addSubview:mainScrollView];
}
-(void)backUpper{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView *)headViewInit{
    if (!headView) {
        headView = [[UIView alloc]init];
        //主标题
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kViewwidth - 20, 20)];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textColor = [UIColor blackColor];
        titleLab.font = [UIFont boldSystemFontOfSize:17];
        titleLab.text = detailDict[@"fnews_title"];
        [self labelSizeToFitHeight:titleLab withWidth:kViewwidth - 20 withy:10];
        //副标题
        UILabel *subTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLab.frame.size.height + 20, (kViewwidth - 20)/2, 20)];
        subTitleLab.font = [UIFont systemFontOfSize:15];
        subTitleLab.textColor = [UIColor lightGrayColor];
        subTitleLab.backgroundColor = [UIColor clearColor];
        subTitleLab.text = detailDict[@"fnews_subtitle"];;
        //发布时间
        UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(kViewwidth/2, titleLab.frame.size.height + 20, (kViewwidth - 20)/2, 20)];
        timeLab.font = [UIFont systemFontOfSize:15];
        timeLab.textColor = [UIColor lightGrayColor];
        timeLab.backgroundColor = [UIColor clearColor];
        timeLab.text = detailDict[@"fnews_addtime"];
        timeLab.textAlignment  = NSTextAlignmentRight;
        [headView addSubview:titleLab];
        [headView addSubview:subTitleLab];
        [headView addSubview:timeLab];
        [headView setFrame:CGRectMake(0, 0, kViewwidth, titleLab.frame.size.height + 50)];
        headView.backgroundColor = [UIColor clearColor];
    }
    return headView;
}

-(UIView *)contentViewInit{
    if (!contentView) {
        contentView = [[UIView alloc]init];
        contentView.backgroundColor = [UIColor clearColor];
        NSArray *picArr = [NSArray arrayWithArray:detailDict[@"detail_info"]];
        
        float picContentHeight = 0;
        if (picArr.count != 0) {
            for (int i = 0 ; i < picArr.count; i++) {
                NSDictionary *picDict = [NSDictionary dictionaryWithDictionary:picArr[i]];
                float imageHeight = 0;
                if ([picDict[@"phone_media_url"] length] != 0) {
                    imageHeight = 150;
                    UIImageView *picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 10 + picContentHeight, kViewwidth - 120, 150)];
                    
                    [picImageView setImageWithURL:[NSURL URLWithString:picDict[@"phone_media_url"]]
                                 placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                                          options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
                      usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    [contentView addSubview:picImageView];
                    picImageView = nil;
                }
                
                UILabel *picContLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kViewwidth - 20, 20)];
                picContLab.backgroundColor = [UIColor clearColor];
                picContLab.textColor = [UIColor darkTextColor];
                picContLab.font = [UIFont systemFontOfSize:15];
                picContLab.text =   picDict[@"fnews_media_content"];
                [self labelSizeToFitHeight:picContLab withWidth:kViewwidth - 20 withy:160 + picContentHeight + 3];
                picContentHeight =  10 + imageHeight  + picContLab.frame.size.height + picContentHeight;
                
                [contentView addSubview:picContLab];
                picContLab = nil;
                
            }
        }
        UILabel *detailContentLab = [[UILabel alloc]initWithFrame:CGRectMake(10, picContentHeight + 10, kViewwidth - 20, 20)];
        detailContentLab.font = [UIFont systemFontOfSize:15];
        detailContentLab.backgroundColor = [UIColor clearColor];
        detailContentLab.textColor = [UIColor blackColor];
        detailContentLab.text = detailDict[@"fnews_content"];
        [self labelSizeToFitHeight:detailContentLab withWidth:kViewwidth - 20 withy:picContentHeight + 10];
        [contentView addSubview:detailContentLab];
        [contentView setFrame:CGRectMake(0, headView.frame.size.height, kViewwidth, picContentHeight + detailContentLab.frame.size.height + 10)];
    }
    return contentView;
}

@end
