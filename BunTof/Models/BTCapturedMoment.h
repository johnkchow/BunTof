//
//  BTCapturedMoment.h
//  BunTof
//
//  Created by John Chow on 1/28/14.
//  Copyright (c) 2014 John Chow. All rights reserved.
//


#import "BTLocation.h"

@interface BTCapturedMoment : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, assign) BTLocation *location;
@property (nonatomic, strong) NSDate *date;
@end
