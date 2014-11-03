//
//  PhotosViewController.h
//  LionsAndTigers2
//
//  Created by CHRISTINA GUNARTO on 11/1/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopDelegate <NSObject>

- (void)onMenuButtonTapped;

@end

@interface PhotosViewController : UIViewController
@property id <TopDelegate> delegate;
@property NSMutableArray *currentPhotosArray;

- (void) refreshView;
- (void)setupDataForCollectiveView;

@end
