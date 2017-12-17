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

@interface ViewController (){
    ZYPopupWindowOperationQueue *_queue;
    
}

@end

@implementation ViewController
- (IBAction)fiveWindows:(id)sender {
    
    //alert
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
    }
    
    //alert
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
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _queue = [ZYPopupWindowOperationQueue new];
    
}

@end
