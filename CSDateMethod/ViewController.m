//
//  ViewController.m
//  CSDateMethod
//
//  Created by Cloud Sung on 2015/2/11.
//
//

#import "ViewController.h"

@interface ViewController (){
    NSArray *menuArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    menuArray = @[[NSString stringWithFormat:@"今天是週 %@", [[CSDateProcess sharedInstance] getLocalTimeZoneCurrentDateOfThisWeek]],
                  [NSString stringWithFormat:@"今天是 %@ 號", [[CSDateProcess sharedInstance] getLocalTimeZoneCurrentDateOfThisMonth]],
                  @"查閱本週所有的日期",
                  @"查閱上週所有的日期",
                  @"查閱本月的所有日期",
                  @"查閱上月的所有日期",
                  [NSString stringWithFormat:@"本月的總共天數是 %@", [[CSDateProcess sharedInstance] getTotalDaysOfThisMonth]],
                  [NSString stringWithFormat:@"上月的總共天數是 %@", [[CSDateProcess sharedInstance] getTotalDaysOfLastMonth]]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellidentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    
    cell.textLabel.text = [menuArray objectAtIndex:indexPath.row];

    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    return cell;
}


@end
