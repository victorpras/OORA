//
//  FourImageCell.h
//  rawrapp
//
//  Created by Justin Huang on 12/7/11.
//  Copyright (c) 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourImageCell : UITableViewCell{
    UIImageView *image1;
    UIImageView *image2;
    UIImageView *image3;
    UIImageView *image4;
    UIImageView *check;
    BOOL loaded;
    
    UILabel *title;
    UILabel *people;
    UILabel *author2;
    UILabel *author3;
    UILabel *author4;
    
    NSString *pid1;
    NSString *pid2;
    NSString *pid3;
    NSString *pid4;
    
}
@property(nonatomic) BOOL loaded;

@property(nonatomic,retain) UIImageView *image1;
@property(nonatomic,retain) UIImageView *image2;
@property(nonatomic,retain) UIImageView *image3;
@property(nonatomic,retain) UIImageView *image4;
@property(nonatomic,retain) UIImageView *check;
@property(nonatomic,retain) UILabel *title;
@property(nonatomic,retain) UILabel *people;

@property(nonatomic,retain) UILabel *noImagesYet;
@property(nonatomic,retain) UILabel *author2;
@property(nonatomic,retain) UILabel *author3;
@property(nonatomic,retain) UILabel *author4;

@property(nonatomic,retain) NSString *pid1;
@property(nonatomic,retain) NSString *pid2;
@property(nonatomic,retain) NSString *pid3;
@property(nonatomic,retain) NSString *pid4;

@end
