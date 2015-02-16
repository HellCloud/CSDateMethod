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
    
    NSLog(@"今天是週 %@", [[CSDateProcess sharedInstance] getLocalTimeZoneCurrentDateOfThisWeek]);
    NSLog(@"今天是 %@ 號", [[CSDateProcess sharedInstance] getLocalTimeZoneCurrentDateOfThisMonth]);
    NSLog(@"本週所有的日期是 %@", [[CSDateProcess sharedInstance] getAllDateInThisWeek]);
    NSLog(@"這個月的所有日期是 %@", [[CSDateProcess sharedInstance] getAllDateInThisMonth]);
    NSLog(@"上個月的所有日期是 %@", [[CSDateProcess sharedInstance] getAllDateInLastMonth]);
    NSLog(@"上個月的總共天數是 %@", [[CSDateProcess sharedInstance] getTotalDaysOfLastMonth]);
    NSLog(@"這個月的總共天數是 %@", [[CSDateProcess sharedInstance] getTotalDaysOfThisMonth]);
    NSLog(@"上週的所有日期是 %@", [[CSDateProcess sharedInstance] getAllDateInLastWeek]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellidentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    
    cell.textLabel.text = @"123";
    
    return cell;
}
@end
