//
//  TestServiceImp.m
//  RedMVC
//
//  Created by Chao Deng on 2018/12/31.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import "TestServiceImp.h"
#import "VIP.h"

VIPRegister(VIP/TestProtocol,TestServiceImp,TestProtocol)
@interface TestServiceImp ()<TestProtocol>

@end

@implementation TestServiceImp
- (void)myFirstProtocol:(NSString*)name{
    NSLog(@"%@ is going",name);
}
@end
