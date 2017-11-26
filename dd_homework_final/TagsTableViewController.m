//
//  ViewController.m
//  dd_homework_final
//
//  Created by Andrey on 26/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "TagsTableViewController.h"
#import "RequestFlickr.h"

@interface TagsTableViewController ()

@end

@implementation TagsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RequestFlickr *rf = [[RequestFlickr alloc] init];
    [rf getHotTags];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
