//
//  NSDateFormatter+ACAdditionFormatter.m
//  Newstly
//
//  Created by User on 19/04/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "NSDateFormatter+ACAdditionFormatter.h"

@implementation NSDateFormatter (ACAdditionFormatter)

/*
+(NSDate *)acXGetDateFromDateString:(NSString *)dateString{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    return [formatter  dateFromString:dateString];
}

*/

+(NSString *)acXGetStringFromDate:(NSDate *)date{
    
    NSLog(@"%@", date);
    
    // Format the Date Here....
    NSCalendar *gregorianCalendar;
   // NSDate *datePostedTime;
    NSString *stringPostedTime;
    
    if (!gregorianCalendar) {
        gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
         NSInteger flag = (NSMonthCalendarUnit|NSWeekdayCalendarUnit|NSYearCalendarUnit);
         NSDateComponents *timeComponent = [gregorianCalendar components:flag fromDate:date];
   
    
       /* NSDateComponents *userTimeComponent = [[NSDateComponents alloc] init]; */
        NSInteger day =[timeComponent day];
         NSInteger month =[timeComponent month];
        NSInteger year = [timeComponent year];
        
        stringPostedTime = [NSString stringWithFormat:@"%d.%d.%d", day, month, year];
        
    /*
        datePostedTime = [gregorianCalendar dateFromComponents:userTimeComponent]; */
    
    }
    
   /*
    NSDateFormatter *timePostFormatter = [[NSDateFormatter alloc] init];
    [timePostFormatter setDateFormat:@"EEE dd MMM"];
    
    
    NSString *stringPostedTime = [timePostFormatter stringFromDate:datePostedTime]; */
    
    
    return stringPostedTime;
}


+(NSString *)dayNameByFormattingDate:(NSDate *) date{
    
   
    NSString *stringPostedTime = [NSDateFormatter acXGetStringFromDate:date];

  /*  NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSTimeInterval secondsForTwoDays = secondsPerDay * 2 ;
    
    
    
    NSString *dayName;
    NSDate *today = [[NSDate date] dateByAddingTimeInterval:secondsPerDay];
    NSDate *yesterDay = [[NSDate date] dateByAddingTimeInterval:-secondsPerDay];
    NSDate *yestofYestDay = [[NSDate date] dateByAddingTimeInterval:-secondsForTwoDays];
    
    if (today == date) {
        
        dayName = [NSString stringWithFormat:@"Post since %@", stringPostedTime];
    }
    else if (yesterDay == date){
        
        dayName = @"Post since yesterday";
        
    }else if (yestofYestDay == date){
        
        dayName = @"Post since 2 days ago";
    }
    */
    
  return stringPostedTime;
}






@end

