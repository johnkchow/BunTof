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
    self.tableView.backgroundColor = [UIColor colorWithRed:243.0f/255 green:243.0f/255 blue:243.0f/255 alpha:1.0f];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Nav Bar"]];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.moments = @[];
    
    @weakify(self);
    [RACObserve(self, moments) subscribeNext:^(NSArray *moments) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
#ifdef DEBUG
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:nil action:nil];
    reloadButton.tintColor = [UIColor colorWithRed:241.0f/255 green:100.0f/255 blue:73.0f/255 alpha:1.0f];
    reloadButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [self fetchMoments];
    }];
    self.navigationItem.rightBarButtonItem = reloadButton;
    
    UITapGestureRecognizer* scrollToBottomGesture = [[UITapGestureRecognizer alloc] init];
    scrollToBottomGesture.numberOfTapsRequired = 2;
    
    CGSize size = self.view.frame.size;
    NSLog(@"Size of view: %@", NSStringFromCGSize(size));
    CGRect damageRect = CGRectMake(0.0f, 0.75f * size.height, size.width, 0.25f * size.height);
    
    [[[scrollToBottomGesture rac_gestureSignal] filter:^BOOL(UITapGestureRecognizer* gesture) {
        CGPoint p = [gesture locationInView:self.view];
        return CGRectContainsPoint(damageRect, p);
    }] subscribeNext:^(id x) {
        NSIndexPath* bottomRow = [NSIndexPath indexPathForRow: self.moments.count - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:bottomRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }];
    [self.view addGestureRecognizer: scrollToBottomGesture];
#endif
    
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] init];
    [self.navigationItem.titleView addGestureRecognizer: gesture];
    self.navigationItem.titleView.userInteractionEnabled = YES;
    [[gesture rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer* sender) {
        
        @strongify(self);
        [self.tableView setContentOffset:CGPointZero animated:YES];
    }];
    
    [self fetchMoments];
}

- (RACSignal*) fetchMoments
{
    RACSignal *fetchMoments = [[[BTMomentManager sharedManager] fetchAll]
                               deliverOn: [RACScheduler mainThreadScheduler]];
    
    @weakify(self);
    [fetchMoments subscribeNext:^(NSArray* moments) {
        @strongify(self);
        NSLog(@"Subscribe Next %lu moments: %@", (unsigned long)self.moments.count, self.moments);
        self.moments = moments;
    } error:^(NSError *error) {
        NSLog(@"Error fetching: %@", error);
    } completed:^{
        @strongify(self);
//        NSLog(@"Subscribe completion %lu moments: %@", (unsigned long)self.moments.count, self.moments);
    }];
    
    return fetchMoments;
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
    NSLog(@"Row: %ld, Height: %ld", (long)indexPath.row, (long)height);
    return height + 1;
}

@end
