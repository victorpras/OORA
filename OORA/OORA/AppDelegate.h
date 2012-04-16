//
//  AppDelegate.h
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{
    UITabBarController *tabBarController;
    UIView* loadingView;
    UIView* dimView;
    UILabel* label;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property ( nonatomic, retain ) UIView* loadingView;
@property ( nonatomic, retain ) UIView* dimView;
@property ( nonatomic, retain ) UILabel* label;

- (void) createLoading;
- (void) showLoading: (NSString*) title;
- (void) hideLoading;
@end
