//
//  ACViewController.h
//  CellExpander
//
//  Created by Adex on 25/05/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTableView;
@class CustomTableView0;
@class CustomSubCatTableView;

@class ACFeedTableViewController;


@interface ACViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CustomTableView * myCategoryTableView;
@property (nonatomic, strong) CustomTableView0 * myFeedTableView;
@property (nonatomic, strong) CustomSubCatTableView * mySubCategoryTableView;
@property (nonatomic, copy) NSURLRequest * request;


@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@end
