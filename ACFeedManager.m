//
//  ACFeedManager.m
//  Newstly
//
//  Created by Adex on 29/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACFeedManager.h"
#import "ACOperationOriginator.h"
#import "ACAppDelegate.h"

@interface ACFeedManager ()


@end

@implementation ACFeedManager
@synthesize completed;
@synthesize managedObjectContext = _managedObjectContext;

-(void)initialFetchingWith:(NSString *)stringURL withManagedObject:(NSString *) managedObject{
    
    [[self managedObjectContext] deletedObjects];
    [self setCompleted:NO];
    
    //ACAppDelegate * appDelegate = [[ACAppDelegate alloc] init];
    ACOperationOriginator * operationOriginator = [ACOperationOriginator sharedOperationOriginator];
    [operationOriginator setManagedObjectContext:self.managedObjectContext];
    [operationOriginator setManagedObject:managedObject];
    [operationOriginator fetchNewswith:stringURL];
    BOOL success = [operationOriginator isUpdated];
    
    if (success) {
        NSLog(@"MANAGER UPDATE COMPLETED");
        [self setCompleted:success];
    }
}

-(NSArray *)finalFetchManagedObject:(NSString *)managedObject {
    
    NSFetchRequest * request = [[NSFetchRequest  alloc] init];
    [request setEntity:[NSEntityDescription entityForName:managedObject
                                   inManagedObjectContext:_managedObjectContext]];
    
    NSError * error = nil;
    NSArray * result = [_managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        
        NSLog(@"Error Fetching From Feed Maneger : %@", error.description);
    }else{
        
        NSLog(@"Fetching From Feed Manager");
    }
    
    return result;
}










@end
