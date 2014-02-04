//
//  BTMomentManager.h
//  BunTof
//
//  Created by John Chow on 2/2/14.
//  Copyright (c) 2014 John Chow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTMomentManager: NSObject

+(instancetype) sharedManager;

-(RACSignal*) fetchAll;
@end
