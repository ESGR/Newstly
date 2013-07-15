//
//  ACOperationSorting.h
//  Newstly
//
//  Created by Adex on 27/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACOperationSorting : NSObject

@property (nonatomic,strong) void(^completionBlock)(id object, NSError * error, NSURLResponse * response);

+(ACOperationSorting *) sharedOperationSorting;
-(void)fetch2ChannelRequest:(NSURLRequest *)request withCompletion:(void (^)(id, NSError *, NSURLResponse * response))block;
@end

