//
//  ACAbstractItem.h
//  Newstly
//
//  Created by Adex on 28/06/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ACAbstractItem : NSManagedObject

@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * publicationDate;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSData * sourceLogo;
@property (nonatomic, retain) NSString * xmlSourceURL;
@property (nonatomic, retain) NSString * contentStory;
@property (nonatomic, retain) NSString * htmlContentURL;

@end
