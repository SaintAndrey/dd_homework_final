//
//  RequestFlickr.m
//  dd_homework_final
//
//  Created by Andrey on 26/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "RequestFlickr.h"
#import "JSONParser.h"

@interface RequestFlickr()

@property NSURLSession *session;

@end

@implementation RequestFlickr

-(instancetype)init {
    NSURLSessionConfiguration *configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:nil
                                                     delegateQueue:nil];
    return self;
}

- (void)getHotTags {
    NSString *requestGetHotTags = @"https://api.flickr.com/services/rest/?method=flickr.tags.getHotList&api_key=8600137d80a1058ebefd7d2a06d77f4e&count=12&format=json&nojsoncallback=1";
    
    NSURL *urlGetHotTags = [NSURL URLWithString:requestGetHotTags];
    

    NSURLSessionDataTask *task = [_session dataTaskWithURL:urlGetHotTags completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        JSONParser *jp = [[JSONParser alloc] init];
        NSArray *hotTags = [jp parseTagsFromTagsGetHotList:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate updateHotTagsTable:hotTags];
        });
    }];

    [task resume];
}

- (void)photosSearchOnTag:(NSString *)tag {
    NSString *requestPhotoSearchOnTag = [NSString stringWithFormat:@"%@%@%@",
                                         @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=8600137d80a1058ebefd7d2a06d77f4e&tags=",
                                         tag,
                                         @"&per_page=12&format=json&nojsoncallback=1"];
    
    NSURL *urlPhotoSearchOnTag = [NSURL URLWithString:requestPhotoSearchOnTag];
    
//    NSURLSessionConfiguration *configuration =
//    [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
//                                                          delegate:self
//                                                     delegateQueue:nil];
    NSURLSessionDataTask *task = [_session dataTaskWithURL:urlPhotoSearchOnTag completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        JSONParser *jp = [[JSONParser alloc] init];
        NSArray *photoId = [jp parseIdFromPhotosSearch:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate recivePhotosId:photoId];
        });
    }];
    
    [task resume];
}

- (void)getPhoto:(NSString *)https {
    NSURL *url = [NSURL URLWithString:https];
    
//    NSURLSessionConfiguration *configuration =
//    [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
//                                                          delegate:self
//                                                     delegateQueue:nil];
    NSURLSessionDataTask *task = [_session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self.delegate recivePhotoData:data];
//        NSLog(@"%@", https);
    }];
    
    [task resume];
}

- (void)getPhotoOnId:(NSString *)id size:(NSString *)size {
    NSString *requestHttpsPhoto = [NSString stringWithFormat:@"%@%@%@",
                                   @"https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=8600137d80a1058ebefd7d2a06d77f4e&photo_id=",
                                   id,
                                   @"&format=json&nojsoncallback=1"];
    NSURL *urlHttpsPhoto = [NSURL URLWithString:requestHttpsPhoto];
    
//    NSURLSessionConfiguration *configuration =
//    [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
//                                                          delegate:self
//                                                     delegateQueue:nil];
    NSURLSessionDataTask *task = [_session dataTaskWithURL:urlHttpsPhoto completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        JSONParser *jp = [[JSONParser alloc] init];
        NSArray *httpsPhotoAndSize = [jp parseHttpsFromPhotos:data];
        
        NSString *https;
        for (NSDictionary *item in httpsPhotoAndSize) {
            if ([[item objectForKey:@"label"] isEqualToString:size]) {
                https = [item objectForKey:@"source"];
                break;
            }
        }
        
        [self getPhoto:https];
    }];
    
    [task resume];
}

@end
