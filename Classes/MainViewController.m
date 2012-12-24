//
//  MainViewController.m
//  spart1
//
//  Created by Carlos Sanchez on 1/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController

@synthesize timeDisplay, startPause, resetButton, toolBar1, timer, exerTable;



#define AlertViewCheck 0
#define AlertViewReset 1
#define AlertViewSettings 2






#pragma mark Table View

//Table View Functions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0)
		return 1;
	else 
		return (10 - currentExer);
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
    int index = currentExer + [indexPath row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
    // Set up the cell...
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	exerTable.scrollEnabled = NO;
	
	if (indexPath.section == 0 && doingExercise == NO)
        cell.textLabel.text = @"Break";
    else if (indexPath.section == 0)
		cell.textLabel.text = [NSString	 stringWithFormat:@"%s", [exer[currentExer] UTF8String]];
	else {
        if (index > numExer)
            index = index % numExer;
        NSString *name = exer[[indexPath row] + index];
        if (name == NULL)
            name = @"";
		cell.textLabel.text = [NSString	 stringWithFormat:@"%s", [name UTF8String]];
	}
    
    return cell;
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// open a alert with an OK and cancel button
	NSString *alertString = [NSString stringWithFormat:@"Clicked on row #%d", [indexPath row]];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:@"" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
	[alert show];
	[alert release];
}*/

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if(section == 0)
		return @"Current";
	else
		return @"Next";
}










#pragma mark IBAction

//startPause and reset press response functions
- (IBAction)startPausePress:(id)sender	{
	if (!timerIsRunning)	{
		[self start];
		timerIsRunning = YES;
	}
	else {
		[self pause];
	}
}

- (IBAction)resetPress:(id)sender	{
	
	[self reset];
}


#pragma mark Set Array 

//set array values from NSUserDefaults
- (void)setExerArray	{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	exer[1] = [defaults objectForKey:@"ex1"];
	exer[2] = [defaults objectForKey:@"ex2"];
	exer[3] = [defaults objectForKey:@"ex3"];
	exer[4] = [defaults objectForKey:@"ex4"];
	exer[5] = [defaults objectForKey:@"ex5"];
	exer[6] = [defaults objectForKey:@"ex6"];
	exer[7] = [defaults objectForKey:@"ex7"];
	exer[8] = [defaults objectForKey:@"ex8"];
	exer[9] = [defaults objectForKey:@"ex9"];
	exer[10] = [defaults objectForKey:@"ex10"];
    
	exerTime = [[defaults objectForKey:@"exerTime"] intValue];
	betweenTime = [[defaults objectForKey:@"betweenTime"] intValue];
	breakTime = [[defaults objectForKey:@"breakTime"] intValue];
	numExer = [[defaults objectForKey:@"numOfExer"] intValue];
	numSets = [[defaults objectForKey:@"numOfSets"] intValue];
}





#pragma mark Timer Controls 

//timer controls: start, pause, reset
- (void)start	{
	
	timerIsRunning = YES;
    doingExercise = YES;
	[self setTimer];
	[startPause setTitle:@"Pause" forState:UIControlStateNormal];
}

- (void)pause	{	
	
	timerIsRunning = NO;
    doingExercise = NO;
	[timer invalidate];
	timer = nil;
	[startPause setTitle:@"Start" forState:UIControlStateNormal];
}

- (void)reset	{
	
	if (timerIsRunning) {
		[self pause];
	}
    currentExer = 1;
    currentSet = 1;
	
	UIAlertView *alertReset = [[UIAlertView alloc] initWithTitle:@"About to Reset Timer" message:@"Continue?"
														delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	alertReset.tag = AlertViewReset;
	[alertReset show];
	[alertReset release];
}





#pragma mark Timer Settings

//timer settings
- (void)setTimer	{
	[timer invalidate];
	timer = nil;
	timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}

-(void)updateCounter:(NSTimer *)theTimer {
	//increment count by 0.1 seconds
	count += 0.1;
	
	//padding values less than 10 with a 0
	NSString *padding;
	if (fmod(count, 60) < 10)	{
		padding = @"0";
	}
	else {
		padding = @"";
	}
	
	//Logic for displaying the exercises
	if (count+0.1 >= exerTime && doingExercise && currentExer < numExer && currentSet < numSets) {
		count = 0.0;
		doingExercise = NO;
		++currentExer;
	}
	else if (count+0.1 >= betweenTime && doingExercise == NO)	{
		count = 0.0;
		doingExercise = YES;
	}
    else if (currentExer >= numExer) {
        currentExer = 1;
        ++currentSet;
    }
    else if (currentSet >= numSets) {
        // DONE!
    }
	
    
	//update disp
    [exerTable reloadData];
	TIME = [[NSString alloc] initWithFormat:@"%0.0f:%s%.1f", floor(count/60), [padding UTF8String], fmod(count, 60)];
	timeDisplay.text = TIME;	
	
	[TIME release];
}



#pragma mark Check Exercises

//check if the exercises are set in settings, if not then pop up window

//ONLY CHECKS FIRST EXERCISE - STILL HAVE TO FINISH
- (void)checkIfExerSet	{
	if([[NSUserDefaults standardUserDefaults] objectForKey:@"ex1"] == nil || 
	   [[[NSUserDefaults standardUserDefaults] objectForKey:@"ex1"] length] == 0) {
	
		UIAlertView *alertCheck = [[UIAlertView alloc] initWithTitle:@"Exercises Are Not Set" message:@"Set them now?"
												   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
		alertCheck.tag = AlertViewCheck;
		[alertCheck show];
		[alertCheck release];
	}
}





#pragma mark Alert Action

//Alert for exercise check and reset button
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == AlertViewCheck) {
		if (buttonIndex == 1)	{
			[self showInfo: self];
		}
	}
	else if (alertView.tag == AlertViewReset)	{
		if (buttonIndex == 1) {
			count = 0.0;
			self.timeDisplay.text = @"0:00.0";
			currentExer = 1;
			[exerTable reloadData];
		}
	}
    else if (alertView.tag == AlertViewSettings) {
        if (buttonIndex == 1) {
            FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
            controller.delegate = self;
            
            controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:controller animated:YES completion:nil];
            
            [controller release];
        }
    }
}










#pragma mark View Functions

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {	
	//*************
	//doingExercise = YES;
	//*************
	
	
	
	//check if the exercises are set
	[self checkIfExerSet];
	[self setExerArray];
	
	//set height of display (toolbar)
	[toolBar1 setFrame:CGRectMake(0,0,320,200)];
	
	//initialize variables
	count = 0.0;
	currentExer = 1;
	
	[super viewDidLoad];
}





- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    // reset everything
    timerIsRunning = NO;
    doingExercise = NO;
    currentExer = 1;
    currentSet = 1;
    [exerTable reloadData];
    
	[self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)showInfo:(id)sender {     
	if (timerIsRunning) {
		[self pause];
        
        UIAlertView *alertSettings = [[UIAlertView alloc] initWithTitle:@"Changing settings will reset current workout"             message:@"Continue?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        alertSettings.tag = AlertViewSettings;
        [alertSettings show];
        [alertSettings release];
        
    }
    else { 
        FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
        controller.delegate = self;
        
        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:controller animated:YES completion:nil];
        
        [controller release];
    }
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
