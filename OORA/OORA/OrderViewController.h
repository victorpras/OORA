//
//  OrderViewController.h
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    NSArray *finalItems;
    NSArray *finalPrices;
    UITableView *postTable;

}
@property(nonatomic, retain) NSArray *finalItems;
@property(nonatomic, retain) NSArray *finalPrices;
@property (nonatomic, retain) UITableView *postTable;

- (id)initWithOrder:(NSDictionary*)list;
-(void)createTable;
@end
