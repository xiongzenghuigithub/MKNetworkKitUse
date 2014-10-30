//
//  Venues.m
//  MKNetworkKitUse
//
//  Created by wadexiong on 14/10/30.
//  Copyright (c) 2014年 xiong. All rights reserved.
//

#import "Venues.h"

@implementation Venues

@synthesize name;
@synthesize categories;

- (Venues *)initWithDict:(NSDictionary *)dict {
    
    Venues * v = [[Venues alloc] init];
    v.name = dict[@"name"];
    NSArray * categoriesDicts = dict[@"categories"];
    Venues * child = nil;
    if ([categoriesDicts count] > 0) {
        self.categories = [NSMutableArray arrayWithCapacity:[categoriesDicts count]];
        for (NSDictionary * t in categoriesDicts) {
            child = [[Venues alloc] initWithDict:t];
            [self.categories addObject:child];
        }
    }
    return v;
}

@end
