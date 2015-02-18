//
//  BTCardViewController.m
//  BunTof
//
//  Created by John Chow on 2/12/14.
//  Copyright (c) 2014 John Chow. All rights reserved.
//

#import "BTCardViewController.h"

@interface BTCardViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *messageView;

@end

@implementation BTCardViewController

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
    self.textView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Nav Bar"]];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithRed:243.0f/255 green:243.0f/255 blue:243.0f/255 alpha:1.0f];
    self.textView.backgroundColor = [UIColor colorWithRed:243.0f/255 green:243.0f/255 blue:243.0f/255 alpha:1.0f];
    self.title = @"";
    self.messageView.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MESSAGE"];

    self.edgesForExtendedLayout = UIRectEdgeNone;

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
