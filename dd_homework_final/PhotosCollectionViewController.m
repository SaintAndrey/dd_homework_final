//
//  PhotosCollectionViewController.m
//  dd_homework_final
//
//  Created by Andrey on 28/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "RequestFlickr.h"
#import "PhotoViewController.h"
#import "JSONParser.h"

@interface PhotosCollectionViewController ()<RequestServer> {
    NSArray *idsPhoto;
    NSMutableArray *photos;
    RequestFlickr *rf;
    NSInteger count;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PhotosCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    count = 0;
    photos = [[NSMutableArray alloc] init];
    rf = [[RequestFlickr alloc] init];
    rf.delegate = self;
    [rf photosSearchOnTag:_tag];

}

- (void)recivePhotosId:(NSArray *)ids {
    idsPhoto = ids;
    [rf getPhotoOnId:[idsPhoto objectAtIndex:count] size:@"Thumbnail"];
}

- (void)recivePhotoData:(NSData *)photo {
    [photos addObject:photo];
    count++;
    if (count != 12) {
        [rf getPhotoOnId:[idsPhoto objectAtIndex:count] size:@"Thumbnail"];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collectionView reloadData];
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showPhoto"]) {
        NSIndexPath *indexPath = sender;
        PhotoViewController *pvc = segue.destinationViewController;
        pvc.id = [idsPhoto objectAtIndex:indexPath.row];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    UIImage *img = [[UIImage alloc] initWithData:[photos objectAtIndex:indexPath.row]];
    
    UIImageView *photoImage = (UIImageView *)[cell viewWithTag:100];
    photoImage.image = img;

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showPhoto" sender:indexPath];
}

@end
