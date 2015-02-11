//
//  CSDateProcess.h
//  CSDateMethod
//
//  Created by SungHsiang Yu on 2015/2/11.
//
//

#import <Foundation/Foundation.h>

@interface CSDateProcess : NSObject{
    NSString *numberOfDaysOfThisMonth;
    
    NSString *dayOfWeek;
    NSString *dayOfMonth;
    NSString *todayDate;
    
    NSArray *dateOfWeekArray;
    NSArray *dateOfMonthArray;
}


- (NSString *)getLocalTimeZoneCurrentDateOfThisMonth;
- (NSString *)getLocalTimeZoneCurrentDateOfThisWeek;

- (NSString *)getCurrentDateOfThisMonthWithTimeZone:(NSTimeZone*)timeZone;
- (NSString *)getCurrentDateOfThisWeekWithTimeZone:(NSTimeZone*)timeZone;

- (NSString *)getTotalDaysOfLastMonth;

@end
