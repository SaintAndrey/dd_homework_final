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

@interface RequestFlickr() <NSURLSessionDownloadDelegate>

@property(nonatomic, copy) void(^successBlock)(NSData *);

@end

@implementation RequestFlickr

- (void)getHotTags {
    NSString *requestGetHotTags =@"https://api.flickr.com/services/rest/?method=flickr.tags.getHotList&api_key=8600137d80a1058ebefd7d2a06d77f4e&count=12&format=json&nojsoncallback=1";
    
    NSURL *urlGetHotTags = [NSURL URLWithString:requestGetHotTags];
    
    [self retrieveURL:urlGetHotTags successBlock:^(NSData *data) {
        JSONParser *jp = [[JSONParser alloc] init];
        NSArray *hotTags = [jp parseTagsFromGetHotList:data];
        
        NSDictionary *dictionaryHotTags = [NSDictionary dictionaryWithObject:hotTags
                                                                             forKey:RequestFlickrHotTagsUserInfoKey];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RequestFlickrGetHotTagsNotification
                                                            object:nil
                                                          userInfo:dictionaryHotTags];
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
