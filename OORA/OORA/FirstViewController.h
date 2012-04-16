//
//  FirstViewController.h
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@protocol ModalViewDelegate
- (void) ModalDidCancel;
- (void) ModalDidFinish;

@end
#define METERS_PER_MILE 1609.344
@interface FirstViewController : UIViewController<MKMapViewDelegate, ModalViewDelegate>{
    MKMapView *_mapView;
    UIToolbar *loginBar;
    NSString *curr;
    NSUserDefaults *defaults;
    UIBarButtonItem *next;
}
@property (nonatomic, retain) UIToolbar *loginBar;
@property (nonatomic) IBOutlet MKMapView *_mapView;
@property (nonatomic, retain) NSString* curr;
@property (nonatomic, retain) NSUserDefaults *defaults;

-(id) initWithTabBar;
- (void)checkLogin;
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view;
- (void)order;

@end
