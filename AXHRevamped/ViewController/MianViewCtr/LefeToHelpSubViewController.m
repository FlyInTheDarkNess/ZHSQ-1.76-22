//
//  LefeToHelpSubViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/17.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "LefeToHelpSubViewController.h"
#import "AXHVendors.h"
@interface LefeToHelpSubViewController (){
    UIWebView *WebView_;
    //网络地址
    NSString *webUrl;
}
@end

@implementation LefeToHelpSubViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withUrl:(NSString *)url withTitle:(NSString *)title
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        webUrl = url;
        self.navigationItem.title = title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil withColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    [self.view addSubview:[self lTHelpWebView]];
}
-(void)backUpper{
     [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIWebView *)lTHelpWebView{
    if (!WebView_) {
        WebView_ = [[UIWebView alloc]initWithFrame:self.view.frame];
   
        WebView_.backgroundColor = [UIColor clearColor];
        WebView_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        WebView_.suppressesIncrementalRendering = YES;
        WebView_.scalesPageToFit = YES;
        WebView_.dataDetectorTypes = UIDataDetectorTypeAll;
        WebView_.delegate = self;
        NSURL *url =[NSURL URLWithString:webUrl];
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
