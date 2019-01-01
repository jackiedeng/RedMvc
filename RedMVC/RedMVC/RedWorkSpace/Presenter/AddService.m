//
//  AddService.m
//  RedMVC
//
//  Created by jackiedeng on 2018/12/29.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import "AddService.h"

VIPRegister(VIP/AddService,AddService,AddServiceProtocol)
@interface AddService ()<AddServiceProtocol,VIPAccessURIDelegate>
@end

@implementation AddService

- (int)adda:(int)a
          b:(int)b{
    return a+b;
}

- (NSDictionary* _Nullable)vipPresenterAccessId:(NSString* _Nonnull)uri
                                      withParams:(NSDictionary* _Nonnull)params{
    
    if([params objectForKey:@"a"] && [params objectForKey:@"b"]){
        
        int a = [[params objectForKey:@"a"] intValue];
        int b= [[params objectForKey:@"b"] intValue];
        
        int result = [self adda:a b:b];
        return @{@"result":[NSNumber numberWithInt:result]};
    }
    
    return @{};
    
}

@end
