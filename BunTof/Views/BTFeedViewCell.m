//
//  BTFeedViewCell.m
//  BunTof
//
//  Created by John Chow on 1/28/14.
//  Copyright (c) 2014 John Chow. All rights reserved.
//

#import "BTFeedViewCell.h"
#import <AMAttributedHighlightLabel.h>

@interface BTFeedViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet AMAttributedHighlightLabel *descriptionLabel;

@end

@implementation BTFeedViewCell
{
    BOOL _loadedConstraints;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initStyle];
    }
    return self;
}

- (void) awakeFromNib
{
    [self initStyle];
}

- (void) initStyle
{
    self.backgroundColor = [UIColor colorWithRed:243.0f/255 green:243.0f/255 blue:243.0f/255 alpha:1.0f];
    self.descriptionLabel.textColor = [UIColor colorWithWhite:51.0f/255 alpha:1.0f];
    self.descriptionLabel.hashtagTextColor = [UIColor blackColor];
    UIFont* font = self.descriptionLabel.font;
    UIFont *boldFont = [UIFont boldSystemFontOfSize:font.pointSize];
    self.descriptionLabel.hashtagFont = boldFont;
}

- (void) setMoment:(BTCapturedMoment *)moment
{
    _moment = moment;
    [self updateViewsWithMoment];
}

- (void)updateViewsWithMoment
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"MMM d ''YY"];
    self.dateLabel.text = [dateFormatter stringFromDate: self.moment.date];
    if (self.moment.location)
    {
        self.locationLabel.text = self.moment.location.name;
    }
    [self.descriptionLabel setString:self.moment.momentDescription];
    NSURL *baseURL = [NSURL URLWithString:IMAGE_BASE_URL];
    NSURL *imageURL = [NSURL URLWithString:self.moment.imageURL.relativePath relativeToURL:baseURL];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL: imageURL];
    typeof(self) __weak _self = self;
    [self.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        _self.mainImageView.alpha = 0.0f;
        _self.mainImageView.image = image;
        [UIView animateWithDuration:0.3f animations:^{
            _self.mainImageView.alpha = 1.0f;
        }];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    if (_loadedConstraints)
        return;
    
    UILabel *dateLabel = self.dateLabel;
    UILabel *locationLabel = self.locationLabel;
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(dateLabel, locationLabel);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[dateLabel]-(>=10)-[locationLabel]" options:0 metrics:nil views:viewDictionary];
    [self addConstraints:constraints];
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    /*This is to prevent the label height from calculating to 0.5 pixel, which
     causes text to be cut off*/
    CGRect rect = self.descriptionLabel.frame;
    rect.size.height = ceil(self.descriptionLabel.frame.size.height);
    self.descriptionLabel.frame = rect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

@end
