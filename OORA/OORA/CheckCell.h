//
//  CheckCell.h
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckCell : UITableViewCell{
    UILabel *item;
    UILabel *price;
    UILabel *line;
}

@property(nonatomic,retain) UILabel *item;
@property(nonatomic,retain) UILabel *line;
@property(nonatomic,retain) UILabel *price;
@end
