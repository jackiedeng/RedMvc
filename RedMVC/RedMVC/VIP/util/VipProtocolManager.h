//
//  VipProtocolUtil.h
//  RedMVC
//
//  Created by jackiedeng on 2018/12/29.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    VIPSingleton=0,
    VIPPrototype
    
}VIPInstanceType;

NS_ASSUME_NONNULL_BEGIN

@interface VipProtocolManager : NSObject
@property (strong) NSString * accessId;
@property (strong) NSString * protocolName;
@property (strong) Protocol * protocol;
@property (readwrite) Class   impClass;
@property (readwrite) VIPInstanceType type;
@property (strong) id impClassInstance;

+ (instancetype)VipProtocolItemWithProtocol:(Protocol* _Nonnull)protocol
                                   impClass:(Class _Nonnull)impClass
                                  accessId:(NSString* _Nullable)accessId
                                       type:(VIPInstanceType)type;

- (id _Nonnull)getImpClassInstace;

@end

NS_ASSUME_NONNULL_END
