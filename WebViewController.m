//
//  WebViewController.m
//  Feed
//
//  Created by Yongjia Liu on 14-5-25.
//  Copyright (c) 2014年 Yongjia Liu. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController
-(void)loadView
{
    CGRect screenFrame=[[UIScreen mainScreen] applicationFrame];
    UIWebView *wv=[[UIWebView alloc] initWithFrame:screenFrame];
    [wv setScalesPageToFit:YES];
    [self setView:wv];
    wv=nil;
}
-(UIWebView *)webView
{
    return (UIWebView *)[self view];
}
@end
