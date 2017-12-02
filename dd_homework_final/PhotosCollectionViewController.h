//
//  PhotosCollectionViewController.h
//  dd_homework_final
//
//  Created by Andrey on 28/11/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSString *tag;

@end
