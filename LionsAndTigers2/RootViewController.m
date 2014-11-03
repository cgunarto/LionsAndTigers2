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

#define kLeftConstant -16
#define kRightConstant -16
#define kConstantMove 200
#define kAnimationDuration 0.2


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


#pragma mark VC Life Cycle

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navVC = self.childViewControllers[1];
    self.photoVC = (PhotosViewController*)self.navVC.topViewController; //CASTING IT AS A PHOTOSVC so it knows that it's a PhotoVC object
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];


    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    self.collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[self.navVC.view]];

    self.collisionBehavior.collisionDelegate = self;

    self.gravityBehavior = [[UIGravityBehavior alloc]initWithItems:@[self.navVC.view]];

    self.dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.navVC.view]];

    self.pushBehavior = [[UIPushBehavior alloc]initWithItems:@[self.navVC.view]
                                                        mode:UIPushBehaviorModeContinuous];

    [self.collisionBehavior addBoundaryWithIdentifier:@"left"
                                            fromPoint:CGPointMake(0, -10)
                                              toPoint:CGPointMake(0, self.view.frame.size.height + 10)];

    [self.collisionBehavior addBoundaryWithIdentifier:@"right"
                                            fromPoint:CGPointMake(self.view.frame.size.width + self.view.frame.size.width, -10)
                                              toPoint:CGPointMake(self.view.frame.size.width + self.view.frame.size.width, self.view.frame.size.height + 10)];

    [self.gravityBehavior setGravityDirection:CGVectorMake(0, 0)];
    [self.dynamicItemBehavior setElasticity:0.1];

    [self.dynamicAnimator addBehavior:self.collisionBehavior];
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
    [self.dynamicAnimator addBehavior:self.pushBehavior];
    [self.dynamicAnimator addBehavior:self.dynamicItemBehavior];
    
    
}


#pragma mark Custom Delegation Method

- (void)onMenuButtonTapped
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.photosLeftConstraint.constant = self.photosLeftConstraint.constant + kConstantMove;
        self.photosRightConstraint.constant = self.photosRightConstraint.constant - kConstantMove;
        [self.view layoutIfNeeded];
    }];
}

- (void)tigersButtonPressed
{
    [self.photoVC.currentPhotosArray removeAllObjects];
    // self.photoVC.currentPhotoArray = [NSMutable Array array]; // convenience initializer on the class that does alloc init for you
    self.photoVC.currentPhotosArray = self.tigerPhotosArray;
    [self.photoVC setupDataForCollectiveView];
    [self.photoVC refreshView];

    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self returnOriginalLayout];
    }];

}

- (void)lionsButtonPressed
{
    [self.photoVC.currentPhotosArray removeAllObjects];
    self.photoVC.currentPhotosArray = self.lionPhotosArray;
    [self.photoVC setupDataForCollectiveView];
    [self.photoVC refreshView];

    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self returnOriginalLayout];
    }];
}

#pragma mark Gesture Handler

- (IBAction)panHandler:(UIPanGestureRecognizer *)gesture
{

    CGPoint translation = [gesture translationInView:gesture.view];
    self.photosLeftConstraint.constant = self.photosLeftConstraint.constant + translation.x;
    self.photosRightConstraint.constant = self.photosRightConstraint.constant - translation.x;


//    self.navVC.view.center = CGPointMake(self.navVC.view.center.x + translation.x, self.navVC.view.center.y);

    //    self.navVC.view
    //take where it is currently and add or subtract to it based on translation
    //after we used the translation we want to reswt it

//    [gesture setTranslation:CGPointMake(0, 0) inView:gesture.view];
//
//    CGFloat xVelocity = [gesture velocityInView:gesture.view].x;  // get the x velocity
//    if (gesture.state == UIGestureRecognizerStateEnded)
//    {
//        [self.dynamicAnimator updateItemUsingCurrentState:self.navVC.view];
//
//        if (xVelocity < -500.0) {
//            [self.gravityBehavior setGravityDirection:CGVectorMake(-1, 0)];
//            [self.dynamicItemBehavior setElasticity:0.5];
//            [self.pushBehavior setPushDirection:CGVectorMake([gesture velocityInView:gesture.view].x, 0)];
//        }
//        else if (xVelocity >= -500.0 && xVelocity < 0) {
//            [self.gravityBehavior setGravityDirection:CGVectorMake(-1, 0)];
//            [self.dynamicItemBehavior setElasticity:0.25];
//            [self.pushBehavior setPushDirection:CGVectorMake(-500.0, 0)];
//        }
//        else if (xVelocity >= 0 && xVelocity < 500.0) {
//            [self.gravityBehavior setGravityDirection:CGVectorMake(1, 0)];
//            [self.dynamicItemBehavior setElasticity:0.25];
//            [self.pushBehavior setPushDirection:CGVectorMake(500.0, 0)];
//        } else {
//            [self.gravityBehavior setGravityDirection:CGVectorMake(1, 0)];
//            [self.dynamicItemBehavior setElasticity:0.5];
//            [self.pushBehavior setPushDirection:CGVectorMake([gesture velocityInView:gesture.view].x, 0)];
//        }
//    }
    [self.view layoutIfNeeded];
}

#pragma mark Custom Methods

- (void) returnOriginalLayout
{
    self.photosLeftConstraint.constant = kLeftConstant;
    self.photosRightConstraint.constant = kRightConstant;
    [self.view layoutIfNeeded];
}


@end
