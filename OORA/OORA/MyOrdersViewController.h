//
//  MyOrdersViewController.h
//  OORA
//
//  Created by Justin Huang on 4/23/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrdersViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    UITableView *postTable;
}

@property(nonatomic, retain) UITableView *postTable;

@end
