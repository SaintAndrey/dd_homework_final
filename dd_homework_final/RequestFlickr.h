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
extern NSString * const RequestFlickrPhotoIdOnTagNotification;
extern NSString * const RequestFlickrPhotoIdUserInfoKey;
extern NSString * const RequestFlickrGetPhotoNotification;
extern NSString * const RequestFlickrGetPhotoUserInfoKey;
extern NSString * const RequestFlickrPhotoHttpsOnTagNotification;
extern NSString * const RequestFlickrPhotoHttpsUserInfoKey;


@interface RequestFlickr : NSObject

- (void)getHotTags;
- (void)photosSearchOnTag:(NSString *)tag;
- (void)getPhotoOnId:(NSString *)id size:(NSString *)size;
- (void)getPhoto:(NSString *)https;

@end
