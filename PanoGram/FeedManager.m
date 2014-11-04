//
//  FeedManager.m
//  PanoGram
//
//  Created by Sebastian Bean on 11/3/14.
//  Copyright (c) 2014 Gin Lane. All rights reserved.
//

#import "FeedManager.h"

@implementation FeedManager

//+ (FeedManager*)sharedManager {
//    static FeedManager *shared = nil;
//    if(!shared) {
//        shared = [[FeedManager alloc] init];
//    }
//    return shared;
//}

- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    return self;
}

+ (NSString *)applicationDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

+ (NSFileManager*)fileManager {
    return [NSFileManager defaultManager];
}
- (NSFileManager*)fileManager {
    return [[self class] fileManager];
}

- (void)GETPosts_complete:(void (^)(NSDictionary *items, NSError *error))complete {
    
    [self GET:@"posts" parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         complete(responseObject, nil);
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
        complete(nil, error);
     }];
}


@end
