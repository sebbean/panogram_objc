//
//  FeedManager.h
//  PanoGram
//
//  Created by Sebastian Bean on 11/3/14.
//  Copyright (c) 2014 Gin Lane. All rights reserved.
//

#import <AFNetworking.h>


@interface FeedManager : AFHTTPRequestOperationManager

//+ (FeedManager*)sharedManager;
- (void)GETPosts_complete:(void (^)(NSDictionary *items, NSError *error))complete;
@end
