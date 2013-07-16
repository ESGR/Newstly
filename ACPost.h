//
//  ACPost.h
//  Newstly
//
//  Created by User on 09/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACJSONSerialization.h"

@interface ACPost : NSObject< ACJSONSerialization>
{
    NSMutableString *currentString;
}

@property (nonatomic, weak) id parentParserDelegate;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * shortStory;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) NSString *publicationDate;


@end
