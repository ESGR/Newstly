//
//  ACHeadLine.m
//  SubViews
//
//  Created by User on 25/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACHeadLine.h"

@implementation ACHeadLine
@synthesize editing;
@synthesize headLingString = _headLingString;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setBackgroundColor:[UIColor blackColor]];
        self.headLingString = @"MY NAME IS ADEOYE I LIKE WALKING FOOD IS GOOD";
        //[self nidDisplay];
    }
    return self;
}

/*

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
#define TEXT_FONT_SIZE 24

#define MIDDLE_COLUMN_WIDTH 200
//#define MIDDLE_COLUMN_OFFSET 20

#define LEFT_COLUMN_OFFSET 10
#define RIGHT_COLUMN_OFFSET 2
    
#define LOWER_ROW_TOP 34
#define UPPER_ROW_TOP 50

    //Color and font for the HeadLine Text
    UIColor * textColor;
    UIFont  * textFont = [UIFont systemFontOfSize:TEXT_FONT_SIZE];
    // Drawing code
    textColor = [UIColor blackColor];
    
    CGRect contentRect = self.bounds;
    
    if (!self.editing) {
        CGFloat boundsX = contentRect.origin.x;
        CGPoint point;
        
        CGFloat actualFontSize;
        CGSize  size;
        
        [textColor set];
        
        
        size = [[self headLingString] sizeWithFont:textFont
                                       minFontSize:TEXT_FONT_SIZE
                                    actualFontSize:&actualFontSize
                                          forWidth:MIDDLE_COLUMN_WIDTH
                                     lineBreakMode:NSLineBreakByTruncatingTail];
        
        point = CGPointMake(boundsX + RIGHT_COLUMN_OFFSET +
                            MIDDLE_COLUMN_WIDTH - size.width, UPPER_ROW_TOP);
      
        [[self headLingString] drawAtPoint:point
                                  forWidth:MIDDLE_COLUMN_WIDTH
                                  withFont:textFont
                               minFontSize:actualFontSize
                            actualFontSize:&actualFontSize
                             lineBreakMode:NSLineBreakByTruncatingTail
                        baselineAdjustment:UIBaselineAdjustmentAlignCenters]; 
        
        
       // [[self headLingString] drawAtPoint:point withFont:textFont];
        
        
        
        
        
    }
}

*/
@end
