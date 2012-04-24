//
//  CheckCell.h
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckCell : UITableViewCell{
    UILabel *item1;
    UILabel *price1;
    UILabel *item2;
    UILabel *price2;
    UILabel *item3;
    UILabel *price3;
    UILabel *line;
    
    UIImageView *profile;
}

@property(nonatomic,retain) UILabel *item1;
@property(nonatomic,retain) UILabel *price1;
@property(nonatomic,retain) UILabel *item2;
@property(nonatomic,retain) UILabel *price2;
@property(nonatomic,retain) UILabel *item3;
@property(nonatomic,retain) UILabel *price3;
@property(nonatomic,retain) UIImageView *profile;

@property(nonatomic,retain) UILabel *line;
@end
