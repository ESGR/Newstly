//
//  CustomTableView0.m
//  CellExpander
//
//  Created by Adex on 26/05/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "CustomTableView0.h"


@interface CustomTableView0 ()

@end

@implementation CustomTableView0
@synthesize attributeName;
@synthesize myRefresh = _myRefresh;


-(id)initWithClassAttribute:(NSString *)attribute{
    
    self = [super init];
    if (self) {
        
        self.attributeName = attribute;
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    
    self= [super initWithFrame:frame];
    
    if (self) {
        
        
        
    }
    return self;
}















@end
