//
//  CheckCell.m
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "CheckCell.h"

@implementation CheckCell
@synthesize item, price, line
;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        item = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 230, 20)];
        item.textColor = [UIColor blackColor];
        item.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(20.0)];
        item.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:item];
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(255, 5, 60, 20)];
        price.textColor = [UIColor blackColor];
        price.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16.0)];
        price.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:price];
        
        line = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 290, 5)];
        line.textColor = [UIColor redColor];
        line.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(5.0)];
        line.backgroundColor = [UIColor clearColor];
        line.textAlignment = UITextAlignmentCenter;
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
