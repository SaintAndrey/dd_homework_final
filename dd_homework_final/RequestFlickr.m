//
//  RequestFlickr.m
//  dd_homework_final
//
//  Created by Andrey on 26/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "RequestFlickr.h"
#import "JSONParser.h"

NSString * const RequestFlickrGetHotTagsNotification = @"RequestFlickrGetHotTagsNotification";
NSString * const RequestFlickrHotTagsUserInfoKey = @"RequestFlickrHotTagsUserInfoKey";
NSString * const RequestFlickrPhotoIdOnTagNotification = @"RequestFlickrPhotoIdOnTagNotification";
NSString * const RequestFlickrPhotoIdUserInfoKey = @"RequestFlickrPhotoIdUserInfoKey";
NSString * const RequestFlickrGetPhotoNotification = @"RequestFlickrGetPhotoNotification";
NSString * const RequestFlickrGetPhotoUserInfoKey = @"RequestFlickrGetPhotoUserInfoKey";
NSString * const RequestFlickrPhotoHttpsOnTagNotification = @"RequestFlickrPhotoHttpsOnTagNotification";
NSString * const RequestFlickrPhotoHttpsUserInfoKey = @"RequestFlickrPhotoHttpsUserInfoKey";

@interface RequestFlickr() <NSURLSessionDownloadDelegate>

@property(nonatomic, copy) void(^successBlock)(NSData *);

@end

@implementation RequestFlickr

- (void)getHotTags {
    NSString *requestGetHotTags = @"https://api.flickr.com/services/rest/?method=flickr.tags.getHotList&api_key=8600137d80a1058ebefd7d2a06d77f4e&count=12&format=json&nojsoncallback=1";
    
    NSURL *urlGetHotTags = [NSURL URLWithString:requestGetHotTags];
    
    [self retrieveURL:urlGetHotTags successBlock:^(NSData *data) {
        JSONParser *jp = [[JSONParser alloc] init];
        NSArray *hotTags = [jp parseTagsFromTagsGetHotList:data];
        
        NSDictionary *dictionaryHotTags = [NSDictionary dictionaryWithObject:hotTags
                                                                             forKey:RequestFlickrHotTagsUserInfoKey];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RequestFlickrGetHotTagsNotification
                                                            object:nil
                                                          userInfo:dictionaryHotTags];
    }];
}

- (void)photosSearchOnTag:(NSString *)tag {
    NSString *requestPhotoSearchOnTag = [NSString stringWithFormat:@"%@%@%@",
                                   @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=8600137d80a1058ebefd7d2a06d77f4e&tags=",
                                   tag,
                                   @"&per_page=12&format=json&nojsoncallback=1"];
    
    NSURL *urlPhotoSearchOnTag = [NSURL URLWithString:requestPhotoSearchOnTag];
    
    [self retrieveURL:urlPhotoSearchOnTag successBlock:^(NSData *data) {
        JSONParser *jp = [[JSONParser alloc] init];
        NSArray *photoId = [jp parseIdFromPhotosSearch:data];
        
        NSDictionary *dictionaryPhotoId = [NSDictionary dictionaryWithObject:photoId
                                                                      forKey:RequestFlickrPhotoIdUserInfoKey];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RequestFlickrPhotoIdOnTagNotification
                                                            object:nil
                                                          userInfo:dictionaryPhotoId];
    }];
}

- (void)getPhoto:(NSString *)https {
    NSURL *url = [NSURL URLWithString:https];
    [self retrieveURL:url successBlock:^(NSData *data) {
        
        NSDictionary *dictionaryPhotoId = [NSDictionary dictionaryWithObject:data
                                                                      forKey:RequestFlickrGetPhotoUserInfoKey];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RequestFlickrGetPhotoNotification
                                                            object:nil
                                                          userInfo:dictionaryPhotoId];
        
    }];
}

- (void)getPhotoOnId:(NSString *)id size:(NSString *)size {
    NSString *requestHttpsPhoto = [NSString stringWithFormat:@"%@%@%@",
                                   @"https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=8600137d80a1058ebefd7d2a06d77f4e&photo_id=",
                                   id,
                                   @"&format=json&nojsoncallback=1"];
    NSURL *urlHttpsPhoto = [NSURL URLWithString:requestHttpsPhoto];
    
    [self retrieveURL:urlHttpsPhoto successBlock:^(NSData *data) {
        JSONParser *jp = [[JSONParser alloc] init];
        NSArray *httpsPhotoAndSize = [jp parseHttpsFromPhotos:data];
        
        NSString *https;
        for (NSDictionary *item in httpsPhotoAndSize) {
            if ([[item objectForKey:@"label"] isEqualToString:size]) {
                https = [item objectForKey:@"source"];
                break;
            }
        }

        NSDictionary *httpsPhoto = [NSDictionary dictionaryWithObject:https
                                                                          forKey:RequestFlickrPhotoHttpsUserInfoKey];
            
        [[NSNotificationCenter defaultCenter] postNotificationName:RequestFlickrPhotoHttpsOnTagNotification
                                                                object:nil
                                                              userInfo:httpsPhoto];

    }];
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.successBlock(data);
    });
}

- (void)retrieveURL:(NSURL *)url successBlock:(void(^)(NSData *))successBlock {
    self.successBlock = successBlock;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    
    [task resume];
}

@end
