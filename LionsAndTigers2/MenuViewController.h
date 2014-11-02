//
//  MenuViewController.h
//  LionsAndTigers2
//
//  Created by CHRISTINA GUNARTO on 11/1/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HUDDelegate <NSObject>

- (void)lionsButtonPressed;
- (void)tigersButtonPressed;

@end

@interface MenuViewController : UIViewController
@property id <HUDDelegate> delegate;

@end
