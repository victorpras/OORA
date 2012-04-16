//
//  twoImageCell.h
//  rawr
//
//  Created by Justin Huang on 6/24/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuDelegate
@required
- (void) addToCheck: (NSNumber*)pid;
@end


@interface twoImageCell : UITableViewCell {
    UIImageView *leftView;
    UIImageView *rightView;
    UILabel *leftAuthor;
    UILabel *rightAuthor;
    NSNumber *leftPid;
    NSNumber *rightPid;
    UIImageView *rightcheck;
    UIImageView *leftcheck;
    id <MenuDelegate> delegate;
}
@property(nonatomic,retain) UIImageView *rightView;
@property(nonatomic,retain) UIImageView *leftView;
@property(nonatomic,retain) UIImageView *rightcheck;
@property(nonatomic,retain) UIImageView *leftcheck;
@property(nonatomic,retain) UILabel *leftAuthor;
@property(nonatomic,retain) UILabel *rightAuthor;
@property(nonatomic) NSNumber *rightPid;
@property(nonatomic) NSNumber *leftPid;
@property (retain) id delegate;

@end
