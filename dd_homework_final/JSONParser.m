//
//  JSONParser.m
//  dd_homework_final
//
//  Created by Andrey on 26/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser

- (NSArray *)parseTagsFromGetHotList:(NSData *)data {
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    //NSString *string = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    NSDictionary *hottags = [json objectForKey:@"hottags"];
    NSArray *tags = [hottags objectForKey:@"tag"];
    
    NSMutableArray *resultTags = [[NSMutableArray alloc] init];
    for (NSDictionary *tag in tags) {
        [resultTags addObject:[tag objectForKey:@"_content"]];
    }
    
    return resultTags;
}

@end
