//
//  RegistrationView.m
//  nomly
//
//  Created by Justin Huang on 8/18/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "RegistrationView.h"

@implementation RegistrationView
@synthesize email, password, wrong, username;

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
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    username.leftView = paddingView;
    username.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    password.leftView = paddingView2;
    password.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    email.leftView = paddingView3;
    email.leftViewMode = UITextFieldViewModeAlways;

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
}


#pragma mark
#pragma mark - signup
#pragma mark
- (void)handleSignUp:(NSNumber *)result error:(NSError *)error {
    if (!error) {
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Signed Up!" message:@"Login to make sure your login info is correct"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertsuccess show];
    } else {
        NSString *errorString = [[error userInfo] objectForKey:@"error"];
        wrong.text = errorString;
    }
}

- (IBAction) signup:(id)sender{
    PFUser *user = [[PFUser alloc] init];
    user.username = username.text;
    user.password = password.text;
    user.email = email.text;
    [user signUpInBackgroundWithTarget:self 
                              selector:@selector(handleSignUp:error:)];
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
    [email resignFirstResponder];
    [password resignFirstResponder];
}


@end
