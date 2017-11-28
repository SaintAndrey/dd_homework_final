//
//  RequestFlickr.h
//  dd_homework_final
//
//  Created by Andrey on 26/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const RequestFlickrGetHotTagsNotification;
extern NSString * const RequestFlickrHotTagsUserInfoKey;

@interface RequestFlickr : NSObject

- (void)getHotTags; 

@end
