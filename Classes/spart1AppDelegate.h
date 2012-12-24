//
//  spart1AppDelegate.h
//  spart1
//
//  Created by Greg Paton on 1/9/12.
//  Copyright 2012 __GSP__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface spart1AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@end

