//
//  ViewController.m
//  MKNetworkKitUse
//
//  Created by wadexiong on 14/10/30.
//  Copyright (c) 2014年 xiong. All rights reserved.
//

#import "ViewController.h"
#import "FoursquareApiEngine.h"

#import "Venues.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadVenues];
}

- (void)loadVenues {
    
    FoursquareApiEngine * engine = [FoursquareApiEngine sharedEngine];
    
    NSString *latLon = @"37.33,-122.03";
//    NSString *clientID = kCLIENTID;
//    NSString *clientSecret = kCLIENTSECRET;
    
    NSDictionary *queryParams = @{@"ll" : latLon,
//                                  @"client_id" : clientID,
//                                  @"client_secret" : clientSecret,
                                  @"categoryId" : @"4bf58dd8d48988d1e0931735",
                                  @"v" : @"20140118"
                                  };
    
    [engine loadVenuesWithParam:queryParams Completion:^(NSMutableArray *venues) {
        
        NSLog(@"ViewController:\n");
        
        if (venues != nil) {
            
            //不是缓存的数据
            for (Venues * v in venues) {
                NSLog(@"name = %@\n" , [v name]);
                for (int i = 0; i < [[v categories] count]; i++) {
                    Venues * t = [[v categories] objectAtIndex:i];
                    NSLog(@"%@ 的第 %d 个子分类 = %@ ", [v name], i+1 ,[t name]);
                }
            }
            
        }else {
            
            //直接使用当前保存在内存的数据
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
