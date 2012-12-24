//
//  FlipsideViewController.m
//  spart1
//
//  Created by Greg Paton on 1/9/12.
//  Copyright 2012 __GSP__. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate;

@synthesize text1, text2, text3, text4, text5, text6, text7, text8, text9, text10, exerTime, betweenTime, breakTime, numberOfExer, numberOfSets;






//Keyboard Functions
CGFloat animatedDistance;

- (void)textFieldDidBeginEditing:(UITextField *)textField	{
	
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
	
	CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
	CGFloat numerator = midline - viewRect.origin.y - 0.2 * viewRect.size.height;
	CGFloat denominator = (0.6) * viewRect.size.height;
	CGFloat heightFraction = numerator / denominator;
	
	if (heightFraction < 0.0)
	{
		heightFraction = 0.0;
	}
	else if (heightFraction > 1.0)
	{
		heightFraction = 1.0;
	}
	
	
	animatedDistance = floor(216 * heightFraction);
	
	
	CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
	
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
	
    [self.view setFrame:viewFrame];
	
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField	{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
	
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
	
    [self.view setFrame:viewFrame];
	
    [UIView commitAnimations];
}

- (IBAction)textFieldReturn:(id)sender	{
	[sender resignFirstResponder];
}

- (IBAction)dismissKeyboard:(id)sender	{
	[text1 resignFirstResponder];
	[text2 resignFirstResponder];
	[text3 resignFirstResponder];
	[text4 resignFirstResponder];
	[text5 resignFirstResponder];
	[text6 resignFirstResponder];
	[text7 resignFirstResponder];
	[text8 resignFirstResponder];
	[text9 resignFirstResponder];
	[text10 resignFirstResponder];
	[exerTime resignFirstResponder];
	[betweenTime resignFirstResponder];
	[breakTime resignFirstResponder];
	[numberOfExer resignFirstResponder];
	[numberOfSets resignFirstResponder];
}



//UIAlertView: Clear and Reset Functions
#define AlertViewClear 0
#define AlertViewReset 1
#define AlertViewSettings 2

- (IBAction)clear:(id)sender	{
	UIAlertView *alertClear = [[UIAlertView alloc] initWithTitle:@"About To Clear Exercises" message:@"Continue?"
												   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	alertClear.tag = AlertViewClear;
	[alertClear show];
	[alertClear release];
}

- (IBAction)resetDefaults:(id)sender	{
	
	UIAlertView *alertReset = [[UIAlertView alloc] initWithTitle:@"About To Reset Exercises" message:@"Continue?"
												   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	alertReset.tag = AlertViewReset;
	[alertReset show];
	[alertReset release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex	{
	if (alertView.tag == AlertViewReset) {
		if (buttonIndex == 1)
		{
			[self setTextFieldAsDefault];
		}
	}
	else if (alertView.tag == AlertViewClear) {
		if (buttonIndex == 1) {
			[self resetDefaults];
	
		}
	}
}



//set Text, reset, default, save
- (void)setTextFields	{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	text1.text = [defaults objectForKey:@"ex1"];
	text2.text = [defaults objectForKey:@"ex2"];
	text3.text = [defaults objectForKey:@"ex3"];
	text4.text = [defaults objectForKey:@"ex4"];
	text5.text = [defaults objectForKey:@"ex5"];
	text6.text = [defaults objectForKey:@"ex6"];
	text7.text = [defaults objectForKey:@"ex7"];
	text8.text = [defaults objectForKey:@"ex8"];
	text9.text = [defaults objectForKey:@"ex9"];
	text10.text = [defaults objectForKey:@"ex10"];
	exerTime.text = [defaults objectForKey:@"exerTime"];
	betweenTime.text = [defaults objectForKey:@"betweenTime"];
	breakTime.text = [defaults objectForKey:@"breakTime"];
	numberOfExer.text = [defaults objectForKey:@"numOfExer"];
	numberOfSets.text = [defaults objectForKey:@"numOfSets"];
}

- (void)setTextFieldAsDefault	{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:@"Squats" forKey:@"ex1"];
	[defaults setObject:@"Mtn Climbers" forKey:@"ex2"];
	[defaults setObject:@"Arm Ups" forKey:@"ex3"];
	[defaults setObject:@"T Pushups" forKey:@"ex4"];
	[defaults setObject:@"Lunges" forKey:@"ex5"];
	[defaults setObject:@"Rows" forKey:@"ex6"];
	[defaults setObject:@"Bis" forKey:@"ex7"];
	[defaults setObject:@"Tris" forKey:@"ex8"];
	[defaults setObject:@"Shoulders" forKey:@"ex9"];
	[defaults setObject:@"Pushup Rows" forKey:@"ex10"];
	[defaults setObject:@"60" forKey:@"exerTime"];
	[defaults setObject:@"15" forKey:@"betweenTime"];
	[defaults setObject:@"120" forKey:@"breakTime"];
	[defaults setObject:@"10" forKey:@"numOfExer"];
	[defaults setObject:@"3" forKey:@"numOfSets"];
	
	[defaults synchronize];
	
	[self setTextFields];
}

- (void)resetDefaults	{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:@"" forKey:@"ex1"];
	[defaults setObject:@"" forKey:@"ex2"];
	[defaults setObject:@"" forKey:@"ex3"];
	[defaults setObject:@"" forKey:@"ex4"];
	[defaults setObject:@"" forKey:@"ex5"];
	[defaults setObject:@"" forKey:@"ex6"];
	[defaults setObject:@"" forKey:@"ex7"];
	[defaults setObject:@"" forKey:@"ex8"];
	[defaults setObject:@"" forKey:@"ex9"];
	[defaults setObject:@"" forKey:@"ex10"];
	[defaults setObject:@"" forKey:@"exerTime"];
	[defaults setObject:@"" forKey:@"betweenTime"];
	[defaults setObject:@"" forKey:@"breakTime"];
	[defaults setObject:@"" forKey:@"numOfExer"];
	[defaults setObject:@"" forKey:@"numOfSets"];
	
	[defaults synchronize];
	
	[self setTextFields];
}

- (void)save	{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:text1.text forKey:@"ex1"];
	[defaults setObject:text2.text forKey:@"ex2"];
	[defaults setObject:text3.text forKey:@"ex3"];
	[defaults setObject:text4.text forKey:@"ex4"];
	[defaults setObject:text5.text forKey:@"ex5"];
	[defaults setObject:text6.text forKey:@"ex6"];
	[defaults setObject:text7.text forKey:@"ex7"];
	[defaults setObject:text8.text forKey:@"ex8"];
	[defaults setObject:text9.text forKey:@"ex9"];
	[defaults setObject:text10.text forKey:@"ex10"];
	[defaults setObject:exerTime.text forKey:@"exerTime"];
	[defaults setObject:betweenTime.text forKey:@"betweenTime"];
	[defaults setObject:breakTime.text forKey:@"breakTime"];
	[defaults setObject:numberOfExer.text forKey:@"numOfExer"];
	[defaults setObject:numberOfSets.text forKey:@"numOfSets"];
	
	
	[defaults synchronize];
}

- (bool)checkNumExerValid	{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	NSString *temp = [defaults objectForKey:@"numOfExer"];
	
	if ([temp intValue] < 1 || [temp intValue] > 10) {
		NSLog(@"Invalid number of exercise");
		
		UIAlertView *alertNumber = [[UIAlertView alloc] initWithTitle:@"Invalid Number of Exercises" message:@"Change before continuing"
															delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alertNumber show];
		[alertNumber release];
		
		return NO;
	}
	else {
		return YES;
	}

}









- (void)viewDidLoad {
	//*****
	[self setTextFields];	
	//*****
	
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
}


- (IBAction)done:(id)sender {
	//*****
	[self save];
	
	if ([self checkNumExerValid])	{
		[self.delegate flipsideViewControllerDidFinish:self];	
	}
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
