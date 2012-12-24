//
//  FlipsideViewController.h
//  spart1
//
//  Created by Greg PAton on 1/9/12.
//  Copyright 2012 __GSP__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController {
	id <FlipsideViewControllerDelegate> delegate;
}


@property (nonatomic, retain) IBOutlet UITextField *text1;
@property (nonatomic, retain) IBOutlet UITextField *text2;
@property (nonatomic, retain) IBOutlet UITextField *text3;
@property (nonatomic, retain) IBOutlet UITextField *text4;
@property (nonatomic, retain) IBOutlet UITextField *text5;
@property (nonatomic, retain) IBOutlet UITextField *text6;
@property (nonatomic, retain) IBOutlet UITextField *text7;
@property (nonatomic, retain) IBOutlet UITextField *text8;
@property (nonatomic, retain) IBOutlet UITextField *text9;
@property (nonatomic, retain) IBOutlet UITextField *text10;

@property (nonatomic, retain) IBOutlet UITextField *exerTime;
@property (nonatomic, retain) IBOutlet UITextField *betweenTime;
@property (nonatomic, retain) IBOutlet UITextField *breakTime;
@property (nonatomic, retain) IBOutlet UITextField *numberOfExer;
@property (nonatomic, retain) IBOutlet UITextField *numberOfSets;


- (IBAction)resetDefaults:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;


@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
- (IBAction)done:(id)sender;
@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

