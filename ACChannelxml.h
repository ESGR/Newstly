//
//  ACChannelxml.h
//  Newstly
//
//  Created by Adex on 27/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACChannelxml : NSObject<NSXMLParserDelegate>

@property (weak, nonatomic) id parentParserDelegate;
@property (strong, readonly, nonatomic) NSMutableArray * items;

@end
