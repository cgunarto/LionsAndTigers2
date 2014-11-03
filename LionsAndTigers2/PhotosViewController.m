//
//  PhotosViewController.m
//  LionsAndTigers2
//
//  Created by CHRISTINA GUNARTO on 11/1/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "PhotosViewController.h"
#import "CustomCollectionViewCell.h"

@interface PhotosViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PhotosViewController

#pragma mark VC Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark Custom Delegation Method 

- (IBAction)onMenuButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate onMenuButtonTapped];
}

#pragma mark Custom Method

- (void) refreshView
{
    [self.collectionView reloadData];
}

#pragma mark Collection View Cell Data

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.cellImageView.image = self.currentPhotosArray [indexPath.item];

    CGRect finalCellFrame = cell.frame;
    //check the scrolling direction to verify from which side of the screen the cell should come.
    CGPoint translation = [collectionView.panGestureRecognizer translationInView:collectionView.superview];
    if (translation.x > 0) {
        cell.frame = CGRectMake(finalCellFrame.origin.x - 1000, - 500.0f, 0, 0);
    } else {
        cell.frame = CGRectMake(finalCellFrame.origin.x + 1000, - 500.0f, 0, 0);
    }

    [UIView animateWithDuration:0.5f animations:^(void){
        cell.frame = finalCellFrame;
    }];


    return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.currentPhotosArray.count;
}




@end
