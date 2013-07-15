//
//  NSDateFormatter+ACAdditionFormatter.h
//  Newstly
//
//  Created by User on 19/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (ACAdditionFormatter)

//+(NSDate *)acXGetDateFromDateString:(NSString *) dateString;
+(NSString *)acXGetStringFromDate:(NSDate *) date;
+(NSString *)dayNameByFormattingDate:(NSDate *) date;
@end
