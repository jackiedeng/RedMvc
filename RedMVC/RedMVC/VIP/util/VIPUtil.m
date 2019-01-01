//
//  VIPUtil.m
//  RedMVC
//
//  Created by jackiedeng on 2018/12/29.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import "VIPUtil.h"

#define kVIPImpSingleton @"VIPImpSingleton"
#define kVIPImpPrototype @"VIPImpPrototype"

static NSArray<NSString *>* VIPReadSectionConfiguration(char *section)
{
    NSMutableArray *configs = [NSMutableArray array];
    
    Dl_info info;
    dladdr(VIPReadSectionConfiguration, &info);
    
#ifndef __LP64__
    // const struct mach_header *mhp = _dyld_get_image_header(0); // both works as below line
    const struct mach_header *mhp = (struct mach_header*)info.dli_fbase;
    unsigned long size = 0;
    // 找到之前存储的数据段(Module找BeehiveMods段 和 Service找BeehiveServices段)的一片内存
    uint32_t *memory = (uint32_t*)getsectiondata(mhp, "__DATA", section, & size);
#else /* defined(__LP64__) */
    const struct mach_header_64 *mhp = (struct mach_header_64*)info.dli_fbase;
    unsigned long size = 0;
    uint64_t *memory = (uint64_t*)getsectiondata(mhp, "__DATA", section, & size);
#endif /* defined(__LP64__) */
    
    // 把特殊段里面的数据都转换成字符串存入数组中
    for(int idx = 0; idx < size/sizeof(void*); ++idx){
        char *string = (char*)memory[idx];
        
        NSString *str = [NSString stringWithUTF8String:string];
        if(!str)continue;
        
        NSLog(@"config = %@", str);
        if(str) [configs addObject:str];
    }
    
    return configs;
}


@implementation VIPUtil

+ (NSArray*)VipProtocolImpSectionConfiguration{
    return VIPReadSectionConfiguration((char *)[kVIPImpSingleton UTF8String]);
}

+ (void)readConfigInfoFromString:(NSString* _Nonnull)config
                          result:(void(^)(Protocol* _Nullable procotol,
                                          Class _Nullable impClass,
                                          NSString* _Nullable accessId))block{
    
    if(config){
        //分割 接口名称|实现类|uri（可选）
        NSArray * array = [config componentsSeparatedByString:@"|"];
        
        //只有等于2或者等于3的情况才合法
        if(array.count ==2 || array.count == 3){
            
            NSString * protocolName = array[0];
            NSString * impClassName = array[1];
            NSString * accessId = array.count == 3?array[2]:nil;
            
            if([accessId isEqualToString:@"null"]){
                accessId=nil;
            }
            
            block(NSProtocolFromString(protocolName),NSClassFromString(impClassName),accessId);
            
        }
        
    }

}

+ (void)getAccessURIAndParamsFromURL:(NSURL* _Nonnull)url
                              result:(void(^)(NSString* _Nullable accessURI,
                                              NSDictionary* _Nullable params))block{
    
    //access uri = host/path
    NSURLComponents * component = [[NSURLComponents alloc] initWithURL:url
                                               resolvingAgainstBaseURL:NO];
    NSString * accessURI = nil;
    NSMutableDictionary * params = nil;
    
    if(component){
        
        accessURI = [NSString stringWithFormat:@"%@%@",[url host]?[url host]:@"",[url path]];

        params = [NSMutableDictionary dictionary];

        for(NSURLQueryItem * item in [component queryItems]){
            
            [params setObject:item.value
                       forKey:item.name];
        }
    }
    
    block(accessURI,params);
}
@end
