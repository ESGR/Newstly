//
//  ACChannel.h
//  Newstly
//
//  Created by User on 09/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACJSONSerialization.h"

@class ACPost;
@interface ACChannel : NSObject<ACJSONSerialization>


@property (nonatomic, readonly, strong) NSMutableArray *items;
@property (nonatomic, readonly, strong) NSMutableDictionary *imageUrlContainer;
-(void)addItemsFromChannel:(ACChannel *)otherChannel;

-(ACChannel *)sortItemsUsingChannelWithOtherOtherChannel:(ACChannel *)otherChannel;

@end


