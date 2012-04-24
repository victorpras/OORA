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
#import "UIImageView+WebCache.h"

#import "FourImageCell.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize _mapView, loginBar,curr, defaults, restaurantList, postTable;
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
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:26];
        label.shadowColor = [UIColor colorWithWhite:0.5 alpha:0.1];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor redColor]; // change this color
        self.navigationItem.titleView = label;
        label.text = NSLocalizedString(@"ordr", @"");
        [label sizeToFit];
        
        UIButton *settings = [UIButton buttonWithType:UIButtonTypeCustom];
        [settings setFrame:CGRectMake(0, 0, 55, 27)];
        [settings addTarget:self action:@selector(order) forControlEvents:UIControlEventTouchUpInside];
        [settings setImage:[UIImage imageNamed:@"iconCreate"] forState:UIControlStateNormal];
        UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:settings];
        self.navigationItem.rightBarButtonItem = settingsButton;
        

        [next setEnabled:NO];
        
        restaurantList = [[NSArray alloc] initWithObjects: nil];
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"new-navBar"]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self createTable];
    UIImage *patternImage = [UIImage imageNamed:@"background"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage]; 

    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude =37.866316;
    zoomLocation.longitude= -122.256546;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];                
    // 4
    [_mapView setRegion:adjustedRegion animated:YES];
    _mapView.showsUserLocation = YES;
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app showLoading: @"Finding Restaurants..." ];
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            restaurantList = objects;
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
                [postTable reloadData];
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
    if (annotation == _mapView.userLocation) {
        _mapView.userLocation.title = @"Test";
        [_mapView setRegion:MKCoordinateRegionMakeWithDistance(_mapView.userLocation.coordinate, 1000, 1000) animated:YES];
        return nil;
    }
    if (pin == nil)
    {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"asdf"];
    }
    else
    {
        pin.annotation = annotation;
    }
    pin.pinColor = MKPinAnnotationColorRed;
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
-(void)createTable{
    postTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 160, 300, 206) style:UITableViewStylePlain];
    postTable.dataSource = self;
    postTable.delegate = self;
    postTable.backgroundColor = [UIColor clearColor];
    postTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //postTable.separatorColor = [UIColor blackColor];
    [self.view addSubview:postTable];
}


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

#pragma mark
#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    return [restaurantList count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    return 90;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *PicIdentifier = @"Pic";
    
    FourImageCell *cell = (FourImageCell *)[tableView dequeueReusableCellWithIdentifier:PicIdentifier];
    
    if (cell == nil) {
        cell = [[FourImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PicIdentifier];
    } 
    PFObject *restaurant = [restaurantList objectAtIndex:indexPath.row];
    PFGeoPoint *point = [restaurant objectForKey:@"location"];
    double latitude = point.latitude;
    double longitude = point.longitude;
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    NSString *name =[restaurant objectForKey:@"Name"];
    NSString *num = [[restaurant objectForKey:@"numItems"] stringValue];
    NSLog(@"name: %@", name);
    cell.people.text = [NSString stringWithFormat:@"%@ people ",num];
    cell.title.text = name;
    //cell.userInteractionEnabled = YES;
    if(!cell.loaded){
        PFQuery *query = [PFQuery queryWithClassName:@"Menus"];
        [query whereKey:@"Name" equalTo:name];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                int n = 1;
                for (PFObject *menuItem in objects){
                    if(n==1){
                        [cell.image1 setImageWithURL:[NSURL URLWithString:[menuItem objectForKey:@"Picture"]]];
                        [cell.image1.layer setBorderColor:[UIColor whiteColor].CGColor];
                        [cell.image1.layer setBorderWidth: 2.0f];
                        cell.image1.layer.shadowOffset = CGSizeMake(0, 3);
                        cell.image1.layer.shadowOpacity = 0.7;	
                        cell.image1.layer.shouldRasterize = YES;
                    }
                    else if(n==2){
                        [cell.image2 setImageWithURL:[NSURL URLWithString:[menuItem objectForKey:@"Picture"]]];
                        [cell.image2.layer setBorderColor:[UIColor whiteColor].CGColor];
                        [cell.image2.layer setBorderWidth: 2.0f];
                        cell.image2.layer.shadowOffset = CGSizeMake(0, 3);
                        cell.image2.layer.shadowOpacity = 0.7;	
                        cell.image2.layer.shouldRasterize = YES;
                    }
                    else if(n==3){
                        [cell.image3 setImageWithURL:[NSURL URLWithString:[menuItem objectForKey:@"Picture"]]];
                        [cell.image3.layer setBorderColor:[UIColor whiteColor].CGColor];
                        [cell.image3.layer setBorderWidth: 2.0f];
                        cell.image3.layer.shadowOffset = CGSizeMake(0, 3);
                        cell.image3.layer.shadowOpacity = 0.7;	
                        cell.image3.layer.shouldRasterize = YES;
                    }
                    else if(n==4){
                        [cell.image4 setImageWithURL:[NSURL URLWithString:[menuItem objectForKey:@"Picture"]]];
                        [cell.image4.layer setBorderColor:[UIColor whiteColor].CGColor];
                        [cell.image4.layer setBorderWidth: 2.0f];
                        cell.image4.layer.shadowOffset = CGSizeMake(0, 3);
                        cell.image4.layer.shadowOpacity = 0.7;	
                        cell.image4.layer.shouldRasterize = YES;
                    }
                    n = n+1;
                }
                
                
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    cell.loaded = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSArray *arr = [_mapView annotations];
    NSString *name = ((FourImageCell*)[postTable cellForRowAtIndexPath:indexPath]).title.text;
    for(int i=0; i<[arr count]; i++)
    { 
        MKPointAnnotation *ann = [arr objectAtIndex:i];
        if([ann.title isEqualToString:name])
        {
            //do what you want to do after getting a annotation
            [_mapView selectAnnotation:ann animated:YES];

        }
    }
}

- (void) ModalDidCancel{
}


@end
