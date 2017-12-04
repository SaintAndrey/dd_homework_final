//
//  ViewController.m
//  dd_homework_final
//
//  Created by Andrey on 26/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "TagsTableViewController.h"
#import "RequestFlickr.h"
#import "PhotosCollectionViewController.h"
#import "JSONParser.h"

@interface TagsTableViewController ()<RequestServer> {
    NSArray *hotTags;
    RequestFlickr *rf;
}

@property (strong, nonatomic) IBOutlet UITableView *tableHotTags;

@end

@implementation TagsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    rf = [[RequestFlickr alloc] init];
    rf.delegate = self;
    [rf getHotTags];
}

- (void)updateHotTagsTable:(NSArray *)tags {
    hotTags = tags;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showCollectionPhotos" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showCollectionPhotos"]) {
        NSIndexPath *indexPath = [self.tableHotTags indexPathForSelectedRow];
        PhotosCollectionViewController *pcvc = segue.destinationViewController;
        pcvc.tag = [hotTags objectAtIndex:indexPath.row];
    }
}

@end
