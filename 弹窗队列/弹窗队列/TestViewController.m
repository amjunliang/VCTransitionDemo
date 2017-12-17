//
//  TestViewController.m
//  弹窗队列
//
//  Created by MaJunliang on 2017/12/15.
//  Copyright © 2017年 ZhangYue. All rights reserved.
//

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#import "TestViewController.h"

@interface TestViewController ()
{
    UILabel *_lable;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = randomColor;
    
    
    UILabel *lable = [[UILabel alloc]init];
    lable.text = @"点击消失";
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    [self.view addSubview:lable];
    _lable = lable;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _lable.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
