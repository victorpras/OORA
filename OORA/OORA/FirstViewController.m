//
//  FirstViewController.m
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "FirstViewController.h"
#import <Parse/PFQuery.h>
#import "MenuViewController.h"
#import "MyLocation.h"
#import "AppDelegate.h"
#import <Parse/PFFacebookUtils.h>
#import "LoginView.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize _mapView, loginBar,curr, defaults;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithTabBar {
    if ([self init]) {
        //this is the label on the tab button itself
        self.title = @"Order";
        //use whatever image you want and add it to your project
        //self.tabBarItem.image = [UIImage imageNamed:@"marker.png"];
        
        // set the long name shown in the navigation bar at the top
        self.navigationItem.title=@"Restaurants";
        next = [[UIBarButtonItem alloc] initWithTitle:@"Order" style:UIBarButtonItemStylePlain target:self action:@selector(order)];
        self.navigationItem.rightBarButtonItem = next;
        [next setEnabled:NO];
        /*
         UIBarButtonItem *locs = [[UIBarButtonItem alloc] initWithTitle:@"Locations" style:UIBarButtonItemStylePlain target:self action:@selector(displayLocs:)];
         UIBarButtonItem *events = [[UIBarButtonItem alloc] initWithTitle:@"Events" style:UIBarButtonItemStylePlain target:self action:@selector(displayEvents:)];
         
         self.navigationItem.rightBarButtonItem = events;
         self.navigationItem.leftBarButtonItem = locs;
         */
    }
    return self;
    
}


- (void)viewDidLoad
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude =37.866316;
    zoomLocation.longitude= -122.256546;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];                
    // 4
    [_mapView setRegion:adjustedRegion animated:YES];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app showLoading: @"Finding Restaurants..." ];
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            [app hideLoading];
            for (PFObject *restaurant in objects){
                PFGeoPoint *point = [restaurant objectForKey:@"location"];
                double latitude = point.latitude;
                double longitude = point.longitude;
                CLLocationCoordinate2D coordinate;
                coordinate.latitude = latitude;
                coordinate.longitude = longitude;
                NSString *name =[restaurant objectForKey:@"Name"];
                NSString *num = [[restaurant objectForKey:@"numItems"] stringValue];
                MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
                annotationPoint.coordinate = coordinate;
                annotationPoint.title = name;
                //coords = touchMapCoordinate;
                annotationPoint.subtitle = [NSString stringWithFormat:@"%@ Items", num];
                [_mapView addAnnotation:annotationPoint];
                [_mapView selectAnnotation:annotationPoint animated:YES];
                curr = name;
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [self checkLogin];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation
{
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:@"asdf"];
    if (pin == nil)
    {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"asdf"];
    }
    else
    {
        pin.annotation = annotation;
    }
    pin.pinColor = MKPinAnnotationColorPurple;
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    return pin;
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"touch");
    [mapView selectAnnotation:view.annotation animated:NO];
    curr = view.annotation.title;
    
}

- (void)order{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app showLoading: @"Loading Menu..." ];
    PFQuery *query = [PFQuery queryWithClassName:@"Menus"];
    [query whereKey:@"Name" equalTo:curr];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            MenuViewController *aa=[[MenuViewController alloc] initWithRestaurant:curr items:objects];
            [app hideLoading];
            [[self navigationController] pushViewController:aa animated:YES];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}


/*
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MyLocation *)view
{
    NSLog(@"notouch");
    MenuViewController *aa=[[MenuViewController alloc] initWithRestaurant:view.name items:objects];
    [[self navigationController] pushViewController:aa animated:YES];
    
}*/



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)checkLogin{
    CGRect frame = self.tabBarController.tabBar.frame;
    loginBar = [[UIToolbar alloc] initWithFrame:frame];
    loginBar.barStyle = UIBarStyleBlack;
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        [loginBar setHidden:YES];
        [next setEnabled:YES];
    } else {
        
        [self.tabBarController.view addSubview:loginBar];
        NSMutableArray *items = [NSMutableArray array];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [items addObject:flexibleSpace];
        /*
         UIBarButtonItem *signup = [[UIBarButtonItem alloc] initWithTitle:@"Sign Up"
         style:UIBarButtonItemStyleBordered
         target:self
         action:@selector(signup:)];
         [items addObject:signup];
         [signup release]; 
         */
        UIBarButtonItem *loginF = [[UIBarButtonItem alloc] initWithTitle:@"Login with Facebook"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(loginFacebook:)];
        UIBarButtonItem *login = [[UIBarButtonItem alloc] initWithTitle:@"Login with Username"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(login:)];
        [items addObject:loginF];
        [items addObject:login];

        [items addObject:flexibleSpace];
        loginBar.items = items;
    }

}

-(void)loginFacebook:(id)sender{
    [PFFacebookUtils logInWithPermissions:[NSArray arrayWithObject:@"offline_access"] block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            [loginBar setHidden:YES];
            [next setEnabled:YES];

            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            [loginBar setHidden:YES];
            [next setEnabled:YES];

            NSLog(@"User logged in through Facebook!");
        }
    }];
}
-(void)login:(id)sender{
    LoginView *login = [[LoginView alloc] init] ;
    login.delegate = self;
    [self presentModalViewController:login animated:YES];
}
- (void) ModalDidFinish{
    [loginBar setHidden:YES];
    [next setEnabled:YES];

}


@end
