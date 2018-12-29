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
- (id)vipServiceWithProtocol:(Protocol*)protocol;
- (BOOL)registerProtocol:(Protocol*)protocol
          toServiceClass:(Class)service;
@end

NS_ASSUME_NONNULL_END
