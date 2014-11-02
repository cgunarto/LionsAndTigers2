//
//  MenuViewController.m
//  LionsAndTigers2
//
//  Created by CHRISTINA GUNARTO on 11/1/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () <UITableViewDelegate,  UITableViewDataSource>
@property NSMutableArray *menuItemsArray;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuItemsArray = [@[@"LIONS", @"TIGERS"]mutableCopy];
    self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.menuTableView dequeueReusableCellWithIdentifier:@"tableviewcell"];

    cell.textLabel.text = self.menuItemsArray [indexPath.row];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont fontWithName:@"Futura" size:20.0];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItemsArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self.delegate lionsButtonPressed];
    }

    if (indexPath.row == 1)
    {
        [self.delegate tigersButtonPressed];
    }
}





@end
