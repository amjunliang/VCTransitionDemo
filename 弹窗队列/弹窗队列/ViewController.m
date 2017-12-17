//
//  ViewController.m
//  弹窗队列
//
//  Created by MaJunliang on 2017/12/15.
//  Copyright © 2017年 ZhangYue. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "ZYPopupWindowOperationQueue.h"
#import "ZYPopupWindowAnimation.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
{
    ZYPopupWindowOperationQueue *_queue;
    ZYPopupWindowAnimation *_animate;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _queue = [ZYPopupWindowOperationQueue new];
    _animate = [ZYPopupWindowAnimation new];
    
}

- (IBAction)fiveWindows:(id)sender {
    
    //test
    [self fiveTestVC];
    
    //alert
    //[self fiveAlertVC];
    
}

- (void)fiveAlertVC {
    for (int i = 0; i<5; i++) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:[NSString stringWithFormat:@"是否用外部程序打开:\n %@",@""]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        ZYPopupWindowOperation *op = [[ZYPopupWindowOperation alloc]initWithViewController:alert];
        op.priority = 1;
        
        [shareZYPopupWindowOperationQueue addPopupWindowOperation:op];
        //[self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)fiveTestVC {
    for (int i = 0; i<5; i++) {
        TestViewController *testVC = [TestViewController new];
        testVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        testVC.transitioningDelegate = self;
        
        ZYPopupWindowOperation *op = [[ZYPopupWindowOperation alloc]initWithViewController:testVC];
        op.priority = 1;
        
        if (i == 3) {
            op.priority = 100;
            testVC.view.backgroundColor = [UIColor orangeColor];
        }
        [shareZYPopupWindowOperationQueue addPopupWindowOperation:op];
        //[self presentViewController:testVC animated:YES completion:nil];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return _animate;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return _animate;
}

@end
