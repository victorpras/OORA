//
//  CheckCell.m
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "CheckCell.h"

@implementation CheckCell
@synthesize item1, price1, item2, price2, item3, price3, line, profile;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eventDoubleDecker"]];
        self.backgroundView = bg;
        
        item1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 230, 16)];
        item1.textColor = [UIColor blackColor];
        item1.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16.0)];
        item1.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:item1];
        
        price1 = [[UILabel alloc] initWithFrame:CGRectMake(255, 5, 60, 16)];
        price1.textColor = [UIColor blackColor];
        price1.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(14.0)];
        price1.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:price1];
        
        item2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 24, 230, 16)];
        item2.textColor = [UIColor blackColor];
        item2.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16.0)];
        item2.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:item2];
        
        price2 = [[UILabel alloc] initWithFrame:CGRectMake(255, 24, 60, 16)];
        price2.textColor = [UIColor blackColor];
        price2.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(14.0)];
        price2.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:price2];
        
        item3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 43, 230, 16)];
        item3.textColor = [UIColor blackColor];
        item3.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16.0)];
        item3.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:item3];
        
        price3 = [[UILabel alloc] initWithFrame:CGRectMake(255, 43, 60, 16)];
        price3.textColor = [UIColor blackColor];
        price3.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(14.0)];
        price3.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:price3];
        
        line = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 290, 5)];
        line.textColor = [UIColor redColor];
        line.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(5.0)];
        line.backgroundColor = [UIColor clearColor];
        line.textAlignment = UITextAlignmentCenter;
        [self.contentView addSubview:line];
        
        profile = [[UIImageView alloc] initWithFrame:CGRectMake(5, 93, 45, 45)];
        [self.contentView addSubview:profile];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
