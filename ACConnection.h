//
//  ACConnection.h
//  Newstly
//
//  Created by User on 09/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ACChannel;
@class ACChannelxml;
@interface ACConnection : NSObject<NSURLConnectionDataDelegate, NSURLConnectionDelegate>


-(id)initWithRequest:(NSURLRequest *) req;
-(id)initWithRequestXML:(NSURLRequest *)req;

@property (nonatomic,strong) NSURLRequest * request;
@property (nonatomic,copy) void(^completionBlock)(id obj, NSError * error, NSURLResponse * response);
@property (nonatomic, strong)  ACChannel * jsonRootObject;
@property (nonatomic, strong)  id <NSXMLParserDelegate > xmlRootObject;


-(void)startConnection;
-(void)completionBlockCallBack:(void(^)(id object, NSError *error, NSURLResponse * response)) block;


@end
