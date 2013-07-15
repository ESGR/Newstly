//
//  ACPost.m
//  Newstly
//
//  Created by User on 09/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACPost.h"





@implementation ACPost
@synthesize parentParserDelegate;
@synthesize title = _title;
@synthesize shortStory = _shortStory;
@synthesize link = _link;
@synthesize publicationDate = _publicationDate;

-(void)dealloc{
    
    self.parentParserDelegate = nil;
    self.title = nil;
    self.shortStory = nil;
    self.link = nil;
    self.publicationDate = nil;
}


-(BOOL)isEqual:(id)object{
    
    if (![object isKindOfClass:[ACPost class]]) {
        return NO;
    }
    
    return [[self link] isEqual:[object link]];
}


-(void)readFromDictionary:(NSDictionary *)d{
    
    [self setTitle:[d objectForKey:@"title"]];
    [self setShortStory:[d objectForKey:@"summary"]];
    [self setPublicationDate:[d  objectForKey:@"publish_date"]];
    [self setLink:[d objectForKey:@"source_url"]];
    

}

@end
