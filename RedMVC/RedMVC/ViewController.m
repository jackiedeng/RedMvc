//
//  ViewController.m
//  RedMVC
//
//  Created by jackiedeng on 2018/12/28.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import "ViewController.h"
#import "VIP.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    id<AddServiceProtocol> protocolService = VIPGetAnyService(AddServiceProtocol);
    
    if(protocolService){
        NSLog(@"1>%d",[protocolService adda:100 b:200]);
    }
    
    protocolService = VIPGetServiceById(AddServiceProtocol, @"VIP/AddService2");
    if(protocolService){
        NSLog(@"2>%d",[protocolService adda:100 b:400]);
    }
    
    VIPGetAnyServiceAsync(AddServiceProtocol, ^(id<AddServiceProtocol>service){
       
        NSLog(@"3>%d",[service adda:100 b:200]);
        
    });
    NSLog(@"4>>>");
    VIPGetServiceByIdAsync(AddServiceProtocol,@"VIP/AddService", ^(id<AddServiceProtocol>service){
        
        NSLog(@"5>%d",[service adda:100 b:200]);
        
    });
    NSLog(@"4>%@",VIPOpenURL([NSURL URLWithString:@"VIP/AddService?a=100&b=100"]));
//
    NSLog(@"%@",VIPOpenURL([NSURL URLWithString:@"VIP/AddService2?a=200&b=100"]));
    
    id<TestProtocol> test = VIPGetAnyService(TestProtocol);
    
    [test myFirstProtocol:@"jackiedeng"];
}

@end
