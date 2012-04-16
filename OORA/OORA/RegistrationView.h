//
//  RegistrationView.h
//  nomly
//
//  Created by Justin Huang on 8/18/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface RegistrationView : UIViewController{
    UITextField *email;
    UITextField *username;
    UITextField *password;
    UILabel *wrong;
}
@property (nonatomic, retain) IBOutlet UITextField *email;
@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UILabel *wrong;

- (IBAction) signup:(id)sender;
- (IBAction) textFieldDoneEditing:(id)sender;
- (IBAction) backgroundTap:(id)sender;
- (IBAction) cancelButton:(id)sender;

@end
