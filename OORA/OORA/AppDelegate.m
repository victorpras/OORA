//
//  AppDelegate.m
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "FirstViewController.h"
#import <Parse/Parse.h>
@implementation AppDelegate
@synthesize loadingView, dimView, label;
@synthesize tabBarController;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //PARSE
    [Parse setApplicationId:@"SDPaBFP2RDeggvLdWjPhVHp0RqZGFsS6HezHzH7i" 
                  clientKey:@"G2PoJEyOpgAHoj5cFg7GmtHovM33Q8f8BaBAAJFs"];
    [PFFacebookUtils initializeWithApplicationId:@"202259026454121"];
    
    tabBarController = [[UITabBarController alloc] init];
    NSMutableArray *localControllersArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    UINavigationController *locationStreamNavController;
    FirstViewController *map;
    map = [[FirstViewController alloc] initWithTabBar];
    locationStreamNavController = [[UINavigationController alloc] initWithRootViewController:map];
    [localControllersArray addObject:locationStreamNavController];
    
    tabBarController.viewControllers = localControllersArray;
    [_window addSubview:tabBarController.view];
    [self createLoading];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) createLoading
{
    //create the loading view
    //The loadingView is retained by the appDelegate
    CGSize loadingSize = CGSizeMake( 150, 150 );
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    loadingView.backgroundColor = [UIColor clearColor];
    
    //Round corners the corners of the loadingView
    //NOTE: you must #import <QuartzCore/QuartzCore.h>
    //for this to work
    [[loadingView layer] setCornerRadius:10];
    
    //Any overflowing elements will be clipped.
    //No elements should overflow anyway
    [loadingView setClipsToBounds:YES];
    
    //Create colored border using CALayer property
    [[loadingView layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    [[loadingView layer] setBorderWidth:2.75];
    
    //create the semi-transparent view
    CGRect transparentViewFrame = CGRectMake( 0, 0, loadingSize.width, loadingSize.height );
    UIView* transparentView = [[UIView alloc] initWithFrame:transparentViewFrame ];
    transparentView.backgroundColor = [UIColor blackColor];
    transparentView.alpha = 0.85;
    
    [loadingView addSubview:transparentView];
    
    //create the activity indicator
    UIActivityIndicatorView* loadingIcon = [[UIActivityIndicatorView alloc] 
                                            initWithActivityIndicatorStyle:
                                            UIActivityIndicatorViewStyleWhiteLarge];
    [loadingIcon startAnimating];
    
    //Set the frame for the indicator
    CGRect liFrame = loadingIcon.frame;
    CGRect loadingIconFrame = CGRectMake( loadingSize.width/2 - liFrame.size.width/2,
                                         loadingSize.height/2 - 20 - liFrame.size.height/2,
                                         liFrame.size.width, liFrame.size.height );
    loadingIcon.frame = loadingIconFrame;
    [loadingView addSubview:loadingIcon];
    
    //Create the text to place in the loading view.
    //Label will also be retained by the appDelegate
    //so we may change the title
    CGRect labelFrame = CGRectMake( 10, loadingSize.height - 80, 
                                   loadingSize.width - 20, 55 );
    label = [[UILabel alloc] initWithFrame:labelFrame];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:50];
    label.adjustsFontSizeToFitWidth = YES;  
    [loadingView addSubview:label];
    
    //create the view to dim the screen
    //Also retained by the appDelegate
    dimView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0) ];
    dimView.backgroundColor = [UIColor blackColor];
    dimView.alpha = 0.25;
}
- (void) showLoading: (NSString*) title
{
    //Grab application frames
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    
    //Calculate the loading view frame
    CGSize loadingSize = CGSizeMake( 150, 150 );
    CGRect loadingFrame = CGRectMake( appFrame.size.width/2 - loadingSize.width/2, 
                                     appFrame.size.height/2 - loadingSize.height/2, 
                                     loadingSize.width, loadingSize.height );
    loadingView.frame = loadingFrame;
    label.text = title;
    
    CGRect dimViewFrame = CGRectMake( 0, 0, appFrame.size.width, appFrame.size.height );
    dimView.frame = dimViewFrame;
    
    //Refer to the included iOS project for this method
    //[self rotateLoading];
    
    //Add the loadingView and dimView to the window
    [[[UIApplication sharedApplication] keyWindow] addSubview:dimView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:loadingView];
}
- (void) hideLoading
{
    [loadingView removeFromSuperview];
    [dimView removeFromSuperview];
    
    //For rotation refer to iOS project for complete details
    //CGAffineTransform rotationTransform = CGAffineTransformIdentity;
    //rotationTransform = CGAffineTransformRotate(rotationTransform, degreesToRadians(0));
    //loadingView.transform = rotationTransform;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url]; 
}

@end
