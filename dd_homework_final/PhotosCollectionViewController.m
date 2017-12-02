//
//  PhotosCollectionViewController.m
//  dd_homework_final
//
//  Created by Andrey on 28/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "RequestFlickr.h"

@interface PhotosCollectionViewController () {
    NSArray *idsPhoto;
    NSMutableArray *photos;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end

@implementation PhotosCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    photos = [[NSMutableArray alloc] init];
    
    RequestFlickr *rf = [[RequestFlickr alloc] init];
    [rf photosSearchOnTag:_tag];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(photoIdReceived:)
                                                 name:RequestFlickrPhotoIdOnTagNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(httpsReceived:)
                                                 name:RequestFlickrPhotoHttpsOnTagNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(photoReceived:)
                                                 name:RequestFlickrGetPhotoNotification
                                               object:nil];
}

-(void)photoIdReceived:(NSNotification *)notification {
    NSDictionary *dictionaryNotification = notification.userInfo;
    idsPhoto = dictionaryNotification[RequestFlickrPhotoIdUserInfoKey];
    NSLog(@"%@", idsPhoto);
    
    RequestFlickr *rf = [[RequestFlickr alloc] init];
    for (NSString *id in idsPhoto) {
        [rf getPhotoOnId:id size:@"Thumbnail"];
    }
}

-(void)httpsReceived:(NSNotification *)notification {
    NSDictionary *dictionaryNotification = notification.userInfo;
    NSString *https = dictionaryNotification[RequestFlickrPhotoHttpsUserInfoKey];
    
    RequestFlickr *rf = [[RequestFlickr alloc] init];
    [rf getPhoto:https];
}

-(void)photoReceived:(NSNotification *)notification {
    NSDictionary *dictionaryNotification = notification.userInfo;
    [photos addObject:dictionaryNotification[RequestFlickrGetPhotoUserInfoKey]];
    _collectionView.reloadData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
