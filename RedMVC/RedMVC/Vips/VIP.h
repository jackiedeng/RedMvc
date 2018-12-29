//
//  Vips.h
//  RedMVC
//
//  Created by jackiedeng on 2018/12/29.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import "VIPProtocols.h"
#import "VIPUnifyService.h"

#define VIPGetService(p) [[VIPUnifyService instance] vipServiceWithProtocol:@protocol(p)]
