
#import "FoursquareApiEngine.h"
#import "Venues.h"

#define kCLIENTID @"CMXDTX41EITPPW1GDNKSK3FAB0L4PYFG0HHCBTZ0L3M30QOX"
#define kCLIENTSECRET @"ZSJMMWS5HVXQLY4WVIESVRYEF4BTBMAZF3KPEYTP1G1V2BQM"

#define kHostName @"api.foursquare.com" //注意: https:// 这个不要
#define kLoadVenuesPath @"/v2/venues/search"

static FoursquareApiEngine * engine = nil;

@implementation FoursquareApiEngine

+ (FoursquareApiEngine *)sharedEngine {
    if (engine == nil) {
        engine = [[FoursquareApiEngine alloc] initWithHostName:kHostName];
        [engine useCache];  //缓存同一个路径的GET请求的response数据
    }
    return  engine;
}

- (void)loadVenuesWithParam:(NSDictionary *)paramDict Completion:(LoadVenuesSuccess)complet {
    
    //1. 拼接参数
    NSMutableDictionary * fullParamDict = [NSMutableDictionary dictionaryWithDictionary:paramDict];
    [fullParamDict setValue:kCLIENTID forKey:@"client_id"];
    [fullParamDict setValue:kCLIENTSECRET forKey:@"client_secret"];
    
    //2. 创建一个MKNetworkOperation对象，封装当前的request请求操作
    MKNetworkOperation * op = [engine operationWithPath:kLoadVenuesPath params:fullParamDict httpMethod:@"GET" ssl:YES];
    
    //冻结网络操作
    [op setFreezable:YES];
    
    //2. 设置异步请求成功返回时，要执行的Block代码块
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //2.1) 服务器响应数据类型
        NSDictionary * jsonDict = [completedOperation responseJSON];
        [completedOperation responseData];
        [completedOperation responseImage];
        [completedOperation responseString];
        
        
        NSMutableArray * venuesArr = nil;
        
        //2.2) 查看返回的数据是否缓存
        if ([completedOperation isCachedResponse]) {
            //当前返回的response是缓存数据
            //直接返回缓存的对象数据
            if (complet) {
                _handleLoadVesnues = complet;
                _handleLoadVesnues(nil);
            }
            
        }else {
            //不是
            //重新解析json，创建实体对象
            if (jsonDict) {
                
                venuesArr = [NSMutableArray array];
                NSArray * venueJsonDicts = [[jsonDict objectForKey:@"response"] objectForKey:@"venues"];
                for (NSDictionary * dict in venueJsonDicts) {
                    Venues * v = [[Venues alloc] initWithDict:dict];
                    [venuesArr addObject:v];
                }
            }
            
            //2.3) 执行主调方传入的Block代码块
            if (complet) {
                _handleLoadVesnues = complet;
                _handleLoadVesnues(venuesArr);
                _handleLoadVesnues = nil;
            }

        }
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"loadVenues error = %@\n", [error localizedDescription]);
    }];
    
    [engine enqueueOperation:op];
}

@end
