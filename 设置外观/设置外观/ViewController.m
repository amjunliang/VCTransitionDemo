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
    
    /*
     一般地，UIView 的子类，和直接调用 setter 一样，直接通过 appearance 对其设置属性，当然时机在被添加到视图树之前, 并且 seter 方法从未被调用过。
     建议在 appearance 的属性后加上 UI_APPEARANCE_SELECTOR 宏。
     复杂需求可以考虑 UIAppearance 协议里另外几个方法来实现。
     
     future, no create
     https://stackoverflow.com/questions/19985270/ios-7-uinavigationbar-appearance-not-working-first-time
     */
    
    [TestAppearance appearance].name = @"test";
    [TestAppearance appearance].haha = 100;
    test = [TestAppearance new];
    //test.name = @"change";
    //test.name = nil;
    [TestAppearance appearance].name = @"test";
    [self.view addSubview:test];
    
    [test class];
    
}
- (void)viewWillLayoutSubviews{
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [test removeFromSuperview];
    [self.view addSubview:test];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
