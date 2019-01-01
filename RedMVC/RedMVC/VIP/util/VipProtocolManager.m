//
//  VipProtocolUtil.m
//  RedMVC
//
//  Created by jackiedeng on 2018/12/29.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import "VipProtocolManager.h"

@implementation VipProtocolManager

+ (instancetype)VipProtocolItemWithProtocol:(Protocol* _Nonnull)protocol
                                   impClass:(Class _Nonnull)impClass
                                  accessId:(NSString* _Nullable)accessId
                                       type:(VIPInstanceType)type{
    
    NSParameterAssert(protocol != nil);
    NSParameterAssert(impClass != nil);
    
    // impClass 是否遵循了 Protocol 协议
    if (![impClass conformsToProtocol:protocol]) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ module does not comply with %@ protocol", NSStringFromClass(impClass), NSStringFromProtocol(protocol)] userInfo:nil];
        
        return nil;
    }
    
    VipProtocolManager * protocolManager = [VipProtocolManager new];
    protocolManager.accessId = accessId;
    protocolManager.protocol = protocol;
    protocolManager.protocolName = NSStringFromProtocol(protocol);
    protocolManager.impClass = impClass;
    protocolManager.type = type;
    
    return protocolManager;

}

- (NSString*)description{
    
    return [NSString stringWithFormat:@"配置 实现类:[%@] ->> 接口:[%@] uri:%@",self.protocolName,NSStringFromClass(self.class),self.accessId];
}

- (id _Nonnull)getImpClassInstace{
    
    if(self.type == VIPSingleton){
        
        @synchronized (self) {
            if(!self.impClassInstance){
                self.impClassInstance = [self.impClass new];
            }
        }
        
        return self.impClassInstance;
        
    }else{
        return [self.impClass new];
    }
}

@end
