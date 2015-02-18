
//  BTMomentManager.m
//  BunTof
//
//  Created by John Chow on 2/2/14.
//  Copyright (c) 2014 John Chow. All rights reserved.
//

#import "BTMomentManager.h"
#import "BTCapturedMoment.h"

@interface BTMomentManager ()
@property (nonatomic, strong) AFHTTPRequestOperationManager* httpManager;

@end

@implementation BTMomentManager

+(instancetype) sharedManager
{
    static BTMomentManager *manager;
    if (!manager)
    {
        manager = [[self alloc] init];
    }
    return manager;
}

- (instancetype) init
{
    if (self = [super init])
    {
        NSString *apiBaseURL = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"API_BASE_URL"];
        NSURL *baseURL = [NSURL URLWithString:apiBaseURL];
        self.httpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    }
    return self;
}

- (RACSignal*) fetchAll
{
    return [[[[self.httpManager rac_GET:@"moments.json" parameters:nil] flattenMap:^id(RACTuple *tuple) {
        NSArray *serializedMoments = tuple[1];
//        NSLog(@"Fetch serialized moments complete: %@", serializedMoments);
        return [[serializedMoments.rac_sequence.signal flattenMap:^RACStream *(NSDictionary *serializedMoment) {
            NSError *error;
            BTCapturedMoment* moment = [MTLJSONAdapter modelOfClass:BTCapturedMoment.class fromJSONDictionary:serializedMoment error:&error];
            if(error)
                return [RACSignal error:error];
            else
                return [RACSignal return:moment];
        }] collect];
    }] publish] autoconnect];
}
@end