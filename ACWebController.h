//
//  ACWebController.h
//  Newstly
//
//  Created by Adex on 04/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ACWebController : UIViewController<ADBannerViewDelegate, UIWebViewDelegate>
@property(strong, nonatomic) UIWebView * webView;

    
    
@end
