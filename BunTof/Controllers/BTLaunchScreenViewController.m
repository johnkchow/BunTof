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
    AVAudioPlayer *audioPlayer;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - UIViewController lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, CGFLOAT_MAX);
    self.titleLabel = [[UILabel alloc] initWithFrame:frame];
    self.titleLabel.text = @"Bun + Tof";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:@"Peralta" size: 50.0f];
    self.continueButton.alpha = 0;
    [self setupInitialTitleLabelFrame];
    [self.view addSubview:self.titleLabel];
    self.title = @"";
    
#ifdef DEBUG
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
    [[gesture rac_gestureSignal] subscribeNext:^(id x) {
        [self setupInitialTitleLabelFrame];
        [self setupAnimator];
    }];
    [self.view addGestureRecognizer:gesture];
#endif
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self performSelector:@selector(setupAnimator) withObject:nil afterDelay:1.0f];
    NSError* error;
    NSURL* fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"everything_is_awesome" ofType:@"m4a"]];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    [audioPlayer prepareToPlay];
    if ([[AVAudioSession sharedInstance] outputVolume] > 0.75)
    {
        audioPlayer.volume = 0.5;
    }
    [self performSelector:@selector(fadeVolumeDown) withObject:nil afterDelay:11];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [audioPlayer play];
}

#pragma mark - Helper methods

-(void) setupInitialTitleLabelFrame
{
    CGRect frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, CGFLOAT_MAX);
    [self.titleLabel sizeToFit];
    CGSize size = self.titleLabel.frame.size;
    frame.origin.x = ceil(self.view.frame.size.width/2 - self.titleLabel.frame.size.width/2);
    frame.origin.y = - size.height;
    frame.size = size;
    NSLog(@"Frame: %@", NSStringFromCGRect(frame));
    self.titleLabel.frame = frame;
}

- (void) fadeVolumeDown
{
    if (audioPlayer.volume > 0.1) {
        audioPlayer.volume = audioPlayer.volume - 0.05;
        [self performSelector:@selector(fadeVolumeDown) withObject:nil afterDelay:0.1];
    }
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
