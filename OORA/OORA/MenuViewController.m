//
//  MenuViewController.m
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "MenuViewController.h"
#import <Parse/PFQuery.h>
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "OrderViewController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize postTable, restaurant, items, check;
- (void) addToCheck: (NSNumber*)pid{
    if([check containsObject:pid]){
        [check removeObject:pid];
    }
    else{
        [self.check addObject:pid];
        NSLog(@"NUMBER OF CHECK = %d", [check count]);
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRestaurant:(NSString*)restaurantName items:(NSArray *) menuItems{
    self = [super init];
    self.restaurant = restaurantName;
    self.items = menuItems;
    self.navigationItem.title=restaurantName;
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Finalize" style:UIBarButtonItemStylePlain target:self action:@selector(finalize)];
    self.navigationItem.rightBarButtonItem = next;
    check = [[NSMutableSet alloc] initWithObjects:nil];
    return self;
}

- (void)viewDidLoad
{
    UIImage *patternImage = [UIImage imageNamed:@"fabric_plaid.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage]; 
    
    [self createTable];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)createTable{
    postTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-94) style:UITableViewStylePlain];
    postTable.dataSource = self;
    postTable.delegate = self;
    postTable.backgroundColor = [UIColor clearColor];
    postTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //postTable.separatorColor = [UIColor blackColor];
    [self.view addSubview:postTable];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)finalize{
    NSLog(@"num: %d", [check count]);
    NSArray *finalList= [check allObjects];
    NSMutableArray *finalPrices = [[NSMutableArray alloc] initWithObjects: nil];
    NSMutableArray *finalItems = [[NSMutableArray alloc] initWithObjects: nil];

    for(NSNumber *num in finalList){
        [finalPrices addObject:[[items objectAtIndex:[num intValue]] objectForKey:@"Price"]];
        [finalItems addObject:[[items objectAtIndex:[num intValue]] objectForKey:@"Item"]];
    }
    NSDictionary *finalOrder = [NSDictionary dictionaryWithObjects:finalPrices forKeys:finalItems];
    OrderViewController *aa=[[OrderViewController alloc] initWithOrder:finalOrder];
    [[self navigationController] pushViewController:aa animated:YES];
}


#pragma mark
#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    return ([self.items count]-1)/2 +1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    return 170;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *PicIdentifier = @"Pic";
    
    twoImageCell *cell = (twoImageCell *)[tableView dequeueReusableCellWithIdentifier:PicIdentifier];
    
    if (cell == nil) {
        cell = [[twoImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PicIdentifier];
    }
    [cell setDelegate:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PFObject *menuItem = [items objectAtIndex:(indexPath.row*2)];
    cell.leftAuthor.text = [menuItem objectForKey:@"Item"];
    [cell.leftView setImageWithURL:[NSURL URLWithString:[menuItem objectForKey:@"Picture"]]];
    [cell.leftView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [cell.leftView.layer setBorderWidth: 2.5f];
    cell.leftView.layer.shadowOffset = CGSizeMake(0, 3);
    cell.leftView.layer.shadowOpacity = 0.7;	
    cell.leftView.layer.shouldRasterize = YES;
    cell.leftPid = [NSNumber numberWithInt:indexPath.row*2];
    
    if((indexPath.row*2+1) < [self.items count]){
        PFObject *menuItem2 = [items objectAtIndex:(indexPath.row*2+1)];
        cell.rightAuthor.text = [menuItem2 objectForKey:@"Item"];
        [cell.rightView setImageWithURL:[NSURL URLWithString:[menuItem2 objectForKey:@"Picture"]]];
        [cell.rightView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [cell.rightView.layer setBorderWidth: 2.5f];
        cell.rightView.layer.shadowOffset = CGSizeMake(0, 3);
        cell.rightView.layer.shadowOpacity = 0.7;	
        cell.rightView.layer.shouldRasterize = YES;
        cell.rightPid = [NSNumber numberWithInt:indexPath.row*2+1];

    }
    cell.userInteractionEnabled = YES;
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //NSString *lid = [NSString stringWithFormat:@"%d", [tableView cellForRowAtIndexPath:indexPath].textLabel.tag];
    
    
    //[self dismissModalViewControllerAnimated:YES];
}

@end
