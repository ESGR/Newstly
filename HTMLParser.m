//
//  HTMLParser.m
//  StackOverflow
//
//  Created by Ben Reeves on 09/03/2010.
//  Copyright 2010 Ben Reeves. All rights reserved.
//

#import "HTMLParser.h"
#import "HTMLNode.h"
#import "ACPost.h"

@implementation HTMLParser
@synthesize linkHREF,linkHEADLINE,linkIMAGE,contentBODY;
//@synthesize delegate = _delegate;
@synthesize post;

-(HTMLNode*)doc
{
	if (_doc == NULL)
		return NULL;
	
	return [[HTMLNode alloc] initWithXMLNode:(xmlNode*)_doc];
}

-(HTMLNode*)html
{
	if (_doc == NULL)
		return NULL;
	
	return [[self doc] findChildTag:@"html"];
}

-(HTMLNode*)head
{
	if (_doc == NULL)
		return NULL;

	return [[self doc] findChildTag:@"head"];
}

-(HTMLNode*)body
{
	if (_doc == NULL)
		return NULL;
	
	return [[self doc] findChildTag:@"body"];
}

-(id)initWithString:(NSString*)string error:(NSError**)error
{ 
	if (self = [super init])
	{
		_doc = NULL;
		
		if ([string length] > 0)
		{
			CFStringEncoding cfenc = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
			CFStringRef cfencstr = CFStringConvertEncodingToIANACharSetName(cfenc);
			const char *enc = CFStringGetCStringPtr(cfencstr, 0);
			// _doc = htmlParseDoc((xmlChar*)[string UTF8String], enc);
			int optionsHtml = HTML_PARSE_RECOVER;
			optionsHtml = optionsHtml | HTML_PARSE_NOERROR; //Uncomment this to see HTML errors
			optionsHtml = optionsHtml | HTML_PARSE_NOWARNING;
			_doc = htmlReadDoc ((xmlChar*)[string UTF8String], NULL, enc, optionsHtml);
		}
		else 
		{
			if (error) {
				*error = [NSError errorWithDomain:@"HTMLParserdomain" code:1 userInfo:nil];
               
                [self parsedError:*error];
			}
		}
	}
	
	return self;
}


-(id)initWithData:(NSData*)data error:(NSError**)error
{
	if (self = [super init])
	{
		
        
        _doc = NULL;
        
		if (data)
		{
			CFStringEncoding cfenc = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
			CFStringRef cfencstr = CFStringConvertEncodingToIANACharSetName(cfenc);
			const char *enc = CFStringGetCStringPtr(cfencstr, 0);
			//_doc = htmlParseDoc((xmlChar*)[data bytes], enc);
			
			_doc = htmlReadDoc((xmlChar*)[data bytes],
                               "",
                               enc,
                               XML_PARSE_NOERROR | XML_PARSE_NOWARNING);
            
            
           
		}
		else
		{
			if (error)
			{
				*error = [NSError errorWithDomain:@"HTMLParserdomain" code:1 userInfo:nil];
                [self parsedError:*error];
			}
            
		}
        
        
	}
	
	return self;
}

-(id)initWithData:(NSData *)data error:(NSError *__autoreleasing *)error post:(ACPost *) _post{
    
    if (self = [super init])
	{
		
        
        _doc = NULL;
        
		if (data)
		{
			CFStringEncoding cfenc = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
			CFStringRef cfencstr = CFStringConvertEncodingToIANACharSetName(cfenc);
			const char *enc = CFStringGetCStringPtr(cfencstr, 0);
			//_doc = htmlParseDoc((xmlChar*)[data bytes], enc);
			
			_doc = htmlReadDoc((xmlChar*)[data bytes],
                               "",
                               enc,
                               XML_PARSE_NOERROR | XML_PARSE_NOWARNING);
            
            
            self.post = _post;
            
		}
		else
		{
			if (error)
			{
				*error = [NSError errorWithDomain:@"HTMLParserdomain" code:1 userInfo:nil];
                [self parsedError:*error];
			}
            
		}
        
        
	}
	
	return self;

}

-(BOOL )parsedError:(NSError *)err{
    
    if (!err) {
        
        return NO;
    }
    
    return YES;
}

-(BOOL)htmlParse{
    
    NSError * error = nil;
    
    if ([self parsedError:error]) {
        
        return NO;
    }
    
    return YES;
}

-(void)processData{
    
    
    
    HTMLNode *head = [self head];
    NSArray *metaTags = [head findChildTags:@"meta"];
    
    for (HTMLNode *meta in metaTags){
        
        
        NSString *property = [meta getAttributeNamed:@"property"];
        
       
        
        if ([property isEqualToString:@"url"]) {
            
            NSString *hrefContent = [meta getAttributeNamed:@"content"];
            
            
                self.linkHREF = hrefContent;
           
        }else if ([property isEqualToString:@"headline"]){
            
            NSString *headline = [meta getAttributeNamed:@"content"];
            
            self.linkHEADLINE = headline;
            
        }else if ([property isEqualToString:@"og:image"]){
            
            NSString *thumbnailURL = [meta getAttributeNamed:@"content"];
            
            self.linkIMAGE = thumbnailURL;
            
            NSLog(@"GOOD %@", thumbnailURL);
        }
        
    }
   
    /*
    HTMLNode *body = [self body];
    NSArray *paragraphTags = [body findChildTags:@"p"];
    
    NSMutableString *storyCon = [[NSMutableString alloc] init];
    
    for (HTMLNode * paragraph in paragraphTags){
        
        NSString *class = [paragraph getAttributeNamed:@"class"];
        NSRange storyParaTest = [[class lowercaseString] rangeOfString:@"cnn_storypgraphtxt "];
        
        if ( (storyParaTest.location != NSNotFound) && (class !=nil) ) {
            
            [storyCon appendString:paragraph.rawContents];
            
            self.contentBODY = storyCon;
        }
        
    }
    
    */
}

-(NSString *) imageUrlReturnUsingProcessData{
    
    NSString * imageUrl ;
    
    HTMLNode *head = [self head];
    NSArray *metaTags = [head findChildTags:@"meta"];
    
    for (HTMLNode *meta in metaTags){
        
        
        NSString *property = [meta getAttributeNamed:@"property"];

        
        if ([property isEqualToString:@"og:image"]){
            
           imageUrl = [meta getAttributeNamed:@"content"];

            NSLog(@"GOOD %@", imageUrl);
        }
        
    }
    
    return imageUrl;
}




-(id)initWithContentsOfURL:(NSURL*)url error:(NSError**)error
{
	
	NSData * _data = [[NSData alloc] initWithContentsOfURL:url options:0 error:error];

	if (_data == nil || *error)
	{
		//[_data release];
		return nil;
	}
	
	self = [self initWithData:_data error:error];
	
	//[_data release];
	
	return self;
}


-(void)dealloc
{
	if (_doc)
	{
		xmlFreeDoc(_doc);
	}
	
	//[super dealloc];
}

@end
