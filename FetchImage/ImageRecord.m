//
//  ImageRecord.m
//  FetchImage
//
//  Created by Kokpheng on 11/15/15.
//  Copyright © 2015 Kokpheng. All rights reserved.
//

#import "ImageRecord.h"

@implementation ImageRecord

- (id)initWithData:(NSArray *)array {
    self = [super init];
    
    if (self != nil) {
        self.name = [array valueForKeyPath:@"name"];
        self.urlImageString = [array valueForKeyPath:@"image.url"];
    }
    
    return self;
}
@end
