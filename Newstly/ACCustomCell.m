//
//  ACCustomCell.m
//  Newstly
//
//  Created by User on 29/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACCustomCell.h"

@implementation ACCustomCell
@synthesize shortStory, headLine, dateLabel;

-(void)dealloc{
    
    self.shortStory = nil;
    self.headLine = nil;
    self.dateLabel = nil;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
    
    [super setBackgroundColor:backgroundColor];
    headLine.backgroundColor = backgroundColor;
    dateLabel.backgroundColor = backgroundColor;
    shortStory.backgroundColor = backgroundColor;

}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
