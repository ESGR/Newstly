//
//  ACFeedManager.h
//  Newstly
//
//  Created by Adex on 29/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACFeedManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property(nonatomic, getter = isCompleted) BOOL completed;

-(void)initialFetchingWith:(NSString *)stringURL withManagedObject:(NSString *) managedObject;
-(NSArray *)finalFetchManagedObject:(NSString *) managedObject;

@end
