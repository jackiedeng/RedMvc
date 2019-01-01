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

//唯一id(uri) 实现类名 接口名称
#define VIPRegister(accessId,ImpClass,Protocol) VIPRegisterSingleton(Protocol,ImpClass,accessId)
//唯一id(uri) 实现类名 接口名称 （单例模式)
#define VIPRegisterSingleton(Protocol,ImpClass,accessId) char * kImp##ImpClass##key WriteSection(VIPImpSingleton) = ""#Protocol"|"#ImpClass"|"#accessId"";
//唯一id(uri) 实现类名 接口名称 （多实例模式)
#define VIPRegisterPrototype(Protocol,ImpClass,accessId) char * kImp##ImpClass##key WriteSection(VIPImpPrototype) = ""#Protocol"|"#ImpClass"|"#accessId"";

NS_ASSUME_NONNULL_BEGIN

@protocol VIPAccessURIDelegate <NSObject>
@required
- (NSDictionary* _Nullable)vipPresenterAccessId:(NSString* _Nonnull)accessId
                                      withParams:(NSDictionary<NSString*,NSString*> * _Nonnull)params;
@end

@interface VIPUtil : NSObject
+ (NSArray*)VipProtocolImpSectionConfiguration;
+ (void)readConfigInfoFromString:(NSString* _Nonnull)config
                          result:(void(^)(Protocol* _Nullable procotol,
                                          Class _Nullable impClass,
                                          NSString* _Nullable uri))block;
+ (void)getAccessURIAndParamsFromURL:(NSURL* _Nonnull)url
                              result:(void(^)(NSString* _Nullable accessId,
                                              NSDictionary* _Nullable params))block;
@end

NS_ASSUME_NONNULL_END
