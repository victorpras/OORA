//
//  LoginView.m
//  rawr
//
//  Created by Justin Huang on 5/24/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "LoginView.h"
#import "FirstViewController.h"

@implementation LoginView
@synthesize username,password,wrong;
@synthesize delegate;

- (void)handleUserLogin:(PFUser *)user error:(NSError **)error {
    if(user) {
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Awesome" message:@"You're logged in!"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertsuccess show];
        [self.delegate ModalDidFinish];
    } else {
        [wrong setFont:[UIFont fontWithName:@"Arial" size:14]];
        wrong.text = @"Incorrect login";
    }
}

- (IBAction)login:(id)sender
{
    [PFUser logInWithUsernameInBackground:username.text 
                                 password:password.text 
                                target:self
                                 selector:@selector(handleUserLogin:error:)];
}


- (void)cancelButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self dismissModalViewControllerAnimated:YES];
    }
}
#pragma mark
#pragma mark - Keyboard methods
#pragma mark

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [username resignFirstResponder];
    [password resignFirstResponder];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle




- (void)viewDidLoad
{
    UIImage *patternImage = [UIImage imageNamed:@"fabric_plaid.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    username.leftView = paddingView;
    username.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    password.leftView = paddingView2;
    password.leftViewMode = UITextFieldViewModeAlways;
    [username becomeFirstResponder];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    //return YES;
}

@end
