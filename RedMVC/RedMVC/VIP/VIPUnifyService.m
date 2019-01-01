//
//  VIPUnifyService.m
//  RedMVC
//
//  Created by jackiedeng on 2018/12/29.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import "VIPUnifyService.h"
#import "VipProtocolManager.h"

@interface VIPUnifyService(){
}
//key protocol value config
@property (strong) NSMutableDictionary * serviceRegisterConfig;
@property (strong) NSMutableDictionary * uriServiceRegisiterConfig;
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
        self.uriServiceRegisiterConfig = [NSMutableDictionary dictionary];
        //开始加载
        [self initProtocolMapService];
    }
    return self;
}

- (id)vipServiceWithProtocol:(Protocol* _Nonnull)protocol
                   accessId:(NSString* _Nullable)uri{
    
    if(protocol){
        VipProtocolManager * protocolManager = nil;
        //优先查找URI定义
        if(uri){
            protocolManager = [self.uriServiceRegisiterConfig objectForKey:uri];
        }
        
        //如果没有找到则查找接口
        if(!protocolManager){
            NSString * protocolName = NSStringFromProtocol(protocol);
            protocolManager =  [self.serviceRegisterConfig objectForKey:protocolName];
        }
        
        //判断是否有记录
        if(protocolManager){
            return [protocolManager getImpClassInstace];
        }
    }
    
    return nil;
}

- (void)vipServiceWithProtocolAync:(Protocol* _Nonnull)protocol
                         accessId:(NSString* _Nullable)uri
                      ayncCallBack:(void (^)(id _Nullable service))block{
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
       
        id service = [self vipServiceWithProtocol:protocol
                                        accessId:uri];
        
        block(service);
    });
}

- (NSDictionary*)vipAccessServiceByURL:(NSURL*)url{
    
    __block VipProtocolManager * protocolManager = nil;
    __block NSDictionary * accessParams = nil;
    __block NSString     * accessURI = nil;
    NSDictionary * accessResult = nil;

    [VIPUtil getAccessURIAndParamsFromURL:url
                                   result:^(NSString * _Nullable accessId, NSDictionary * _Nullable params) {
                                       
                                       if(accessId){
                                           protocolManager = [self.uriServiceRegisiterConfig objectForKey:accessId];
                                           accessParams = params;
                                           accessURI = accessId;
                                       }
                                   }];
    
    if(protocolManager){
    
        id instance = [protocolManager getImpClassInstace];
        
        if(instance && [instance respondsToSelector:@selector(vipPresenterAccessId:withParams:)]){
            
            accessResult =  [(id<VIPAccessURIDelegate>)instance  vipPresenterAccessId:accessURI
                                                                            withParams:accessParams];
        }
        
    }
    
    return accessResult;
    
}

#pragma mark -
#pragma mark init protocol maps
- (void)initProtocolMapService{
    
    NSArray * array = [VIPUtil VipProtocolImpSectionConfiguration];

    for(NSString * protocolConfig in array){
        
        [VIPUtil readConfigInfoFromString:protocolConfig
                                   result:^(Protocol * _Nonnull procotol, Class  _Nonnull __unsafe_unretained impClass, NSString * _Nullable accessId) {
                                      
                                       [self vipRegisterProtocol:procotol
                                               toServiceClass:impClass
                                                    accessId:accessId];
                                       
                                   }];
        
    }
    
    
    NSLog(@"process %@",array);
}

- (BOOL)vipRegisterProtocol:(Protocol* _Nonnull)protocol
          toServiceClass:(Class _Nonnull)service
               accessId:(NSString*)accessId
{
   
    VipProtocolManager * protocolManager = [VipProtocolManager VipProtocolItemWithProtocol:protocol
                                                                                  impClass:service
                                                                                 accessId:accessId
                                                                                      type:VIPSingleton];

    if(protocolManager){
        
        [self.serviceRegisterConfig setObject:protocolManager
                                       forKey:protocolManager.protocolName];
        
        if(protocolManager.accessId){
            [self.uriServiceRegisiterConfig setObject:protocolManager
                                            forKey:protocolManager.accessId];
        }

        NSLog(@"%@",protocolManager);
        
        return YES;
    }
    
    return NO;
}
@end
