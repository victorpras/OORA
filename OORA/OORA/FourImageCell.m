//
//  FourImageCell.m
//  rawrapp
//
//  Created by Justin Huang on 12/7/11.
//  Copyright (c) 2011 UC Berkeley. All rights reserved.
//

#import "FourImageCell.h"

@implementation FourImageCell
@synthesize title, pid1, pid2, pid3, pid4, image1, image2, image3, image4, noImagesYet, author2, author3, author4, loaded, check, people;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feedPostBg"]];
        self.backgroundView = bg;
        loaded = FALSE;
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 280, 15)];
        title.font = [UIFont fontWithName:@"Arial" size:16];
        title.textColor = [UIColor blackColor];
        title.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:title];
        
        people = [[UILabel alloc] initWithFrame:CGRectMake(220, 5, 80, 14)];
        people.font = [UIFont fontWithName:@"Arial" size:12];
        people.textColor = [UIColor redColor];
        people.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:people];
        
        check = [[UIImageView alloc] initWithFrame:CGRectMake(280, 5, 16, 12)];
        check.image = [UIImage imageNamed:@"moveLocationSelected"];
        [self.contentView addSubview:check];
        
        image1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 22, 60, 60)];
        [self.contentView addSubview:image1];
        [image1 setUserInteractionEnabled:YES];
        
        image2 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 22, 60, 60)];
        [self.contentView addSubview:image2];
        [image2 setUserInteractionEnabled:YES];
        
        image3 = [[UIImageView alloc] initWithFrame:CGRectMake(155, 22, 60, 60)];
        [self.contentView addSubview:image3];
        [image3 setUserInteractionEnabled:YES];
        
        image4 = [[UIImageView alloc] initWithFrame:CGRectMake(230, 22, 60, 60)];
        [self.contentView addSubview:image4];
        [image4 setUserInteractionEnabled:YES];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
