//
//  CSDateProcess.h
//  CSDateMethod
//
//  Created by Cloud Sung on 2015/2/11.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CSDateType){
    CSDateTypeThisWeek,
    CSDateTypeThisMonth,
    CSDateTypeLastWeek,
    CSDateTypeLastMonth
};

@interface CSDateProcess : NSObject

- (NSString *)getLocalTimeZoneCurrentDateOfThisMonth;
- (NSString *)getLocalTimeZoneCurrentDateOfThisWeek;

- (NSString *)getCurrentDateOfThisMonthWithTimeZone:(NSTimeZone*)timeZone;
- (NSString *)getCurrentDateOfThisWeekWithTimeZone:(NSTimeZone*)timeZone;

- (NSString *)getTotalDaysOfLastMonth;

- (NSArray *)getAllDateInThisMonth;
- (NSArray *)getAllDateInThisWeek;
- (NSArray *)getAllDateinLastMonth;
- (NSArray *)getAllDateinLastWeek;

- (NSString*)dateProcessWithType:(CSDateType)type TimeZone:(NSTimeZone *)timeZone;

@end
