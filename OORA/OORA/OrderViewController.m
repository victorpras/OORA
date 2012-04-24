//
//  OrderViewController.m
//  OORA
//
//  Created by Justin Huang on 4/15/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "OrderViewController.h"
#import "CheckCell.h"
@interface OrderViewController ()

@end

@implementation OrderViewController
@synthesize finalItems, finalPrices, postTable, facebook, profile;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setFrame:CGRectMake(100, 0, 56, 27)];
        [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [back setImage:[UIImage imageNamed:@"iconBack"] forState:UIControlStateNormal];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:back];
        self.navigationItem.leftBarButtonItem = backButton;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:26];
        label.shadowColor = [UIColor colorWithWhite:0.5 alpha:0.1];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor redColor]; // change this color
        self.navigationItem.titleView = label;
        label.text = NSLocalizedString(@"ordr", @"");
        [label sizeToFit];

    }
    return self;
}

- (id)initWithOrder:(NSDictionary*)list {
    self = [super init];
    self.finalItems = [list allKeys];
    self.finalPrices = [list allValues];
    self.navigationItem.title=@"Check";
    return self;
}

-(void)createTable{
    postTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 65, 300, self.view.bounds.size.height-110) style:UITableViewStylePlain];
    postTable.dataSource = self;
    postTable.delegate = self;
    postTable.backgroundColor = [UIColor clearColor];
    postTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //postTable.separatorColor = [UIColor blackColor];
    [self.view addSubview:postTable];
}

- (void)viewDidLoad
{
    UIImage *patternImage = [UIImage imageNamed:@"background"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage]; 
    [self createTable];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemBookmarks target:self action:@selector(selectTemplate)];
    
    facebook = [PFFacebookUtils facebook];
    [facebook requestWithGraphPath:@"me/picture" andDelegate:self];
    UIImageView *friendAdder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ssSearchBarEdit"]];
    UIView *friendAdderView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 320, 55)];
    [friendAdderView addSubview:friendAdder];
    [self.view addSubview:friendAdderView];
    
    UITextField *number = [[UITextField alloc] initWithFrame:CGRectMake(14, 20, 240, 40)];
    number.font = [UIFont systemFontOfSize:20];
    number.placeholder = @"Add a friend!";
    [self.view addSubview:number];
    
    UIButton *plus = [UIButton buttonWithType:UIButtonTypeCustom];
    plus.frame = CGRectMake(270, 14, 33, 33);
    plus.backgroundColor = [UIColor clearColor];
    UIImage *buttonImageNormalP = [UIImage imageNamed:@"moveGroupPlus"];
    [plus setBackgroundImage:buttonImageNormalP forState:UIControlStateNormal];
    UIImage *buttonImagePressedP = [UIImage imageNamed:@"moveGroupPlusSelected"];
    [plus setBackgroundImage:buttonImagePressedP forState:UIControlStateHighlighted];
    [plus addTarget:self action:@selector(addGroup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:plus];
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self 
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Place Order" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 310.0, 160.0, 40.0);
    [self.view addSubview:button];
     */
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
- (void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    //return [finalItems count]+2;
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    if(indexPath.row == 1){
        return 10;
    }
    if(indexPath.row == 2){
        return 50;
    }
    return 140;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *PicIdentifier = @"Pic";
    
    CheckCell *cell = (CheckCell *)[tableView dequeueReusableCellWithIdentifier:PicIdentifier];
    
    if (cell == nil) {
        cell = [[CheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PicIdentifier];
    }/*
    if(indexPath.row == [finalItems count]){
        cell.line.text = @"________________________________________________________________________________________________";
        cell.backgroundView.hidden = YES;
        return cell;
    }
    if(indexPath.row == [finalItems count]+1){
        cell.item1.text = @"TOTAL:";
        float total = 0;
        for(NSNumber *num in finalPrices)
        {
            total += [num floatValue];
        }
        cell.price1.text = [NSString stringWithFormat:@"$%.02f", total];
        cell.backgroundView.hidden = YES;
        return cell;
    }*/
    if(indexPath.row ==1){
        cell.line.text = @"________________________________________________________________________________________________";
        cell.backgroundView.hidden = YES;
        return cell;
        
    }
    if(indexPath.row == 2){
        cell.item1.text = @"TOTAL:";
        float total = 0;
        for(NSNumber *num in finalPrices)
        {
            total += [num floatValue];
        }
        cell.price1.text = [NSString stringWithFormat:@"$%.02f", total];
        cell.backgroundView.hidden = YES;
        return cell;
    }
    else{
        cell.profile.image = profile;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if([finalItems count] >0){
            cell.item1.text = [finalItems objectAtIndex:indexPath.row];
            cell.price1.text = [NSString stringWithFormat:@"$%@",[finalPrices objectAtIndex:indexPath.row]];
        }
        
        if([finalItems count] >1){
            cell.item2.text = [finalItems objectAtIndex:indexPath.row+1];
            cell.price2.text = [NSString stringWithFormat:@"$%@",[finalPrices objectAtIndex:indexPath.row+1]];
        }
        if([finalItems count] >2){
            cell.item3.text = [finalItems objectAtIndex:indexPath.row+2];
            cell.price3.text = [NSString stringWithFormat:@"$%@",[finalPrices objectAtIndex:indexPath.row+2]];
        }
        
    }
    
    
    
    //cell.userInteractionEnabled = YES;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //NSString *lid = [NSString stringWithFormat:@"%d", [tableView cellForRowAtIndexPath:indexPath].textLabel.tag];
    
    
    //[self dismissModalViewControllerAnimated:YES];
}

- (void)request:(PF_FBRequest *)request didLoad:(id)result {
    profile = [UIImage imageWithData:result];
    [postTable reloadData];
}

@end
