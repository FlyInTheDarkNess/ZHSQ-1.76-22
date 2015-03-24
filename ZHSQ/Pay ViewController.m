//
//  Pay ViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-23.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "Pay ViewController.h"
#import "AXHVendors.h"
extern NSString *Payment_url;
extern NSString *SheQuFuWu_Title;
@interface Pay_ViewController (){
    UIWebView *WebView_;
    //网络地址
    NSString *webUrl;
}


@end

@implementation Pay_ViewController

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
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    imageview.image=[UIImage imageNamed:@"nav.png"];
    [self.view addSubview:imageview];
    UILabel *label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label_title.text=SheQuFuWu_Title;
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.textColor=[UIColor whiteColor];
    [self.view addSubview:label_title];
    UIButton *fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui setImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    [self.view addSubview:[self lTHelpWebView]];
}
-(void)fanhui
{
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(UIWebView *)lTHelpWebView{
    if (!WebView_) {
        WebView_ = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, 320, self.view.frame.size.height-60)];
        
        WebView_.backgroundColor = [UIColor clearColor];
        WebView_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        WebView_.suppressesIncrementalRendering = YES;
        WebView_.scalesPageToFit = YES;
        WebView_.dataDetectorTypes = UIDataDetectorTypeAll;
        WebView_.delegate = self;
        NSURL *url =[NSURL URLWithString:Payment_url];
        NSURLRequest *request =[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0];
        [WebView_ loadRequest:request];
    }
    return WebView_;
}
#pragma mark -WebView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeNone];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.URL.absoluteString);
    if ([request.URL.absoluteString isEqualToString:@"kjkjzc://"])
    {
//        [self returnBackMethod];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您已缴费成功，请返回" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
        
    }
    
    return YES;
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
