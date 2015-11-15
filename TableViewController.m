//
//  TableViewController.m
//  FetchImage
//
//  Created by Kokpheng on 11/15/15.
//  Copyright © 2015 Kokpheng. All rights reserved.
//
#import "TableViewController.h"
#import "ImageRecord.h"

@interface TableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray<ImageRecord*> *contentList;


@end

@implementation TableViewController


#pragma mark:- custom property

- (void)setContentList:(NSMutableArray *)contentList {
    _contentList = contentList;
    
    if ([_contentList count] > 0) {
        [self.tableView reloadData];
    }
    
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]initWithURL: [NSURL URLWithString:@"https://api.parse.com/1/classes/APUploadToParse"]];
    
    urlRequest.HTTPMethod = @"GET";
    [urlRequest addValue:@"jGJU4zicgO4Fiejw6sLwYqQn7qcQbqVvOQyo76Y3" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [urlRequest addValue:@"ZiWq01FMNJTse8qc1vIyQ2NSUsu3UKgqt7DXdZVS" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    self.contentList = [[NSMutableArray alloc]init];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:urlRequest completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            if ([urlRequest.URL isEqual:[NSURL URLWithString:@"https://api.parse.com/1/classes/APUploadToParse"]] ) {
                NSData *data = [NSData dataWithContentsOfURL:localfile];
                NSArray *rootDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                for ( NSArray *subList in [rootDictionary valueForKeyPath:@"results"]) {
                    
                    ImageRecord *record = [[ImageRecord alloc]initWithData:subList ];
                    [self.contentList addObject:record];
                }
                
                [self.tableView reloadData];
            }
        }
        
    }];
    [task resume];
    
    
    
}

#pragma mark: - UITableViewDataSource

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowsInSection %lu",(unsigned long)[self.contentList count]);
    return [self.contentList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [[self.contentList objectAtIndex:indexPath.row] name];
    
    if ([[self.contentList objectAtIndex:indexPath.row] image]) {
        cell.imageView.image = [self.contentList[indexPath.row] image];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"images.png"];
        [self startDownloadingImage:[self.contentList objectAtIndex:indexPath.row] forIndexPath:indexPath];
        
    }
    
    
    return cell;
    
    
}

- (void)startDownloadingImage:(ImageRecord *)imageRecord forIndexPath:(NSIndexPath *)indexPath {
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(concurrentQueue, ^{
        __block NSData *dataImage = nil;
        
        dispatch_sync(concurrentQueue, ^{
            NSURL *urlImage = [NSURL URLWithString:[imageRecord urlImageString]];
            dataImage = [NSData dataWithContentsOfURL:urlImage];
        });
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            UIImage *image = [UIImage imageWithData:dataImage];
            self.contentList[indexPath.row].image = image;
            cell.imageView.image = image;
        });
    });
}



@end