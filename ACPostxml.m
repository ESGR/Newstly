//
//  ACPostxml.m
//  Newstly
//
//  Created by Adex on 27/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACPostxml.h"

@interface ACPostxml (){
    
    NSMutableString * _currentString;
}

@end

@implementation ACPostxml


@synthesize parentDelegateParser = _parentDelegateParser;
@synthesize title = _title;
@synthesize link = _link;
@synthesize shortStory = _shortStory;
@synthesize publicationDate = _publicationDate;


#pragma mark -
#pragma mark - NSXMLParser Delegate Method

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict
{//NSLog(@"WORKING HERE 1");
    if ([elementName isEqualToString:@"title"]) {
        
        _currentString = [[NSMutableString alloc] init];
        self.title = _currentString;
        //NSLog(@"%@", self.title);
    }else if ([elementName isEqualToString:@"link"]) {
       // NSLog(@"START CONNECTION STILL WORKING");
        _currentString = [[NSMutableString alloc] init];
        self.link = _currentString;
        
    
    }else if ([elementName isEqual:@"pubDate"])
    {
        _currentString = [[NSMutableString alloc] init];
    }else if ([elementName isEqualToString:@"description"]){
        
        _currentString = [[NSMutableString alloc] init];
        [self setShortStory:_currentString];
    }

    
}

-(void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    [_currentString appendString:string];
    
}


-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqual:@"pubDate"]) {
        static NSDateFormatter *dateFormatter = nil;
        
        if (!dateFormatter) {
            
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];
        }
        
        [self setPublicationDate:[dateFormatter dateFromString:_currentString]];
    }
    
    _currentString = nil;
    if ([elementName isEqualToString:@"item"] || [elementName isEqualToString:@"entry"]) {
        
        parser.delegate = _parentDelegateParser;
    }
}


@end
