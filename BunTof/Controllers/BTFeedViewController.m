//
//  BTFeedViewController.m
//  BunTof
//
//  Created by John Chow on 1/28/14.
//  Copyright (c) 2014 John Chow. All rights reserved.
//

#import "BTFeedViewController.h"
#import "BTCapturedMoment.h"
#import "BTFeedViewCell.h"

@interface BTFeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BTFeedViewController

static NSString* cellIdentifier = @"FeedViewCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"BTFeedViewCell" bundle:nil] forCellReuseIdentifier: cellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSDictionary *dictionary = @{
                                 @"location": @{
                                         @"lat": @"37.7577",
                                         @"lon": @"-122.4376,12",
                                         @"name": @"Delfina"
                                         },
                                 @"image_url": @"http://distilleryimage1.ak.instagram.com/da85292c88a011e39bd0129dfc2dce15_8.jpg",
                                 @"description": @"This is one amazing pizza",
                                 @"date": @"2014-01-28 22:18:36 -0800"
                                 };
    NSError *error;
    BTCapturedMoment *moment = [MTLJSONAdapter modelOfClass:BTCapturedMoment.class fromJSONDictionary:dictionary error:&error];
    self.moments = @[moment];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.moments.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400.0f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTFeedViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    cell.moment = self.moments[indexPath.row];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTFeedViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];

    cell.moment = self.moments[indexPath.row];
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

@end
