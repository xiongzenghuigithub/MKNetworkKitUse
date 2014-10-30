//
//  Venues.h
//  MKNetworkKitUse
//
//  Created by wadexiong on 14/10/30.
//  Copyright (c) 2014年 xiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venues : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, strong) NSMutableArray * categories;

- (Venues *)initWithDict:(NSDictionary *)dict;

@end
