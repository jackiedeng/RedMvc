//
//  AddService.m
//  RedMVC
//
//  Created by jackiedeng on 2018/12/29.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import "AddService.h"

VIPImpMapping(AddServiceProtocol, AddService)
@implementation AddService

- (int)Adda:(int)a
          b:(int)b{
    return a+b;
}

@end
