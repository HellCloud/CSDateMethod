//
//  CSDateProcess.m
//  CSDateMethod
//
//  Created by SungHsiang Yu on 2015/2/11.
//
//

#import "CSDateProcess.h"

@implementation CSDateProcess

- (NSString *)getLocalTimeZoneCurrentDateOfThisMonth{
    NSString *currentDateofThisMonth = @"";
    
    
    
    return currentDateofThisMonth;
}
- (NSString *)getLocalTimeZoneCurrentDateOfThisWeek{
    NSString *currnetOfthisWeek = @"";
    
    return currnetOfthisWeek;
}

- (NSString *)getCurrentDateOfThisMonthWithTimeZone:(NSTimeZone*)timeZone{
    NSString *currentDateOfThisMonth = @"";
    
    return currentDateOfThisMonth;
}

- (NSString *)getCurrentDateOfThisWeekWithTimeZone:(NSTimeZone*)timeZone{
    NSString *currentDateOfthisWeek = @"";
    
    return currentDateOfthisWeek;
}

- (NSString *)getTotalDaysOfLastMonth{
    NSString *daysOfLastMonth = @"";
    
    return daysOfLastMonth;
}

#pragma mark - Date Process

- (NSArray *)getAllDateThisWeek{
    
    NSMutableArray *dateArray = [NSMutableArray new];
    
    NSDate *today = [NSDate date];
    //NSLog(@"Today date is %@",today);
    
    for (int i = 1; i <= 7; i ++) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
        [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
        NSCalendar *gregorianEnd = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *componentsEnd = [gregorianEnd components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
        
        NSInteger Enddayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:today] weekday];// this will give you current day of week
        
        [componentsEnd setDay:([componentsEnd day]+( i -Enddayofweek)+1)];// for end day of the week
        
        NSDate *EndOfWeek = [gregorianEnd dateFromComponents:componentsEnd];
        NSDateFormatter *dateFormat_End = [[NSDateFormatter alloc] init];
        [dateFormat_End setDateFormat:@"yyyyMMdd"];
        [dateFormat_End setTimeZone:[NSTimeZone systemTimeZone]];
        
        NSString *dateEndPrev = [dateFormat stringFromDate:EndOfWeek];
        
        //NSDate *weekEndPrev = [dateFormat_End dateFromString:dateEndPrev];
        
        //NSLog(@"%@",dateEndPrev);
        
        [dateArray addObject:[dateEndPrev stringByReplacingOccurrencesOfString:@"-" withString:@""]];
    }
    //DLog(@"%@", dateArray);
    return [NSArray arrayWithArray:dateArray];
    //return dateArray;
}

- (NSArray *)getAllDateThisMonth{
    
    NSMutableArray *dateArray = [NSMutableArray new];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    
    NSDate *today = [NSDate date]; //Get a date object for today's date
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSDayCalendarUnit
                                  inUnit:NSMonthCalendarUnit
                                 forDate:today];
    
    //NSLog(@"how many days in this month :%li", days.length);
    
    numberOfDaysOfThisMonth = [NSString stringWithFormat:@"%li", days.length];
    
    for (NSInteger i = 1; i <= days.length; i++) {
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:today];
        [comp setDay:i];
        NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
        //NSLog(@"Date of this month : %@", [dateFormat stringFromDate:firstDayOfMonthDate]);
        [dateArray addObject:[dateFormat stringFromDate:firstDayOfMonthDate]];
    }
    return [NSArray arrayWithArray:dateArray];
    
}

-(void) dateprocess{
    NSDate *dateToday = [NSDate date];
    NSDateFormatter *dateDayOfWeekFormatter = [NSDateFormatter new];
    //[dateDayOfWeekFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateDayOfWeekFormatter setDateFormat:@"e"];
    
    NSDateFormatter *dateDayOfMonthFormatter = [NSDateFormatter new];
    //[dateDayOfMonthFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateDayOfMonthFormatter setDateFormat:@"d"];
    
    
    dayOfWeek = [self fixDayOfWeek:[dateDayOfWeekFormatter stringFromDate:dateToday]];
    dayOfMonth = [dateDayOfMonthFormatter stringFromDate:dateToday];
    
    
    //DLog(@"今天是週 %@ , 今天是 %@ 號", dayOfWeek, dayOfMonth);
}

@end
