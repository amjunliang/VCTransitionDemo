//
//  ViewController.m
//  Nav 导航
//
//  Created by 马俊良 on 2017/12/21.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"test";
    
    if (!(self.navigationController.viewControllers.count == 1)) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"title" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"title" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
