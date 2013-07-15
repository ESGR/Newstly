//
//  ACFetchNewsPost.h
//  Newstly
//
//  Created by User on 16/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ACChannelxml;

@interface ACFetchNewsPost : NSObject
@property (nonatomic,strong) void(^completionBlock)(id object, NSError * error, NSURLResponse * response);


+(ACFetchNewsPost *)sharedACFetchNewsPost;
-(void)startFetching:(NSURLRequest *)request;
-(void) fetchChannelFeeds:(NSURLRequest *)request withCompletionZero:(void (^)(ACChannelxml *, NSError * error, NSURLResponse * response))block;

@end
