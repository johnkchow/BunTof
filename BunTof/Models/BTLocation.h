//
//  BTLocation.h
//  BunTof
//
//  Created by John Chow on 1/28/14.
//  Copyright (c) 2014 John Chow. All rights reserved.
//

#import "MTLModel.h"

@interface BTLocation : MTLModel <MTLJSONSerializing>

//@property (nonatomic, assign) CGFloat lat;
//@property (nonatomic, assign) CGFloat lon;
@property (nonatomic, strong) NSString *name;

@end