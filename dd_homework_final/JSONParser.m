//
//  JSONParser.m
//  dd_homework_final
//
//  Created by Andrey on 26/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser

- (NSArray *)parseTagsFromTagsGetHotList:(NSData *)data {
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];

    NSDictionary *hottags = [json objectForKey:@"hottags"];
    NSArray *tags = [hottags objectForKey:@"tag"];
    
    NSMutableArray *resultTags = [[NSMutableArray alloc] init];
    for (NSDictionary *tag in tags) {
        [resultTags addObject:[tag objectForKey:@"_content"]];
    }
    
    return resultTags;
}

- (NSArray *)parseIdFromPhotosSearch:(NSData *)data {
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    NSDictionary *photos = [json objectForKey:@"photos"];
    NSArray *photo = [photos objectForKey:@"photo"];
    
    NSMutableArray *resultId = [[NSMutableArray alloc] init];
    for (NSDictionary *item in photo) {
        [resultId addObject:[item objectForKey:@"id"]];
    }
    
    return resultId;
}

- (NSArray *)parseHttpsFromPhotos:(NSData *)data {
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    NSDictionary *sizes = [json objectForKey:@"sizes"];
    NSArray *size = [sizes objectForKey:@"size"];
    
    return size;
}

@end
