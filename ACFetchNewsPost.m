//
//  ACFetchNewsPost.m
//  Newstly
//
//  Created by User on 16/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACFetchNewsPost.h"
#import "ACConnection.h"
#import "ACChannelxml.h"




@interface ACFetchNewsPost (){
    dispatch_queue_t  _feedQueue;
    dispatch_source_t _sourceTimer;
}

@end
@implementation ACFetchNewsPost
@synthesize completionBlock = _completionBlock;
//@synthesize completionBlockOne = _completionBlockOne;

-(void)dealloc{
    
    self.completionBlock = nil;
}

+(id)allocWithZone:(NSZone *)zone{
    
    return [self sharedACFetchNewsPost];
}

+(ACFetchNewsPost *)sharedACFetchNewsPost{
    static ACFetchNewsPost *fetchNewsPost;
    if (!fetchNewsPost) {
        
        fetchNewsPost = [[super allocWithZone:nil] init];
    }
    
    return fetchNewsPost;
}
-(void)startFetching:(NSURLRequest *)request{
    
    dispatch_queue_t dispatchBGQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_group_t group = dispatch_group_create();
    
    void (^getFeeds)(void) = ^(void){
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
        

            dispatch_group_async(group, dispatchBGQueue, ^{
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

               
                ACConnection * connection = [[ACConnection alloc] initWithRequestXML:request];
                
                [connection completionBlockCallBack:^(ACChannelxml * channel, NSError *error, NSURLResponse * response){
   
                    
                    if (!error) {
                        
                        ([self completionBlock]) (channel, nil, response);
                    }else{
                        
                        ([self completionBlock]) (nil, error, response);
                        
                    }
                                        
                }];  
                
             
                
                dispatch_semaphore_signal(semaphore);
            });
            

        
        dispatch_group_notify(group, dispatchBGQueue, ^(void){
            
            /* dispatch_async(dispatch_get_main_queue(), ^(void){
             [[feedTableController tableView] reloadData];
             }); */
            
            /*When Fetching is completed */
            NSLog(@"Fetch Group Completed");
        });
        
    };
    
    
    getFeeds();

}




-(void) fetchChannelFeeds:(NSURLRequest *)request   withCompletionZero:(void (^)(ACChannelxml *, NSError *, NSURLResponse * response))block{
    
   
    
    self.completionBlock = block;
    [self startFetching:request];
    
   
    
}



@end
