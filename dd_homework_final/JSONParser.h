//
//  JSONParser.h
//  dd_homework_final
//
//  Created by Andrey on 26/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParser : NSObject

- (NSArray *)parseTagsFromTagsGetHotList:(NSData *)data;
- (NSArray *)parseIdFromPhotosSearch:(NSData *)data;
- (NSArray *)parseHttpsFromPhotos:(NSData *)data;

@end
