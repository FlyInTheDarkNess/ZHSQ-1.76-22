
//
//  AXHSeckillIntroduceViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/26.
//  Copyright (c) 2014年 lacom. All rights reserved.
//
#define headHeight 40
#define cellHeight  200
#import "AXHSeckillIntroduceViewController.h"

@interface AXHSeckillIntroduceViewController (){
 

    //标头滑动图片
    UIImageView *btnSelectedImage;
    
    NSDictionary *seckillDict;

}
@end

@implementation AXHSeckillIntroduceViewController
@synthesize scrollRootView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSeckillDict:(NSDictionary *)dict
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        seckillDict = dict;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil];
    self.navigationItem.title = @"商品详情";
    
    NSArray *headBtnArr = [NSArray arrayWithObjects:@"商品介绍",@"规格参数",@"售后服务",nil];
    int btnTag = 2014;
    for (int i = 0; i < 3; i++) {
        
        UIButton *headBtn = [[UIButton alloc]initWithFrame:CGRectMake(kViewwidth/3 * i, 0, kViewwidth/3, headHeight)];
        headBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [headBtn setBackgroundColor:[UIColor whiteColor]];
        [headBtn setTitle:headBtnArr[i] forState:UIControlStateNormal];
        if (i == 0) {
            [headBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:153/255.0 blue:230/255.0 alpha:1] forState:UIControlStateNormal];
        }else{
            [headBtn setTitleColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
        }
        //添加事件用
        headBtn.tag = btnTag;
        [headBtn addTarget:self action:@selector(btnChange:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:headBtn];
        btnTag++;
    }
    btnSelectedImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, headHeight - 2, kViewwidth/3, 2)];
    btnSelectedImage.image = [UIImage imageNamed:@"headline"];
    [self.view addSubview:btnSelectedImage];
    
    
    [self.view addSubview:[self scroViewInit]];
}
-(void)backUpper{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIScrollView *)scroViewInit{
    
    if (!scrollRootView) {
        scrollRootView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, kViewwidth, kViewHeight - 84)];
        scrollRootView.pagingEnabled = YES;
        scrollRootView.showsHorizontalScrollIndicator = NO;
        scrollRootView.bounces = NO;
        scrollRootView.delegate = self;
        scrollRootView.backgroundColor = [UIColor clearColor];
        CGSize size = scrollRootView.frame.size;
        [scrollRootView setContentSize:CGSizeMake(size.width * 3, size.height)];
        int tableViewTag = 2014;
        for (int i = 0; i < 3; i++) {
            UITableView  *introduceTableview = [[UITableView alloc]initWithFrame:CGRectMake(kViewwidth * i , 0, size.width , size.height)];
            
            introduceTableview.backgroundColor = [UIColor clearColor];
            introduceTableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            introduceTableview.delegate = self;
            introduceTableview.dataSource = self;
            introduceTableview.tag = tableViewTag;
            introduceTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
            [scrollRootView addSubview:introduceTableview];
            introduceTableview = nil;
            tableViewTag++;
        }
    }
    return scrollRootView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    switch (tableView.tag) {
        case 2014:{
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, kViewwidth - 10, cellHeight - 10)];
            [imageView setImageWithURL:[NSURL URLWithString:seckillDict[@"goods_intro"][indexPath.row][@"url_big"]]
                      placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                               options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
           usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            [cell.contentView addSubview:imageView];
           
        }
            break;
        case 2015:{
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, kViewwidth - 10, cellHeight - 10)];
            [imageView setImageWithURL:[NSURL URLWithString:seckillDict[@"goods_para"][indexPath.row][@"url_big"]]
                      placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
                               options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
           usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
   
            [cell.contentView addSubview:imageView];
            
        }
            break;
        case 2016:{
            
        }
            break;
            
        default:
            break;
    }
    cell.backgroundColor = [UIColor lightGrayColor];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 2014:{
            NSArray *arr = [NSArray arrayWithArray:seckillDict[@"goods_intro"]];
          return  arr.count;
        }
            break;
        case 2015:  {
            NSArray *arr = [NSArray arrayWithArray:seckillDict[@"goods_para"]];
            return  arr.count;
        }
            break;
        case 2016:
            return 0;
            break;
            
        default:
            break;
    }
    return 0;
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return cellHeight;
}


#pragma mark Button TouchUpInside
-(void)btnChange:(UIButton *)btn
{
    for (UIButton *seletedbtn  in self.view.subviews) {
        if ([seletedbtn isKindOfClass:[UIButton class]]) {
            if (seletedbtn.tag == btn.tag) {
                [seletedbtn setTitleColor:[UIColor colorWithRed:0/255.0 green:153/255.0 blue:230/255.0 alpha:1] forState:UIControlStateNormal];
            }else{
                [seletedbtn setTitleColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
            }
        }
    }
    [UIView animateWithDuration:0.3 animations:^(void){
        btnSelectedImage.frame = CGRectMake(kViewwidth/3 * (btn.tag - 2014), headHeight - 2, kViewwidth/3, 2);
    }completion:NULL];
    [scrollRootView setContentOffset:CGPointMake(kViewwidth * (btn.tag - 2014), 0) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == scrollRootView) {
        [UIView animateWithDuration:0.3 animations:^(void){
            btnSelectedImage.frame = CGRectMake(kViewwidth/3 * (scrollView.contentOffset.x / kViewwidth), headHeight - 2, kViewwidth/3, 2);
        }completion:^(BOOL finished){
            if (finished) {
                for (UIButton *seletedbtn  in self.view.subviews) {
                    if ([seletedbtn isKindOfClass:[UIButton class]]) {
                        if (seletedbtn.tag == scrollView.contentOffset.x / kViewwidth + 2014) {
                            [seletedbtn setTitleColor:[UIColor colorWithRed:0/255.0 green:153/255.0 blue:230/255.0 alpha:1] forState:UIControlStateNormal];
                        }else{
                            [seletedbtn setTitleColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
                        }
                    }
                }
                
            }
        }];

    }
}


@end
