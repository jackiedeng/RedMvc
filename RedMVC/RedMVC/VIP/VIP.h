//
//  Vips.h
//  RedMVC
//
//  Created by jackiedeng on 2018/12/29.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import "VIPProtocols.h"
#import "VIPUnifyService.h"

//VIPGetAnyService(protocol)
#define VIPGetAnyService(p) [[VIPUnifyService instance] vipServiceWithProtocol:@protocol(p) accessId:nil]

//get service async VIPGetAnyServiceAsync(protocol,^(id service){})
#define VIPGetAnyServiceAsync(p,block) [[VIPUnifyService instance] vipServiceWithProtocolAync:@protocol(p) accessId:nil ayncCallBack:block]

//VIPGetServiceWithURI(protocol,accessURI)
#define VIPGetServiceById(p,q) [[VIPUnifyService instance] vipServiceWithProtocol:@protocol(p) accessId:q]

//aync
#define VIPGetServiceByIdAsync(p,q,block) [[VIPUnifyService instance] vipServiceWithProtocolAync:@protocol(p) accessId:q ayncCallBack:block]

//VIPOpenURL([NSURL urlWithString:@"xxx"])
#define VIPOpenURL(x) [[VIPUnifyService instance] vipAccessServiceByURL:x]
