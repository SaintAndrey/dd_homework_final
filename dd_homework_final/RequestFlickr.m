//
//  RequestFlickr.m
//  dd_homework_final
//
//  Created by Andrey on 26/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "RequestFlickr.h"

@implementation RequestFlickr

- (void)getHotTags {
    NSString *dataUrl =@"https://api.flickr.com/services/rest/?method=flickr.tags.getHotList&api_key=8600137d80a1058ebefd7d2a06d77f4e&count=12&format=json&nojsoncallback=1";
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                              NSLog(@"%@", string);
                                          }];
    
    [downloadTask resume];
}

@end
