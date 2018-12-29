//
//  ViewController.m
//  RedMVC
//
//  Created by jackiedeng on 2018/12/28.
//  Copyright © 2018 jackiedeng. All rights reserved.
//

#import "ViewController.h"
#import "VIP.h"

@protocol TestProtocol <NSObject>

- (void)testPortocol;

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    id<AddServiceProtocol> protocolService = VIPGetService(AddServiceProtocol);
    
    if(protocolService){
        NSLog(@"%d",[protocolService Adda:100 b:200]);
    }
}

@end
