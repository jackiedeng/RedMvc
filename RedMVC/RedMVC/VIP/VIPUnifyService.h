//
//  VIPUnifyService.h
//  RedMVC
//
//  Created by jackiedeng on 2018/12/29.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIPUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface VIPUnifyService : NSObject
+ (instancetype)instance;
- (id)vipServiceWithProtocol:(Protocol* _Nonnull)protocol
                   accessId:(NSString* _Nullable)accessId;

- (void)vipServiceWithProtocolAync:(Protocol* _Nonnull)protocol
                         accessId:(NSString* _Nullable)accessId
                      ayncCallBack:(void (^)(id _Nullable service))block;

- (BOOL)vipRegisterProtocol:(Protocol* _Nonnull)protocol
             toServiceClass:(Class _Nonnull)service
                  accessId:(NSString*)uri;

- (NSDictionary*)vipAccessServiceByURL:(NSURL*)url;
@end

NS_ASSUME_NONNULL_END
