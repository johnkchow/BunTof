//
//  BTFeedViewCell.m
//  BunTof
//
//  Created by John Chow on 1/28/14.
//  Copyright (c) 2014 John Chow. All rights reserved.
//

#import "BTFeedViewCell.h"

@interface BTFeedViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation BTFeedViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void) awakeFromNib
{
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
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
    self.locationLabel.text = self.moment.location.name;
    self.descriptionLabel.text = self.moment.description;
    [self.mainImageView setImageWithURL: self.moment.imageURL];
//    NSURLRequest *request = [NSMutableURLRequest requestWithURL: self.moment.imageURL];
//    typeof(self) __weak _self = self;
//    [self.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
////        NSLog(@"ImageView bounds before: %@", NSStringFromCGRect(_self.imageView.bounds));
////        NSLog(@"ImageView frame before: %@", NSStringFromCGRect(_self.imageView.frame));
//        _self.imageView.image = image;
////        NSLog(@"ImageView frame after: %@", NSStringFromCGRect(_self.imageView.frame));
////        NSLog(@"ImageView bounds after: %@", NSStringFromCGRect(_self.imageView.bounds));
//    } failure:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
