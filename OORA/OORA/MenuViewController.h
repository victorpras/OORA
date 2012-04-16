//
//  MenuViewController.h
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "twoImageCell.h"

@interface MenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, MenuDelegate>{
    UITableView *postTable;
    NSString *restaurant;
    NSArray *items;
    NSMutableSet *check;
}
@property (nonatomic, retain) UITableView *postTable;
@property (retain) NSString *restaurant;
@property (retain) NSArray *items;
@property (nonatomic, retain) NSMutableSet *check;
- (void)createTable;
- (id)initWithRestaurant:(NSString*)restaurantName items:(NSArray*)menuItems;
- (void)finalize;
@end
