//
//  ACOperationSorting.m
//  Newstly
//
//  Created by Adex on 27/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACOperationSorting.h"
#import "ACConnection.h"

@implementation ACOperationSorting
@synthesize completionBlock = _completionBlock;


+(id)allocWithZone:(NSZone *)zone{
    
    return [self sharedOperationSorting];
}

+(ACOperationSorting *) sharedOperationSorting {
    
    static ACOperationSorting * _staticOperationSorting = nil;
    
    if (_staticOperationSorting == nil) {
        
        _staticOperationSorting = [[super allocWithZone:nil] init];
    }
    
    return _staticOperationSorting;
}


-(void)startFetching:(NSURLRequest *)request{
    
    dispatch_queue_t dispatchBGQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_group_t group = dispatch_group_create();
    
    void (^getFeeds)(void) = ^(void){
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
        
        
        dispatch_group_async(group, dispatchBGQueue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            ACConnection * connection = [[ACConnection alloc] initWithRequestXML:request];
            
            [connection completionBlockCallBack:^(ACChannel * channel, NSError *error, NSURLResponse * response){
                
                if (!error) {
                    
                    ([self completionBlock]) (channel, nil,response);
                }else{
                    
                    ([self completionBlock]) (nil, error,nil);
                    
                }
                
            }];
            
            
            
            dispatch_semaphore_signal(semaphore);
        });
        
        dispatch_group_notify(group, dispatchBGQueue, ^(void){
            
        });
        
    };
    
    
    getFeeds();
    
}

-(void)fetch2ChannelRequest:(NSURLRequest *)request withCompletion:(void (^)(id, NSError *, NSURLResponse * response))block
{
    
    self.completionBlock = block;
    [self startFetching:request];
    
    
}


@end
