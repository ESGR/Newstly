//
//  HTMLParser.h
//  StackOverflow
//
//  Created by Ben Reeves on 09/03/2010.
//  Copyright 2010 Ben Reeves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/HTMLparser.h>
#import "HTMLNode.h"
@class  ACPost;

/*
@protocol NFHTMLParserDelegate <NSObject>

@required
-(void)linkHREFFromParser:(NSString *) link;
-(void)imageHREFFromParser:(NSString *) imageLink;
-(void)headLineStoryFromParser:(NSString *) headStory;
-(void)storyBodyFromParser:(NSString *) storyBody;


@end  */

@class HTMLNode;

@interface HTMLParser : NSObject 
{
	@public
	htmlDocPtr _doc;
}

-(id)initWithContentsOfURL:(NSURL*)url error:(NSError**)error;
-(id)initWithData:(NSData*)data error:(NSError**)error;
-(id)initWithString:(NSString*)string error:(NSError**)error;

//Returns the doc tag
-(HTMLNode*)doc;

//Returns the body tag
-(HTMLNode*)body;

//Returns the html tag
-(HTMLNode*)html;

//Returns the head tag
- (HTMLNode*)head;

-(BOOL)htmlParse;
-(BOOL)parsedError:(NSError *) err;
-(void)processData;
-(NSString *)imageUrlReturnUsingProcessData;

@property(nonatomic,strong)NSString * linkHREF;
@property(nonatomic,strong)NSString * linkHEADLINE;
@property(nonatomic,strong)NSString * linkIMAGE;
@property(nonatomic,strong)NSString * contentBODY;
//@property(assign)id <NFHTMLParserDelegate> delegate;
@property(nonatomic, strong) ACPost * post ;



-(id)initWithData:(NSData*)data error:(NSError**)error post:(ACPost *)post;


@end
