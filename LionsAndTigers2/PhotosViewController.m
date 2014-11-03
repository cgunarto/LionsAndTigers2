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
    self.collectionView.pagingEnabled = YES;
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

//    CGRect finalCellFrame = cell.frame;
//    //check the scrolling direction to verify from which side of the screen the cell should come.
//    CGPoint translation = [collectionView.panGestureRecognizer translationInView:collectionView.superview];
//    if (translation.x > 0) {
//        cell.frame = CGRectMake(finalCellFrame.origin.x - 1000, - 500.0f, 0, 0);
//    } else {
//        cell.frame = CGRectMake(finalCellFrame.origin.x + 1000, - 500.0f, 0, 0);
//    }
//
//    [UIView animateWithDuration:0.5f animations:^(void){
//        cell.frame = finalCellFrame;
//    }];


    return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.currentPhotosArray.count;
}

- (void)setupDataForCollectiveView
{
    NSArray *originalPhotos = [NSArray arrayWithObjects:self.currentPhotosArray[0],self.currentPhotosArray[1], self.currentPhotosArray[2],nil];
    id firstItem = originalPhotos[0];
    id lastItem = [originalPhotos lastObject];

    NSMutableArray *workingArray = [originalPhotos mutableCopy];

    [workingArray insertObject:lastItem atIndex:0];

    [workingArray addObject:firstItem];

    self.currentPhotosArray = [NSMutableArray arrayWithArray:workingArray];
}



- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    float contentOffsetWhenFullyScrolledToBottom = self.collectionView.frame.size.height * ([self.currentPhotosArray count] -1);

    if (scrollView.contentOffset.x == contentOffsetWhenFullyScrolledToBottom)
    {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:1 inSection:0];

        [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }

    else if (scrollView.contentOffset.y == 0)
    {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:([self.currentPhotosArray count] -2) inSection:0];
        [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float contentOffsetWhenFullyScrolledToBottom = self.collectionView.frame.size.height * ([self.currentPhotosArray count] -1);

    if (scrollView.contentOffset.x == contentOffsetWhenFullyScrolledToBottom)
    {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }

    else if (scrollView.contentOffset.y == 0)
    {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:([self.currentPhotosArray count] -2) inSection:0];
        [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }
}

@end
