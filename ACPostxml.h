//
//  ACPostxml.h
//  Newstly
//
//  Created by Adex on 27/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACPostxml : NSObject <NSXMLParserDelegate>

@property (weak, nonatomic) id parentDelegateParser;
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * link;
@property (nonatomic, strong) NSString * shortStory;
@property (nonatomic, strong) NSDate *publicationDate;

@end
