//
//  ACWebController.m
//  Newstly
//
//  Created by Adex on 04/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACWebController.h"

@interface ACWebController ()
{
    ADBannerView * _adBanner;
    UIActivityIndicatorView *aiView;
}


@end

@implementation ACWebController
@synthesize webView = _webView;



-(void)dealloc{
    
    self.webView = nil;
}

-(id)init
{
    self = [super init];
    
    if (self) {
        
        
        _adBanner = [[ADBannerView alloc] init];
        [_adBanner setDelegate:self];
    }
    
    return self;
}



-(void)loadView
{
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    UIWebView *wv = [[UIWebView alloc] initWithFrame:screenFrame];
    wv.delegate = self;
    [wv setScalesPageToFit:YES];
    [self setView:wv];
}

-(UIWebView *)webView
{
    return (UIWebView *) [self view];
}




-(void)layoutAnimated:(BOOL)animated
{
    
    CGRect contentFrame = self.webView.bounds;
    CGRect bannerFrame = _adBanner.frame;
    
    if (_adBanner.bannerLoaded) {
        
        contentFrame.size.height -= _adBanner.frame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
    }else{
        bannerFrame.origin.y = contentFrame.size.height;
        
    }
    
    _webView.frame = contentFrame;
    [_webView layoutIfNeeded];
    _adBanner.frame = bannerFrame;
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                            target:self
                                                                            action:@selector(refresh:)];
    [self navigationItem].rightBarButtonItem = button;
    
    aiView = [[UIActivityIndicatorView alloc]
              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [[self navigationItem] setTitleView:aiView];
    [aiView startAnimating];
   
    
    [[self view] addSubview:_adBanner];
}

-(void)refresh:(id)sender{
    
    [self.webView reload];

    [aiView startAnimating];

}

-(void)viewDidDisappear:(BOOL)animated
{
    [self layoutAnimated:NO];
}



#pragma mark - AdBanner Delegate Merthod

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self layoutAnimated:YES];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self layoutAnimated:YES];
}

-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    
    BOOL soTrue = willLeave;
    return soTrue;
}

#pragma mark - 
#pragma mark - UIWEB Delegates Methods



-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    if (!webView.loading) {
        
        UIView * view = [[self navigationItem] titleView];
        [aiView stopAnimating];
        [aiView setHidesWhenStopped:YES];
        [[self navigationItem] setTitleView:view];
       
    }
}

@end
