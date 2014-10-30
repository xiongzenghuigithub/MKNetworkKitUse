

#ifndef MKNetworkKitUse_Config_h
#define MKNetworkKitUse_Config_h

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
    @synchronized(self) \
    { \
        if (shared##classname == nil) \
        { \
            shared##classname = [[self alloc] init]; \
        } \
    } \
    \
    return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
    @synchronized(self) \
    { \
        if (shared##classname == nil) \
        { \
            shared##classname = [super allocWithZone:zone]; \
            return shared##classname; \
        } \
    } \
    \
    returnnil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
    returnself; \
} \
\
//- (id)retain \
//{ \
//    returnself; \
//} \
//\
//- (NSUInteger)retainCount \
//{ \  
//    return NSUIntegerMax; \  
//} \  
//\  
//- (void)release \  
//{ \  
//} \  
//\  
//- (id)autorelease \  
//{ \  
//    returnself; \  
//}\
//\


#endif
