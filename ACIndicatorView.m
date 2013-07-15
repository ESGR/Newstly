//
//  ACIndicatorView.m
//  Newstly
//
//  Created by Adex on 11/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACIndicatorView.h"

@implementation ACIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self indicator];
    }
    return self;
}

-(void)indicator{
    
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc]
                                           initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(self.frame.size.width/2, self.frame.size.height/2,
                                 self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:indicator];
    [indicator startAnimating];
}

@end
