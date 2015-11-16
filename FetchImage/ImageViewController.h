//
//  ImageViewController.h
//  FetchImage
//
//  Created by Yin Kokpheng on 11/16/15.
//  Copyright © 2015 Kokpheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageRecord.h"

@interface ImageViewController : UIViewController

@property (strong, nonatomic) ImageRecord *imageRecord;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
