//
//  ACCustomCell.h
//  Newstly
//
//  Created by User on 29/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACCustomCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIWebView *shortStory;
//@property (retain, nonatomic) IBOutlet UILabel *shortStory;

@property (weak, nonatomic) IBOutlet UILabel *headLine;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
