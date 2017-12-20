//
//  ViewController.m
//  设置外观
//
//  Created by 马俊良 on 2017/12/20.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "ViewController.h"
#import "TestAppearance.h"

@interface ViewController (){
    TestAppearance *test;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIView appearance] setBackgroundColor:[UIColor orangeColor]];
    // Do any additional setup after loading the view, typically from a nib.
    
    [TestAppearance appearance].name = @"test";
    [TestAppearance appearance].haha = 100;
    test = [TestAppearance new];
    [self.view addSubview:test];
    
    [test class];
    
}
- (void)viewWillLayoutSubviews{
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
