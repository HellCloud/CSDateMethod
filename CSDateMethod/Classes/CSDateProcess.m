//
//  CSDateProcess.m
//  CSDateMethod
//
//  Created by Cloud Sung on 2015/2/11.
//
//

#import "CSDateProcess.h"

@implementation CSDateProcess

#pragma mark - Getter/Setter
- (NSString *)getLocalTimeZoneCurrentDateOfThisMonth{
    return [self getCurrentDateOfThisMonthWithTimeZone:[NSTimeZone systemTimeZone]];
}
- (NSString *)getLocalTimeZoneCurrentDateOfThisWeek{
    return [self getCurrentDateOfThisWeekWithTimeZone:[NSTimeZone systemTimeZone]];
}
- (NSString *)getCurrentDateOfThisMonthWithTimeZone:(NSTimeZone*)timeZone{
    return [self dateProcessWithType:CSDateTypeThisMonth TimeZone:timeZone];
}
- (NSString *)getCurrentDateOfThisWeekWithTimeZone:(NSTimeZone*)timeZone{
    return [self dateProcessWithType:CSDateTypeThisWeek TimeZone:timeZone];
}
- (NSArray *)getAllDateInThisMonth{
    return [self getAllDateInThisMonthWithTimeZone:[NSTimeZone systemTimeZone]];
}
- (NSArray *)getAllDateInThisWeek{
    return [self getAllDateInThisWeekTimeZone:[NSTimeZone systemTimeZone]];
}
- (NSArray *)getAllDateInThisMonthWithTimeZone:(NSTimeZone *)timeZone{
    return [self getAllDateThisMonthWithTimeZone:timeZone];
}
- (NSArray *)getAllDateInThisWeekTimeZone:(NSTimeZone *)timeZone{
    return [self getAllDateThisWeekWithTimeZone:timeZone];
}
- (NSArray *)getAllDateInLastMonth{
    return [self getAllDateLastMonthWithTimeZone:[NSTimeZone systemTimeZone]];
}
- (NSString *)getTotalDaysOfLastMonth{
    return [NSString stringWithFormat:@"%lu", (unsigned long)[[self getAllDateLastMonthWithTimeZone:[NSTimeZone systemTimeZone]] count]];
}
- (NSString *)getTotalDaysOfThisMonth{
    return [NSString stringWithFormat:@"%lu", (unsigned long)[[self getAllDateInThisMonth] count]];
}
- (NSArray *)getAllDateInLastWeek{
    return [self getAllDateLastWeekWithTimeZone:[NSTimeZone systemTimeZone]];
}



#pragma mark - Date Process

- (NSArray *)getAllDateThisWeekWithTimeZone:(NSTimeZone*)timezone{
    
    NSMutableArray *dateArray = [NSMutableArray new];
    
    NSDate *today = [NSDate date];
    
    for (int i = 1; i <= 7; i ++) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
        [dateFormat setTimeZone:timezone];
        NSCalendar *gregorianEnd = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *componentsEnd = [gregorianEnd components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
        
        NSInteger Enddayofweek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:today] weekday];// this will give you current day of week
        
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
    //NSLog(@"%@", dateArray);
    return [NSArray arrayWithArray:dateArray];
}

- (NSArray *)getAllDateLastWeekWithTimeZone:(NSTimeZone*)timezone{
    
    NSMutableArray *dateArray = [NSMutableArray new];
    
    NSDate *today = [NSDate date];
    NSDateComponents* dateComponents = [[NSDateComponents alloc]init];
    [dateComponents setWeekday:-7];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    today = [calendar dateByAddingComponents:dateComponents toDate:today options:0];
    
    
    for (int i = 1; i <= 7; i ++) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
        [dateFormat setTimeZone:timezone];
        NSCalendar *gregorianEnd = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *componentsEnd = [gregorianEnd components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
        
        NSInteger Enddayofweek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:today] weekday];// this will give you current day of week
        
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
    //NSLog(@"%@", dateArray);
    return [NSArray arrayWithArray:dateArray];
}


- (NSArray *)getAllDateThisMonthWithTimeZone:(NSTimeZone *)timezone{
    
    NSMutableArray *dateArray = [NSMutableArray new];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    [dateFormat setTimeZone:timezone];
    
    NSDate *today = [NSDate date]; //Get a date object for today's date
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay
                                  inUnit:NSCalendarUnitMonth
                                 forDate:today];
    
    //numberOfDaysOfThisMonth = [NSString stringWithFormat:@"%li", days.length];
    
    for (NSInteger i = 1; i <= days.length; i++) {
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comp = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:today];
        [comp setDay:i];
        NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
        //NSLog(@"Date of this month : %@", [dateFormat stringFromDate:firstDayOfMonthDate]);
        [dateArray addObject:[dateFormat stringFromDate:firstDayOfMonthDate]];
    }
    
    //NSLog(@"%@", dateArray);
    
    return [NSArray arrayWithArray:dateArray];
    
}

- (NSArray *)getAllDateLastMonthWithTimeZone:(NSTimeZone *)timeZone{
    NSMutableArray *dateArray = [NSMutableArray new];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    [dateFormat setTimeZone:timeZone];
    
    NSDate *today = [NSDate date]; //Get a date object for today's date
    NSDateComponents* dateComponents = [[NSDateComponents alloc]init];
    [dateComponents setMonth:-1];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    today = [calendar dateByAddingComponents:dateComponents toDate:today options:0];
    
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay
                                  inUnit:NSCalendarUnitMonth
                                 forDate:today];
    

    for (NSInteger i = 1; i <= days.length; i++) {
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comp = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:today];
        
        [comp setDay:i];
        
        NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
        
        [dateArray addObject:[dateFormat stringFromDate:firstDayOfMonthDate]];
    }
    
   // NSLog(@"%@", dateArray);
    
    return [NSArray arrayWithArray:dateArray];
}

- (NSString *)dateProcessWithType:(CSDateType)type TimeZone:(NSTimeZone *)timeZone{
    NSDate *dateToday = [NSDate date];
    NSString *returnString;
    
    switch (type) {
        case CSDateTypeThisWeek:{
            NSDateFormatter *dateDayOfWeekFormatter = [NSDateFormatter new];
            [dateDayOfWeekFormatter setDateFormat:@"e"];
            [dateDayOfWeekFormatter setTimeZone:timeZone];
            
            returnString = [self fixDayOfWeek:[dateDayOfWeekFormatter stringFromDate:dateToday]];
        }break;
            
        case CSDateTypeThisMonth:{
            NSDateFormatter *dateDayOfMonthFormatter = [NSDateFormatter new];
            [dateDayOfMonthFormatter setDateFormat:@"d"];
            [dateDayOfMonthFormatter setTimeZone:timeZone];
            
            returnString = [dateDayOfMonthFormatter stringFromDate:dateToday];
        }break;
            
        case CSDateTypeLastWeek:{
            returnString = @"not ready yet";
        }break;
            
        case CSDateTypeLastMonth:{
            returnString = @"not ready yet";
        }break;
        default:
            return nil;
            break;
    }
    return returnString;
}

- (NSString *)fixDayOfWeek:(NSString *)weekdayString{
    if ([weekdayString integerValue] == 1) {
        weekdayString = @"7";
    }else{
        weekdayString = [NSString stringWithFormat:@"%li", [weekdayString integerValue] - 1];
    }
    return weekdayString;
}

@end
