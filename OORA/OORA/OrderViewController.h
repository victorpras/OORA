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
    NSMutableArray *finalItems;
    NSMutableArray *finalPrices;
    UITableView *postTable;
    PF_Facebook *facebook;
    UIImage *profile;
    NSNumber *order;
}
@property(nonatomic, retain) NSNumber *order;

@property(nonatomic, retain) NSMutableArray *finalItems;
@property(nonatomic, retain) NSMutableArray *finalPrices;
@property (nonatomic, retain) UITableView *postTable;
@property (nonatomic, retain) PF_Facebook *facebook;
@property (nonatomic, retain) UIImage* profile;
- (id)initWithOrder:(NSNumber*)list;
-(void)createTable;
@end
