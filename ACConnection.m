//
//  ACConnection.m
//  Newstly
//
//  Created by User on 09/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACConnection.h"
#import "ACChannel.h"
#import "ACChannelxml.h"

@interface ACConnection (){
    
    NSURLConnection *interConnection;
    NSMutableData *container;
}

@end

static NSMutableArray * holdConnection = nil;
@implementation ACConnection
@synthesize request = _request;
@synthesize completionBlock = _completionBlock;
@synthesize jsonRootObject = _jsonRootObject;
@synthesize xmlRootObject = _xmlRootObject;

-(void)dealloc{
    
    self.request = nil;
    self.completionBlock = nil;
    self.jsonRootObject = nil;
}


-(id)initWithRequest:(NSURLRequest *)req{
    self = [super init];
    if (self) {
        
        self.request = req;
        ACChannel *channel = [[ACChannel alloc] init];
        self.jsonRootObject = channel;
    }
    return self;
}


-(id)initWithRequestXML:(NSURLRequest *)req{
    
    self = [super init];
    if (self) {
        
        self.request = req;
        ACChannelxml *channel = [[ACChannelxml alloc] init];
        self.xmlRootObject = channel;
    }
    return self;
}


-(void)startConnection{
    
    container = [[NSMutableData alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        interConnection = [[NSURLConnection alloc] initWithRequest:[self request]
                                                          delegate:self
                                                  startImmediately:YES];
    });
    
    if (!holdConnection) {
        
        holdConnection = [NSMutableArray array];
    }
    
  [holdConnection addObject:self];

    
}

-(void)completionBlockCallBack:(void (^)(id obj, NSError *, NSURLResponse * response))block{
   
    self.completionBlock = block;
    [self startConnection];
    
    
}

#pragma mark - NSURLConnection Delegate
-(void)connection:(NSURLConnection *)connection
   didReceiveData:(NSData *)data{
    
    
    
    if (data) {
        [container appendData:data];
        
    }else{
        
        NSLog(@"DATA IS EMPTY");
    }
    
}

-(void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response{
    
    if (response) {
        if ([self completionBlock]) {
            
            [self completionBlock] (nil, nil, response);
        }
    }else{
        
        NSLog(@"RESPONSE IS NIL");
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
   
    id rootObject = nil;
    
    if ([self jsonRootObject]) {
        
    
    NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:container
                                                                options:0
                                                                  error:nil];
    
    [self.jsonRootObject readFromDictionary:dictionary];
        rootObject = [self jsonRootObject];
    
  }
    else if ([self xmlRootObject]){
        
        NSXMLParser * parser = [[NSXMLParser alloc] initWithData:container];
        parser.delegate = [self xmlRootObject];
        [parser parse];
        
        rootObject = [self xmlRootObject];
        
    }
    
    if ([self completionBlock]) {
        
        [self completionBlock] (rootObject, nil, nil);
    }
    
    [holdConnection removeObject:self];
}

-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error{
   
    if ([self completionBlock]) {
        
        ([self completionBlock])(nil, error, nil);
    }
    
    [holdConnection removeObject:self];
}
@end
