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

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (IBAction)onMenuButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate onMenuButtonTapped];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *customCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    customCell.cellImageView.image = self.currentPhotosArray [indexPath.item];
    return customCell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.currentPhotosArray.count;
}

- (void) refreshView
{
    [self.collectionView reloadData];
}




@end
