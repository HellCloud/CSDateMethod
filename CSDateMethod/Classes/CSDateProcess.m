//
//  CSDateProcess.m
//  CSDateMethod
//
//  Created by Cloud Sung on 2015/2/11.
//
//

#import "CSDateProcess.h"

@implementation CSDateProcess



#pragma mark - Singleton / SharedInstance

+ (CSDateProcess *)sharedInstance{
    
    static CSDateProcess *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CSDateProcess alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}


//static CSDateProcess *_CSDateProcess = nil;
//
//+ (CSDateProcess *)sharedInstance{
//    
//    @synchronized([CSDateProcess class]) {
//        
//        //判斷_singletonObject是否完成記憶體配置
//        if (!_CSDateProcess){
//            [self new];
//        }
//        
//        return _CSDateProcess;
//    }
//    return nil;
//}
//
//+ (id)alloc {
//    @synchronized([CSDateProcess class]) {
//        
//        //避免 [SingletonObject alloc] 方法被濫用
//        NSAssert(_CSDateProcess == nil, @"_singletonObject 已經做過記憶體配置");
//        _CSDateProcess = [super alloc];
//        
//        return _CSDateProcess;
//    }
//    
//    return nil;
//}

#pragma mark - Getter/Setter
#pragma mark Day Today
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

#pragma mark All MonthDays
- (NSArray *)getAllDateInThisMonth{
    return [self getAllDateInThisMonthWithTimeZone:[NSTimeZone systemTimeZone]];
}
- (NSArray *)getAllDateInLastMonth{
    return [self getAllDateInLastMonthWithTimeZone:[NSTimeZone systemTimeZone]];
}
- (NSArray *)getAllDateInThisMonthWithTimeZone:(NSTimeZone *)timeZone{
    return [self getMonthDaysByType:CSDateTypeThisMonth WithTimeZone:timeZone];
}
- (NSArray *)getAllDateInLastMonthWithTimeZone:(NSTimeZone *)timeZone{
    return [self getMonthDaysByType:CSDateTypeLastMonth WithTimeZone:timeZone];
}

#pragma mark All WeekDays
- (NSArray *)getAllDateInThisWeek{
    return [self getAllDateInThisWeekTimeZone:[NSTimeZone systemTimeZone]];
}
- (NSArray *)getAllDateInLastWeek{
    return [self getAllDateInLastWeekTimeZone:[NSTimeZone systemTimeZone]];
}
- (NSArray *)getAllDateInThisWeekTimeZone:(NSTimeZone *)timeZone{
    return [self getWeekDaysByType:CSDateTypeThisWeek WithTimeZone:timeZone];
}
- (NSArray *)getAllDateInLastWeekTimeZone:(NSTimeZone *)timeZone{
    return [self getWeekDaysByType:CSDateTypeLastWeek WithTimeZone:timeZone];
}

#pragma mark How many days
- (NSString *)getTotalDaysOfLastMonth{
    return [NSString stringWithFormat:@"%lu", (unsigned long)[[self getAllDateInLastMonth] count]];
}
- (NSString *)getTotalDaysOfThisMonth{
    return [NSString stringWithFormat:@"%lu", (unsigned long)[[self getAllDateInThisMonth] count]];
}

#pragma mark - Date Process
#pragma mark Week Process

- (NSArray *)getWeekDaysByType:(CSDateType)type WithTimeZone:(NSTimeZone*)timezone{
    NSMutableArray *dateArray = [NSMutableArray new];
    
    NSDate *today = [NSDate date];
    
    if (type == CSDateTypeLastWeek) {
        NSDateComponents* dateComponents = [[NSDateComponents alloc]init];
        [dateComponents setWeekday:-7];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        today = [calendar dateByAddingComponents:dateComponents toDate:today options:0];
    }else if (type == CSDateTypeThisMonth || type == CSDateTypeLastMonth){
        return @[@"Input Error"];
    }
    
    for (int i = 1; i <= 7; i ++) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        [dateFormat setTimeZone:timezone];
        NSCalendar *gregorianEnd = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *componentsEnd = [gregorianEnd components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
        NSInteger Enddayofweek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:today] weekday];
        [componentsEnd setDay:([componentsEnd day]+( i -Enddayofweek)+1)];
        NSDate *EndOfWeek = [gregorianEnd dateFromComponents:componentsEnd];
        NSDateFormatter *dateFormat_End = [[NSDateFormatter alloc] init];
        [dateFormat_End setDateFormat:@"yyyyMMdd"];
        [dateFormat_End setTimeZone:[NSTimeZone systemTimeZone]];
        
        NSString *dateEndPrev = [dateFormat stringFromDate:EndOfWeek];
        [dateArray addObject:[dateEndPrev stringByReplacingOccurrencesOfString:@"-" withString:@""]];
    }
    return [NSArray arrayWithArray:dateArray];

}

#pragma mark Month Process
- (NSArray *)getMonthDaysByType:(CSDateType)type WithTimeZone:(NSTimeZone*)timeZone{
    NSMutableArray *dateArray = [NSMutableArray new];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    [dateFormat setTimeZone:timeZone];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    if (type == CSDateTypeLastMonth) {
        //Month -1
        NSDateComponents* dateComponents = [[NSDateComponents alloc]init];
        [dateComponents setMonth:-1];
        today = [calendar dateByAddingComponents:dateComponents toDate:today options:0];
    
    }else if (type == CSDateTypeThisWeek || type == CSDateTypeLastWeek){
        return @[@"Input Error"];
    }

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
    return [NSArray arrayWithArray:dateArray];
}

#pragma mark Other Process
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
