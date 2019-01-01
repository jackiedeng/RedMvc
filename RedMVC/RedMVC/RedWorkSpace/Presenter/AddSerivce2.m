//
//  AddSerivce2.m
//  RedMVC
//
//  Created by Chao Deng on 2018/12/30.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import "AddSerivce2.h"
#import "VIP.h"

VIPImpMapping(AddServiceProtocol, AddSerivce2, VIP/AddService2)
@interface AddSerivce2 () <AddServiceProtocol>

@end 

@implementation AddSerivce2

- (int)adda:(int)a
          b:(int)b{
    return a*10+b*10;
}
@end
