//
//  ZYPopupWindowOperationQueue.m
//  弹窗队列
//
//  Created by MaJunliang on 2017/12/15.
//  Copyright © 2017年 ZhangYue. All rights reserved.
//

#import "ZYPopupWindowOperationQueue.h"
#import "UIViewController+PopupWindow.h"

@interface ZYPopupWindowOperationQueue ()

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ZYPopupWindowOperationQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reiciveZYSwizzling_viewDidDisappearNotification:) name:ZYSwizzling_viewDidDisappearNotification object:nil];
    }
    return self;
}

#pragma mark - #


- (void)dealWithOperation:(ZYPopupWindowOperation *)popupWindowOperation {
    UIViewController *popVC = popupWindowOperation.viewController;
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    popVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [topVC presentViewController:popVC animated:YES completion:nil];
}

- (ZYPopupWindowOperation *)getPaxPriorityOperation
{
    
    if (!self.datas.count ) {
        return nil;
    }
    
    NSInteger maxPriority = 0;
    NSInteger index = 0;
    for (ZYPopupWindowOperation *op in self.datas) {
        if (op.priority>maxPriority) {
            index = [self.datas indexOfObject:op];
        }
    }
    
    return self.datas[index];
}

- (void)addPopupWindowOperation:(ZYPopupWindowOperation *)popupWindowOperation
{
    if (!popupWindowOperation.viewController) {
        return;
    }
    
    [self.datas addObject:popupWindowOperation];
    if (self.datas.count == 1) {
        [self dealWithOperation:popupWindowOperation];
    }

}

- (void)reiciveZYSwizzling_viewDidDisappearNotification:(NSNotification *)noti
{    
    for (int i = 0;i<self.datas.count;i++) {
        ZYPopupWindowOperation *op = self.datas[i];
        if (op.viewController == noti.object) {
            [self.datas removeObject:op];
            if (self.datas.count) {
                [self dealWithOperation:[self getPaxPriorityOperation]];
            }
        }
    }
}

+ (instancetype)share
{
    
    static dispatch_once_t onceToken;
    static ZYPopupWindowOperationQueue *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ZYPopupWindowOperationQueue alloc]init];
    });
    return instance;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - # Getter

- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}

@end
