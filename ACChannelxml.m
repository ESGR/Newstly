//
//  ACChannelxml.m
//  Newstly
//
//  Created by Adex on 27/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACChannelxml.h"
#import "ACPostxml.h"

@implementation ACChannelxml


@synthesize items = _items;
@synthesize parentParserDelegate = _parentParserDelegate;

-(id)init{
    self = [super init];
    
    if (self) {
        
        _items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark -
#pragma mark - NSXMLParser Delegate Methods

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict{

    
    
    if ([elementName isEqualToString:@"item"] || [elementName isEqualToString:@"entry"]) {
        
        ACPostxml * item = [[ACPostxml alloc] init];
        item.parentDelegateParser = self;
        parser.delegate = item;
        
        [_items addObject:item];
    }
}

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName{
    
    
    if ([elementName isEqualToString:@"channel"]) {
        
        parser.delegate = _parentParserDelegate;
    }
}

@end
