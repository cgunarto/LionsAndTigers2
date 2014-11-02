//
//  ViewController.m
//  LionsAndTigers2
//
//  Created by CHRISTINA GUNARTO on 11/1/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "RootViewController.h"
#import "PhotosViewController.h"
#import "MenuViewController.h"

@interface RootViewController () <TopDelegate, HUDDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photosLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photosRightConstraint;
@property UINavigationController *navVC;
@property PhotosViewController *photoVC;
@property MenuViewController *menuVC;

@property NSMutableArray *tigerPhotosArray;
@property NSMutableArray *lionPhotosArray;

@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *dynamicItemBehavior;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;



@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navVC = self.childViewControllers[1];
    self.photoVC = (PhotosViewController*) self.navVC.topViewController; //CASTING IT AS A PHOTOSVC so it knows that it's a PhotoVC object
    self.photoVC.delegate = self;

    self.menuVC = self.childViewControllers [0];
    self.menuVC.delegate = self;

    self.lionPhotosArray = [@[[UIImage imageNamed:@"lion1"],
                               [UIImage imageNamed:@"lion2"],
                               [UIImage imageNamed:@"lion3"]]mutableCopy];

    self.tigerPhotosArray = [@[[UIImage imageNamed:@"tiger1"],
                              [UIImage imageNamed:@"tiger2"],
                              [UIImage imageNamed:@"tiger3"]]mutableCopy];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)onMenuButtonTapped
{
    [UIView animateWithDuration:0.2 animations:^{
        self.photosLeftConstraint.constant = self.photosLeftConstraint.constant + 200;
        self.photosRightConstraint.constant = self.photosRightConstraint.constant - 200;
        [self.view layoutIfNeeded];
    }];
}

- (void)tigersButtonPressed
{
    self.photoVC.currentPhotosArray = self.tigerPhotosArray;
    [self.photoVC refreshView];

    [UIView animateWithDuration:0.2 animations:^{
        self.photosLeftConstraint.constant = -16;
        self.photosRightConstraint.constant = -16;
        [self.view layoutIfNeeded];
    }];

}

- (void)lionsButtonPressed
{
    self.photoVC.currentPhotosArray = self.lionPhotosArray;
    [self.photoVC refreshView];

    [UIView animateWithDuration:0.2 animations:^{
        self.photosLeftConstraint.constant = -16;
        self.photosRightConstraint.constant = -16;
        [self.view layoutIfNeeded];
    }];
}


- (IBAction)panHandler:(UIPanGestureRecognizer *)gesture
{
  CGPoint translation = [gesture translationInView:gesture.view];
    self.photosLeftConstraint.constant = self.photosLeftConstraint.constant + translation.x;
    self.photosRightConstraint.constant = self.photosRightConstraint.constant - translation.x;

    [gesture setTranslation:CGPointMake(0, 0) inView:gesture.view];

    CGFloat xVelocity = [gesture velocityInView:gesture.view].x;// get the y velocity
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self.dynamicAnimator updateItemUsingCurrentState:self.view];

        if (xVelocity < -500.0) {
            [self.gravityBehavior setGravityDirection:CGVectorMake(0, -1)];
            [self.dynamicItemBehavior setElasticity:0.5];
            [self.pushBehavior setPushDirection:CGVectorMake(0, [gesture velocityInView:gesture.view].x)];
        }
        else if (xVelocity >= -500.0 && xVelocity < 0) {
            [self.gravityBehavior setGravityDirection:CGVectorMake(0, -1)];
            [self.dynamicItemBehavior setElasticity:0.25];
            [self.pushBehavior setPushDirection:CGVectorMake(0, -500.0)];
        }
        else if (xVelocity >= 0 && xVelocity < 500.0) {
            [self.gravityBehavior setGravityDirection:CGVectorMake(0, 1)];
            [self.dynamicItemBehavior setElasticity:0.25];
            [self.pushBehavior setPushDirection:CGVectorMake(0, 500.0)];
        } else {
            [self.gravityBehavior setGravityDirection:CGVectorMake(0, 1)];
            [self.dynamicItemBehavior setElasticity:0.5];
            [self.pushBehavior setPushDirection:CGVectorMake(0, [gesture velocityInView:gesture.view].x)];
        }
    }
}




@end
