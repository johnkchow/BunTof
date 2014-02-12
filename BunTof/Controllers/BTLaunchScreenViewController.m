//
//  BTLaunchScreenViewController.m
//  BunTof
//
//  Created by John Chow on 2/10/14.
//  Copyright (c) 2014 John Chow. All rights reserved.
//

#import "BTLaunchScreenViewController.h"

@interface BTLaunchScreenViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property UILabel* titleLabel;
@end

@implementation BTLaunchScreenViewController
{
    UIDynamicAnimator *animator;
    UICollisionBehavior *collisionBehavior;
    UIGravityBehavior *gravityBehavior;
}

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
    CGRect frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, CGFLOAT_MAX);
    self.titleLabel = [[UILabel alloc] initWithFrame:frame];
    self.titleLabel.font = [UIFont fontWithName:@"Peralta" size: 50.0f];
    self.continueButton.alpha = 0;
    self.continueButton.tintColor = [UIColor colorWithRed:241.0f/255 green:100.0f/255 blue:73.0f/255 alpha:1.0f];
    [self setupInitialTitleLabel];
    [self.view addSubview:self.titleLabel];
    self.continueButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [self performSegueWithIdentifier:@"Continue" sender:self];
        return [RACSignal empty];
    }];
    
#ifdef DEBUG
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
    [[gesture rac_gestureSignal] subscribeNext:^(id x) {
        [self setupInitialTitleLabel];
        [self setupAnimator];
    }];
    [self.view addGestureRecognizer:gesture];
#endif
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelector:@selector(setupAnimator) withObject:nil afterDelay:1.0f];
}

-(void) setupInitialTitleLabel
{
    
    CGRect frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, CGFLOAT_MAX);
    self.titleLabel.text = @"Bun + Tof";
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.titleLabel sizeToFit];
    CGSize size = self.titleLabel.frame.size;
    frame.origin.x = ceil(self.view.frame.size.width/2 - self.titleLabel.frame.size.width/2);
    frame.origin.y = - size.height;
    frame.size = size;
    NSLog(@"Frame: %@", NSStringFromCGRect(frame));
    self.titleLabel.frame = frame;
}

- (void)setupAnimator
{
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    animator.delegate = self;
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.titleLabel]];
    CGPoint point1 = CGPointMake(0.0, 330.0f);
    CGPoint point2 = CGPointMake(self.view.frame.size.width, 330.0f);
    [collisionBehavior addBoundaryWithIdentifier:@"title bottom" fromPoint:point1 toPoint:point2];
    [animator addBehavior:collisionBehavior];
    
    gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.titleLabel]];
    [animator addBehavior:gravityBehavior];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)an
{
    if (an != self->animator)
        return;
    [UIView animateWithDuration:0.75f animations:^{
        self.continueButton.alpha = 1.0f;
    }];
}

@end
