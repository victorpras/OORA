//
//  OrderViewController.h
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/PFFacebookUtils.h>
@interface OrderViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, PF_FBRequestDelegate>{
    NSArray *finalItems;
    NSArray *finalPrices;
    UITableView *postTable;
    PF_Facebook *facebook;
    UIImage *profile;
}
@property(nonatomic, retain) NSArray *finalItems;
@property(nonatomic, retain) NSArray *finalPrices;
@property (nonatomic, retain) UITableView *postTable;
@property (nonatomic, retain) PF_Facebook *facebook;
@property (nonatomic, retain) UIImage* profile;
- (id)initWithOrder:(NSDictionary*)list;
-(void)createTable;
@end
