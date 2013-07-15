//
//  ACChannel.m
//  Newstly
//
//  Created by User on 09/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACChannel.h"
#import "ACPost.h"



@implementation ACChannel
@synthesize items = _items;
@synthesize imageUrlContainer = _imageUrlContainer;

-(void)dealloc{
    
    _items = nil;
    
    _imageUrlContainer = nil;
}

-(id)init
{
    self = [super init];
    
    if (self) {
        
        _items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)addItemsFromChannel:(ACChannel *)otherChannel{
   
    
    for (ACPost * post in [otherChannel items]){
        
        if (![[self items] containsObject:post]) {
           
            //if ([post publicationDate] == [NSDate date]) {
                
                [[self items] addObject:post];
           //}
            
        }
    }
    
    
    [[self items] sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        
        return [[obj2 publicationDate] compare:[obj1 publicationDate]];
    }];
}


-(ACChannel *)sortItemsUsingChannelWithOtherOtherChannel:(ACChannel *)otherChannel{
    
    
    for (ACPost * post in [otherChannel items]){
        
        if (![[self items] containsObject:post]) {
            
            //if ([post publicationDate] == [NSDate date]) {
            
            [[self items] addObject:post];
            //}
            
        }
    }
    
    
    [[self items] sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        
        return [[obj2 publicationDate] compare:[obj1 publicationDate]];
    }];
    
    return self;
}



-(void)readFromDictionary:(NSDictionary *)d{
    NSLog(@"WORKING HERE 2");
    NSArray * posts = [d objectForKey:@"articles"];
    
        
    
    for (NSDictionary * dictionary in posts) {
        
        ACPost * pst = [[ACPost alloc] init];
        [pst readFromDictionary:dictionary];
        
        [self.items  addObject:pst];
    }
    

        
}





@end
