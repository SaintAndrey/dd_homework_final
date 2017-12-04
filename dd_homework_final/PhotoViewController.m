//
//  PhotoViewController.m
//  dd_homework_final
//
//  Created by Andrey on 02/12/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "PhotoViewController.h"
#import "RequestFlickr.h"

@interface PhotoViewController ()<RequestServer> {
    RequestFlickr *rf;
}

@property (strong, nonatomic) IBOutlet UIImageView *photo;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    rf = [[RequestFlickr alloc] init];
    rf.delegate = self;
    [rf getPhotoOnId:_id size:@"Large"];
}

- (void)recivePhotoData:(NSData *)photo {
    dispatch_async(dispatch_get_main_queue(), ^{
         _photo.image = [[UIImage alloc] initWithData:photo];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
