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
@synthesize finalItems, finalPrices, postTable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    postTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-194) style:UITableViewStylePlain];
    postTable.dataSource = self;
    postTable.delegate = self;
    postTable.backgroundColor = [UIColor clearColor];
    postTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //postTable.separatorColor = [UIColor blackColor];
    [self.view addSubview:postTable];
}

- (void)viewDidLoad
{
    UIImage *patternImage = [UIImage imageNamed:@"fabric_plaid.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage]; 
    [self createTable];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self 
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Place Order" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 310.0, 160.0, 40.0);
    [self.view addSubview:button];
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

#pragma mark
#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    return [finalItems count]+2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    if(indexPath.row == [finalItems count]){
        return 10;
    }
    return 30;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *PicIdentifier = @"Pic";
    
    CheckCell *cell = (CheckCell *)[tableView dequeueReusableCellWithIdentifier:PicIdentifier];
    
    if (cell == nil) {
        cell = [[CheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PicIdentifier];
    }
    if(indexPath.row == [finalItems count]){
        cell.line.text = @"________________________________________________________________________________________________";
        return cell;
    }
    if(indexPath.row == [finalItems count]+1){
        cell.item.text = @"TOTAL:";
        float total = 0;
        for(NSNumber *num in finalPrices)
        {
            total += [num floatValue];
        }
        cell.price.text = [NSString stringWithFormat:@"$%.02f", total];
        return cell;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.item.text = [finalItems objectAtIndex:indexPath.row];
    cell.price.text = [NSString stringWithFormat:@"$%@",[finalPrices objectAtIndex:indexPath.row]];
    //cell.userInteractionEnabled = YES;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //NSString *lid = [NSString stringWithFormat:@"%d", [tableView cellForRowAtIndexPath:indexPath].textLabel.tag];
    
    
    //[self dismissModalViewControllerAnimated:YES];
}


@end
