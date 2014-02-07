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
#import "BTMomentManager.h"
#import <ReactiveCocoa/RACEXTScope.h>

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
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Nav Bar"]];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    @weakify(self);
    self.moments = @[];
    [RACObserve(self, moments) subscribeNext:^(NSArray *moments) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    RACSignal *fetchMoments = [[[BTMomentManager sharedManager] fetchAll]
                               deliverOn: [RACScheduler mainThreadScheduler]];
    
    [fetchMoments subscribeNext:^(NSArray* moments) {
        @strongify(self);
        NSLog(@"Subscribe Next %lu moments: %@", (unsigned long)self.moments.count, self.moments);
        self.moments = moments;
    } error:^(NSError *error) {
        NSLog(@"Error fetching: %@", error);
    } completed:^{
        @strongify(self);
        NSLog(@"Subscribe completion %lu moments: %@", (unsigned long)self.moments.count, self.moments);
        [self.tableView reloadData];
    }];
    
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
