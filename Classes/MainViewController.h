//
//  MainViewController.h
//  spart1
//
//  Created by Greg Paton on 1/9/12.
//  Copyright 2012 __GSP__. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
@private 
	NSString *exer[11];
	NSString *TIME;
	
    int exerTime;
    int betweenTime;
    int breakTime;
    int numExer;
    int numSets;
	
	//Counters
	int currentExer;	// 1 <= currentExer <= 10
    int currentSet;
	bool doingExercise;
    bool doingBreak;
	
	
	float count;
	
	bool timerIsRunning;
	
	NSTimer *timer;
	
	IBOutlet UILabel *timeDisplay;
	IBOutlet UIButton *startPause;
	IBOutlet UIButton *resetButton;
	IBOutlet UIToolbar *toolBar1;
	IBOutlet UITableView *exerTable;

}

@property (nonatomic, retain) IBOutlet UILabel *timeDisplay;
@property (nonatomic, retain) IBOutlet UIButton *startPause;
@property (nonatomic, retain) IBOutlet UIButton *resetButton;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar1;
@property (nonatomic, retain) IBOutlet UITableView *exerTable;
@property (nonatomic, retain) NSTimer *timer;

@property(nonatomic, retain) UIView *tableHeaderView;


- (IBAction)showInfo:(id)sender;
- (IBAction)startPausePress:(id)sender;
- (IBAction)resetPress:(id)sender;

@end
