//
//  BTLastItemViewCell.m
//  BunTof
//
//  Created by John Chow on 2/13/14.
//  Copyright (c) 2014 John Chow. All rights reserved.
//

#import "BTLastItemViewCell.h"

@interface BTLastItemViewCell ()
@property (weak, nonatomic) IBOutlet AMAttributedHighlightLabel *noteLabel;

@end

@implementation BTLastItemViewCell

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
    [super awakeFromNib];
    [self initStyle];
}

- (void) initStyle
{
    NSString *note =
    @"That's all the pics of 2013 we've had together... I hope you had a blast reliving the past year that we had together. I know I did. I got hella nostalgic for New York and Hawaii! I know 2014 is going to be an amazing year for both of us :)\n\n"
    "Happy Valentines Day :) I ❤️ You \n\n#bunlovestof #happyvday #theend";
    
    self.noteLabel.textColor = [UIColor colorWithWhite:51.0f/255 alpha:1.0f];
    self.noteLabel.hashtagTextColor = [UIColor blackColor];
    UIFont* font = self.noteLabel.font;
    UIFont *boldFont = [UIFont boldSystemFontOfSize:font.pointSize];
    self.noteLabel.hashtagFont = boldFont;

    [self.noteLabel setString: note];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

@end
