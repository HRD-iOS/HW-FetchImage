//
//  ImageRecord.h
//  FetchImage
//
//  Created by Kokpheng on 11/15/15.
//  Copyright © 2015 Kokpheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageRecord : NSObject

- (id)initWithData:(NSArray *)data;


@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,strong) NSString *urlImageString;
@end
