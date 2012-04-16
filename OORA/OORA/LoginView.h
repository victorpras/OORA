//
//  LoginView.h
//  rawr
//
//  Created by Justin Huang on 5/24/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol ModalViewDelegate;

@interface LoginView : UIViewController {
    UITextField *username;
    UITextField *password;
    UILabel *wrong;
    id<ModalViewDelegate> delegate;

}

@property (retain) id<ModalViewDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UILabel *wrong;

- (void)handleUserLogin:(PFUser *)user error:(NSError **)error;
- (IBAction) login:(id)sender;
- (IBAction) textFieldDoneEditing:(id)sender;
- (IBAction) backgroundTap:(id)sender;
- (IBAction) cancelButton:(id)sender;
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
@end
