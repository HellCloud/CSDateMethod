//
//  ViewController.m
//  CSDateMethod
//
//  Created by Cloud Sung on 2015/2/11.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"今天是週 %@", [[CSDateProcess new] getLocalTimeZoneCurrentDateOfThisWeek]);
    NSLog(@"今天是 %@ 號", [[CSDateProcess new] getLocalTimeZoneCurrentDateOfThisMonth]);
    NSLog(@"本週所有的日期是 %@", [[CSDateProcess new] getAllDateInThisWeek]);
    NSLog(@"這個月的所有日期是 %@", [[CSDateProcess new] getAllDateInThisMonth]);
    NSLog(@"上個月的所有日期是 %@", [[CSDateProcess new] getAllDateInLastMonth]);
    NSLog(@"上個月的總共天數是 %@", [[CSDateProcess new] getTotalDaysOfLastMonth]);
    NSLog(@"這個月的總共天數是 %@", [[CSDateProcess new] getTotalDaysOfThisMonth]);
    NSLog(@"上週的所有日期是 %@", [[CSDateProcess new] getAllDateInLastWeek]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
