/**
 *  Engine类:  负责封装某一个服务器根域名下，所有子路径的请求访问
 *
 *      如:
 *          TencentAPIEngine:  负责完成对腾讯服务器的所有网络请求
 *          DPApiEngine:       负责完成对大众点评服务器的所有网络请求
 */

#import <Foundation/Foundation.h>
#import <MKNetworkKit/MKNetworkKit.h>

@class Venues;

typedef void(^LoadVenuesSuccess)(NSMutableArray * venues);

/**
 *  完成对Foursquare的所有网络请求的封装
 */
@interface FoursquareApiEngine : MKNetworkEngine


@property (nonatomic, copy) LoadVenuesSuccess handleLoadVesnues;

+ (FoursquareApiEngine *)sharedEngine;

/**
 *  对子路径:  /v2/venues/search  网络请求
 */
- (void)loadVenuesWithParam:(NSDictionary *)paramDict Completion:(LoadVenuesSuccess)complet;

@end
