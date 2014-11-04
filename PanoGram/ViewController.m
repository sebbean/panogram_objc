//
//  ViewController.m
//  PanoGram
//
//  Created by Sebastian Bean on 11/3/14.
//  Copyright (c) 2014 Gin Lane. All rights reserved.
//

#import "ViewController.h"

#import "FeedManager.h"
#import <UIImageView+AFNetworking.h>


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) NSArray *assets;
@property (nonatomic, strong) FeedManager *feedManager;
@end

@implementation ViewController


- (FeedManager*)feedManager {
    if(!_feedManager) {
        _feedManager = [[FeedManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost:3001"]];
    }
    return _feedManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.feedManager GETPosts_complete:^(NSDictionary *items, NSError *error) {
        self.posts = items[@"posts"];
        self.assets = items[@"assets"];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:10];
    NSDictionary *post = self.posts[indexPath.row];
    
//    cell.textLabel.text = post[@"caption"];
    
    NSArray *assets = [self.assets filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id IN %@", post[@"asset_ids"]]];
    NSDictionary *asset = assets.lastObject;
    NSURL *assetUrl = [self.feedManager.baseURL URLByAppendingPathComponent:asset[@"url"]];
    NSLog(@" asset url %@", assetUrl);
    [imageView setImageWithURL:assetUrl];
    
    return cell;
}

@end
