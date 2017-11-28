//
//  ViewController.m
//  dd_homework_final
//
//  Created by Andrey on 26/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "TagsTableViewController.h"
#import "RequestFlickr.h"

@interface TagsTableViewController () {
    NSArray *hotTags;
}

@property (strong, nonatomic) IBOutlet UITableView *tableHotTags;

@end

@implementation TagsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RequestFlickr *rf = [[RequestFlickr alloc] init];
    [rf getHotTags];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hotTagsReceived:)
                                                 name:RequestFlickrGetHotTagsNotification
                                               object:nil];
}

-(void)hotTagsReceived:(NSNotification *)notification {
    NSDictionary *dictionaryNotification = notification.userInfo;
    hotTags = dictionaryNotification[RequestFlickrHotTagsUserInfoKey];
    [_tableHotTags reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [hotTags count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"IDDQD";
    
    UITableViewCell *cell = [_tableHotTags dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.text = [hotTags objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

@end
