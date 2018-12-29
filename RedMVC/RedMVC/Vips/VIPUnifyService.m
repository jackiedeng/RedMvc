//
//  VIPUnifyService.m
//  RedMVC
//
//  Created by jackiedeng on 2018/12/29.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import "VIPUnifyService.h"

@interface VIPUnifyService(){
}
//key protocol value config
@property (strong) NSMutableDictionary * serviceRegisterConfig;

@end

@implementation VIPUnifyService
+ (instancetype)instance{
    
    static VIPUnifyService * service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [VIPUnifyService new];
    });
    
    return service;
}

- (id)init{
    self = [super init];
    if(self){
        
        self.serviceRegisterConfig = [NSMutableDictionary dictionary];
        [self initProtocolMapService];
    }
    return self;
}

- (id)vipServiceWithProtocol:(Protocol*)protocol{
    
    return nil;
}

#pragma mark -
#pragma mark init protocol maps
- (void)initProtocolMapService{
    
    NSArray * array = [VIPUtil VipProtocolImpSectionConfiguration];
    
    
    
    NSLog(@"process %@",array);
}

- (BOOL)registerProtocol:(Protocol*)protocol
          toServiceClass:(Class)service{
   
    NSParameterAssert(protocol != nil);
    NSParameterAssert(service != nil);
    
    // impClass 是否遵循了 Protocol 协议
    if (![service conformsToProtocol:protocol]) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ module does not comply with %@ protocol", NSStringFromClass(service), NSStringFromProtocol(protocol)] userInfo:nil];
    }
    
    return YES;
}
@end
