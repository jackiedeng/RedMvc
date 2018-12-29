//
//  VIPUtil.h
//  RedMVC
//
//  Created by jackiedeng on 2018/12/29.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <dlfcn.h>
#include <mach-o/getsect.h>


#define WriteSection(sectionName) __attribute((used, section("__DATA,"#sectionName" ")))

#define VIPImpMapping(Protocol,ImpClass) VIPImpMappingSingleton(Protocol,ImpClass)

#define VIPImpMappingSingleton(Protocol,ImpClass) char * kImp##key WriteSection(VIPImpSingleton) = ""#Protocol"|"#ImpClass"";

#define VIPImpMappingPrototype(Protocol,ImpClass) char * kImp##key WriteSection(VIPImpPrototype) = ""#Protocol"|"#ImpClass"";

NS_ASSUME_NONNULL_BEGIN

@interface VIPUtil : NSObject
+ (NSArray*)VipProtocolImpSectionConfiguration;
@end

NS_ASSUME_NONNULL_END
