//
//  ContentViewController.m
//  内容自适应
//
//  Created by 马俊良 on 2017/12/19.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.inputView.backgroundColor = [UIColor orangeColor];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    self.inputView.frame = self.view.bounds;
    self.view.frame = CGRectMake(0, 0, size.width, size.height/2);
}



@end
