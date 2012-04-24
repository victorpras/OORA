//
//  twoImageCell.m
//  rawr
//
//  Created by Justin Huang on 6/24/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "twoImageCell.h"
#import <QuartzCore/QuartzCore.h>



@implementation twoImageCell

@synthesize rightPid, rightView, rightAuthor, leftPid, leftView, leftAuthor, delegate, rightcheck, leftcheck;


- (void)viewDidLoad {
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
    {
        self.opaque = YES;
        
        self.contentView.backgroundColor = [UIColor clearColor];
        
        rightView = [[UIImageView alloc] initWithFrame:CGRectMake(170, 21, 130, 130)];
        [self.contentView addSubview:rightView];
        [rightView setUserInteractionEnabled:YES];   
        
        rightcheck = [[UIImageView alloc] initWithFrame:CGRectMake(170, 21, 28, 22)];
        rightcheck.image = [UIImage imageNamed:@"ssSelected"];
        [self.contentView addSubview:rightcheck];
        rightcheck.hidden = YES;
        
        leftView= [[UIImageView alloc] initWithFrame:CGRectMake(20, 21, 130, 130)];
        [self.contentView addSubview:leftView];
        [leftView setUserInteractionEnabled:YES];
        
        leftcheck= [[UIImageView alloc] initWithFrame:CGRectMake(20, 21, 28, 22)];
        leftcheck.image = [UIImage imageNamed:@"ssSelected"];
        [self.contentView addSubview:leftcheck];
        leftcheck.hidden = YES;
        
        rightAuthor = [[UILabel alloc] initWithFrame:CGRectMake(170, 5, 130, 15)];
        rightAuthor.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(15.0)];
        rightAuthor.textColor = [UIColor blackColor];
        //rightAuthor.highlightedTextColor = [UIColor whiteColor];
        rightAuthor.backgroundColor = self.contentView.backgroundColor;
        [self.contentView addSubview:rightAuthor];
        
        leftAuthor = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 130, 15)];
        leftAuthor.textColor = [UIColor blackColor];
        leftAuthor.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(15.0)];
        leftAuthor.highlightedTextColor = [UIColor blackColor];
        leftAuthor.backgroundColor = self.contentView.backgroundColor;
        [self.contentView addSubview:leftAuthor];
        
        
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"----TOUCHED----");
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSLog(@"----%@----", NSStringFromCGPoint(point));
    
    if(CGRectContainsPoint(CGRectMake(20, 21, 130, 130), point)){
        NSLog(@"pid: %@", leftPid);
        [[self delegate] addToCheck: leftPid];
        leftcheck.hidden = !leftcheck.hidden;
    }
    if(CGRectContainsPoint(CGRectMake(170, 21, 130, 130), point)){
        NSLog(@"pid: %@", rightPid);
        [[self delegate] addToCheck: rightPid];
        rightcheck.hidden = !rightcheck.hidden;
    }
}
- (void)dealloc
{
    self.rightView = nil;
    self.leftView = nil;
    self.rightAuthor = nil;
    self.leftAuthor = nil;
    
}
@end