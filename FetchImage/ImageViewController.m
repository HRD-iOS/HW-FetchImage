//
//  ImageViewController.m
//  FetchImage
//
//  Created by Yin Kokpheng on 11/16/15.
//  Copyright © 2015 Kokpheng. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIScrollViewDelegate>

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate =self;
    _imageView.image = _imageRecord.image;
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.maximumZoomScale = 6.0;
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
