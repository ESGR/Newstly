//
//  ACJSONSerialization.h
//  WebServices
//
//  Created by Adex on 10/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ACPost;

@protocol ACJSONSerialization <NSObject>

-(void)readFromDictionary:(NSDictionary *) d;


@end
