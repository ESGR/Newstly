//
//  CustomTableView0.h
//  CellExpander
//
//  Created by Adex on 26/05/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableView0 : UITableView

-(id)initWithClassAttribute:(NSString *) attribute;
@property(strong, nonatomic) NSString * attributeName;

@property(strong, nonatomic) UIRefreshControl * myRefresh;
@end
