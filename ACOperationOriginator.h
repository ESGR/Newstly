//
//  ACOperationOriginator.h
//  Newstly
//
//  Created by Adex on 27/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ACChannel;



@interface ACOperationOriginator : NSObject 

@property (nonatomic,strong) void(^completionBlock)(id object, NSError * error, NSURLResponse * response);
@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, getter = isUpdated) BOOL updated;
@property (nonatomic, strong) NSString * managedObject;



+(ACOperationOriginator *)sharedOperationOriginator;
-(void)fetchChannelRequest:(NSURLRequest *)request withCompletion:(void (^)(id, NSError *, NSURLResponse * response))block;
-(void)fetchNewswith:(NSString *) stringURL;
-(void)recursiveUpdating;
@end
