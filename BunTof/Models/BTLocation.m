//
//  BTLocation.m
//  BunTof
//
//  Created by John Chow on 1/28/14.
//  Copyright (c) 2014 John Chow. All rights reserved.
//

#import "BTLocation.h"

@implementation BTLocation

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"lat": @"lat",
             @"lon": @"lon",
             @"name": @"name"
             };
}

@end
