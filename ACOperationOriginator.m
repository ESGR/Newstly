//
//  ACOperationOriginator.m
//  Newstly
//
//  Created by Adex on 27/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACOperationOriginator.h"
#import "ACConnection.h"
#import "ACChannel.h"
#import "ACPost.h"

#import "ACChannelxml.h"
#import "ACPostxml.h"
#import "HTMLParser.h"
#import "ACOperationSorting.h"

static ACOperationOriginator * _staticOperation = nil;


NSString * SortItemsNotification = @"SortItemsNotification";
NSString * SortImageUrlNotification = @"SortImageUrlNotification";
NSString * keyPost = @"keyPost";
NSString * keyImagePost = @"keyImagePost";
NSString * keyIndexCounter = @"keyIndexCounter ";
static  NSString * _truncate;
@interface ACOperationOriginator (){
    
    NSUInteger _indexCounter;
    NSArray * recusiveArray;

}
@property ( nonatomic) NSUInteger indexCounter0;
@property ( nonatomic) NSUInteger indexCounter1;
@property (nonatomic) NSUInteger indexCounter2;


@end
@implementation ACOperationOriginator
@synthesize indexCounter0 = _indexCounter0;
@synthesize indexCounter1 = _indexCounter1;
@synthesize indexCounter2 = _indexCounter2;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize updated;
@synthesize managedObject = _managedObject;

-(id)init{
    
    self = [super init];
    
    if (self) {
        
        // For Content URL Notification Sorting
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(sortNotification:)
                                                     name:SortItemsNotification object:nil];
        // For Image URL Notification Sorting
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(imageURLSortingNotification:)
                                                     name:SortImageUrlNotification object:nil];
    }
    
    return self;
}


+(id)allocWithZone:(NSZone *)zone {
    
    return [self sharedOperationOriginator];
}

+(ACOperationOriginator *) sharedOperationOriginator
{
    
    if (_staticOperation == nil) {
        
        _staticOperation = [[super allocWithZone:nil] init];
    }
    
    return _staticOperation;
}


-(void)startFetching:(NSURLRequest *)request{
    
    dispatch_queue_t dispatchBGQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_group_t group = dispatch_group_create();
    
    void (^getFeeds)(void) = ^(void){
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
        
        
        dispatch_group_async(group, dispatchBGQueue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

            ACConnection * connection = [[ACConnection alloc] initWithRequest:request];
            
            [connection completionBlockCallBack:^(ACChannel * channel, NSError *error, NSURLResponse * response){
                
                if (!error) {
                    
                    ([self completionBlock]) (channel, nil, response);
                }else{
                    
                    ([self completionBlock]) (nil, error, response);
                    
                }
                
            }];
            
            
            
            dispatch_semaphore_signal(semaphore);
        });
        
        dispatch_group_notify(group, dispatchBGQueue, ^(void){
            
        });
        
    };
    
    
    getFeeds();
    
}

-(void)fetchChannelRequest:(NSURLRequest *)request withCompletion:(void (^)(id, NSError *, NSURLResponse * response))block
{
         
    self.completionBlock = block;
    [self startFetching:request];


}

-(void)fetchNewswith:(NSString *) stringURL;
{

    
    
    /* NSString * urlString = @"http://api.feedzilla.com/v1/categories/19/articles.json"; */
    
    
    NSURL * url = [NSURL URLWithString:stringURL];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    
    [self fetchChannelRequest:request withCompletion:^(ACChannel * channel, NSError * error, NSURLResponse * response){
        
        
        if (!error) {
        
        NSArray * posts = [channel items];
        
        for(ACPost * post in posts){
            
            NSLog(@"%@", post.link);
            _indexCounter0 ++;
            
            ACNewsItem * newsItem = [NSEntityDescription insertNewObjectForEntityForName:_managedObject  // property name : _managedObject
                                                              inManagedObjectContext:_managedObjectContext];
        
            [newsItem setXmlSourceURL:post.link];
            [newsItem setTitle:post.title];
            [newsItem setSummary:post.shortStory];
            [newsItem setPublicationDate:post.publicationDate];
        
            NSError * error = nil;
            
            BOOL success = [_managedObjectContext save:&error];
            
            if (!success) {
                
                NSLog(@"NOT SAVED");
            }else{
                
                NSLog(@"SAVING");
            }
            
            
                // Updating the Table with fetched content URL
            
            if (_indexCounter0 == [posts count]) {

               // NSLog(@"Send recursiveUpdating to self");
                [self recursiveUpdating];
            }
        }
        }else{
            
            NSLog(@"CONNECTION ONE ERROR %@", error.description);
        }
        
        
    }];

    
    
    
}

-(void)recursiveUpdating{
    
    [self sorting];
}

-(void)sorting{

    if (_indexCounter == 0) {
        
        _indexCounter = 0;
    }
    
    
    recusiveArray = [self fetchObjectTable];
   
    if (_indexCounter1 < [recusiveArray count]) {
       
        
        ACNewsItem * post = [recusiveArray objectAtIndex:_indexCounter1];
        [[NSNotificationCenter defaultCenter] postNotificationName:SortItemsNotification
                                                            object:self
                                                          userInfo:[NSDictionary dictionaryWithObject:post
                                                                                               forKey:keyPost]];
    }else{
        
        // Remove the first observer for SortItemsNotification
       // [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        /* Once finished updating : Fire again fetchNewsItemTable 
         for Fetching and passing imageData URL and Full Story */
        
        if (_indexCounter2 == 0) {
            
            //recusiveArray = nil;
            _indexCounter2 = 0;
        }
        
        recusiveArray = [self fetchObjectTable];
        
        // Set up a notification that will trigger the imageUrlSortingNotification
        
        if (_indexCounter2 < [recusiveArray count] ) {
            NSLog(@"IMAGE AT INDEX %d", _indexCounter2);
            ACNewsItem * post = [recusiveArray objectAtIndex:_indexCounter2];
            [[NSNotificationCenter defaultCenter] postNotificationName:SortImageUrlNotification
                                                                object:self
                                                              userInfo:[NSDictionary dictionaryWithObject:post
                                                                                                   forKey:keyImagePost]];
        }else{
            
            // Remove Second observer for SortImageUrlNotification
           // [[NSNotificationCenter defaultCenter] removeObserver:self];
            
            // Property named : isUpdated
            // finally set to YES once updated completly
            NSLog(@"UPDATESSSSSSSING LOL");
            [self setUpdated:YES];
            
        }
    }
    
}

-(NSArray *)fetchObjectTable{
    
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:_managedObject //property name : _managedObject
                                   inManagedObjectContext:_managedObjectContext]];
    
    NSError * error = nil;
    NSArray * result = [_managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        
        NSLog(@"Error Fetching : %@", error.description);
    }
    
    return result;
}

-(void)sortNotification:(NSNotification *) notification{
    
    __block NSRange match;
    //__block NSInteger loopCounter;
    
    ACNewsItem * post = [[notification userInfo] objectForKey:keyPost];
    _truncate = [post.title substringToIndex:MIN(24, [post.title length])];
    NSURL * url = [NSURL URLWithString:post.xmlSourceURL];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [[ACOperationSorting sharedOperationSorting] fetch2ChannelRequest:request withCompletion:^(ACChannelxml * xmlChannel, NSError * error, NSURLResponse * response){
        
        
       
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
        int code = 0;
        code = [httpResponse statusCode];
        NSLog(@"%@", httpResponse.allHeaderFields);
        
        if ([response.MIMEType isEqualToString:@"text/xml"]) {
            
            NSLog(@"SOMETHING IS WRONG HERE %d", code);
            _indexCounter1++;
            [self sorting];
        }else{
            
            
                
                NSLog(@"HAPPY %d", code);
                
        
            
            
            if (!error) {
                
                
                for(ACPostxml * xmlPost in [xmlChannel items]){
                    
                    match = [xmlPost.title rangeOfString:_truncate];
                    
                    if (match.location != NSNotFound) {
                        
                        
                        NSLog(@"%@ AND %@", xmlPost.title , _truncate);
                        
                        NSLog(@"%d", _indexCounter1);
                        
                        NSLog(@"%@", xmlPost.link);
                        
                        //Update the table here with new Content url
                        BOOL success = [self updateManagedObjects:xmlPost.link withIndex:_indexCounter1];
                        
                        if (success) {
                            
                            _indexCounter1++;
                            [self sorting];
                        }else{
                            NSLog(@"NOT UPDATING");
                            _indexCounter1++;
                            [self sorting];
                        }
                        // Recursive firing . Stopped firing once it is finished sortin
                        
                        
                    }else{
                        
                        
                        //NSLog(@"CAN NOT MATCH STRING");
                        
                        
                    }
                    
                }
            }else{
                
                NSLog(@"CONNECTION 2 ERROR %@", error.description);
                _indexCounter1++;
                [self sorting];
            }

        }
        
        
                
        
        
    }];
    
    
    
    
}

-(void)imageURLSortingNotification:(NSNotification *) notification{
    NSLog(@"FETCHING IMAGE");
    // propety named : isUpdated
    // initially set to NO, to indicate that is has not updated completly
     [self setUpdated:NO];
    
    NSLog(@"CHECKING");
    ACNewsItem * post = [[notification userInfo] objectForKey:keyImagePost];
    NSLog(@"HTML : %@", post.htmlContentURL);
    NSURL * url = [NSURL URLWithString: post.htmlContentURL];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    queue.name = @"com.image.url.connection";
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue    // Setup the NSOperation Queues
                           completionHandler:^(NSURLResponse * response, NSData * htmlData, NSError * err){
                               
                               if (response) {
                                   
                                   _indexCounter2 ++;
                                   HTMLParser * parser = [[HTMLParser alloc] initWithData:htmlData error:nil];
                                  NSString * imageURL = [parser imageUrlReturnUsingProcessData];    // Use later 
                                   NSURL * url = [NSURL URLWithString:imageURL];
                                   NSData * imageData = [NSData dataWithContentsOfURL:url];
                                   
                                   // Update the table here with imageURL
                                   
                                   ACNewsItem * newsItem = post;
                                   [newsItem setImageData:imageData];
                                   
                                   NSError * error = nil;
                                   
                                   BOOL success = [_managedObjectContext save:&error];
                                   
                                   if (!success) {
                                       
                                       NSLog(@"NOT SAVED");
                                   }else{
                                       
                                       NSLog(@"SAVING HTML URL IMAGE at index %d", _indexCounter2);
                                   }

                                   
                                   // Recursive firing . Stopped firing once it is finished sorting
                                   
                                   [self sorting];
                                   
                               }else{
                                   
                                   if (err) {
                                       
                                       NSLog(@"CONNECTION NOT WORKING %@", err.description);
                                   }
                               
                               }
                           }];
}




-(BOOL)updateManagedObjects:(NSString *) htmlurl withIndex:(NSUInteger) index{
    
    BOOL success = NO;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:_managedObject
                                   inManagedObjectContext:_managedObjectContext]];
    
    NSError * error = nil;
    NSArray * managedObjects = [_managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        
        NSLog(@"PROBLEM FECHING FOR UPDATING : %@" , error.description);
    }else{

 ACNewsItem * updateManagedObject = [managedObjects objectAtIndex:index];
    
    updateManagedObject.htmlContentURL = htmlurl;
        NSError * errorSaving = nil;
        [_managedObjectContext save:&errorSaving];
        
        if (errorSaving) {
            
            NSLog(@"ERROR UPDATE SAVING: %@", errorSaving.description);
        }else{
            
            NSLog(@"UPDATING");
            success = YES;
        }
    }
    
    return success;
}

/*

-(void)performAnotherOPeration:(NSURLRequest *) request{
    
    
    
    [[ACOperationSorting sharedOperationSorting] fetch2ChannelRequest:request
                                                       withCompletion:^(ACChannelxml * channel, NSError * error){
                                                           
                                                           
                                                           static NSString * str;
                                                           _indexCounter ++;
                                                           
                                                           for(ACPostxml * post in [channel items]) {
                                                               
                                                               str = [post.title substringToIndex:MIN(5, [post.title length])];
                                                               
                                                               if ([str isEqual: _truncate]) {
                                                                   
                                                                   
                                                                   NSLog(@"WORKINGGGGG %d AND %d", _indexCounter, [recusiveArray count]);
                                                                   NSLog(@"%@", _truncate);
                                                                   recusiveArray = [self fetchObjectTable];
                                                                   
                                                                   [self sorting];
                                                               }
                                                               
                                                               
                                                           }
                                                           
                                                           
                                                       }];

}

*/

@end
