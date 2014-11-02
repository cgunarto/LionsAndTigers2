//
//  MenuViewController.m
//  LionsAndTigers2
//
//  Created by CHRISTINA GUNARTO on 11/1/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onLionsButtonPressed:(UIButton *)sender
{
    [self.delegate lionsButtonPressed];
}

- (IBAction)onTigersButtonPressed:(UIButton *)sender
{
    [self.delegate tigersButtonPressed];
}

@end
