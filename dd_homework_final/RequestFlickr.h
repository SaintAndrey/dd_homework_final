//
//  RequestFlickr.h
//  dd_homework_final
//
//  Created by Andrey on 26/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RequestServer;

@interface RequestFlickr : NSObject

@property (assign) id <RequestServer> delegate;
@property (nonatomic, copy) void(^successBlock)(NSData *);

- (void)getHotTags;
- (void)photosSearchOnTag:(NSString *)tag;
- (void)getPhotoOnId:(NSString *)id size:(NSString *)size;
- (void)getPhoto:(NSString *)https;

@end

@protocol RequestServer

@optional

- (void)updateHotTagsTable:(NSArray *)hotTags;
- (void)recivePhotosId:(NSArray *)ids;
- (void)recivePhotoData:(NSData *)photo;

@end
