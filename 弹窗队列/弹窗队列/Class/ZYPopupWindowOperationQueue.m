//
//  ZYPopupWindowOperationQueue.m
//  弹窗队列
//
//  Created by MaJunliang on 2017/12/15.
//  Copyright © 2017年 ZhangYue. All rights reserved.
//

#import "ZYPopupWindowOperationQueue.h"
#import "UIViewController+PopupWindow.h"
#import "ZYPopupWindowPresentationController.h"

@interface ZYPopupWindowOperationQueue ()

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation ZYPopupWindowOperationQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lock = [NSRecursiveLock new];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reiciveZYSwizzling_viewDidDisappearNotification:) name:ZYSwizzling_viewDidDisappearNotification object:nil];
    }
    return self;
}

#pragma mark - #


- (void)dealWithOperation:(ZYPopupWindowOperation *)popupWindowOperation {
    
    if (!popupWindowOperation) {
        return;
    }
    
    UIViewController *popVC = popupWindowOperation.viewController;
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    //转场控制
    popVC.modalPresentationStyle = UIModalPresentationCustom;
    Class class = [ZYPopupWindowPresentationController class];
    if (
        [popupWindowOperation.class isKindOfClass:[UIPresentationController class]] ||
        [popupWindowOperation.class conformsToProtocol:@protocol(UIViewControllerTransitioningDelegate)] ||
        [popupWindowOperation.class conformsToProtocol:@protocol(UIViewControllerAnimatedTransitioning)]
        ) {
        class = popupWindowOperation.class;
    }
    ZYPopupWindowPresentationController *presentationController = [[class alloc] initWithPresentedViewController:popVC presentingViewController:popVC];
    popVC.transitioningDelegate = presentationController;
    
    [topVC presentViewController:popVC animated:YES completion:nil];
}

- (ZYPopupWindowOperation *)getMaxPriorityOperation
{
    NSInteger maxPriority = 0;
    ZYPopupWindowOperation *resOp = self.datas.firstObject;
    //nssort
    for (int i = 0;i<self.datas.count;i++) {
        ZYPopupWindowOperation *op = self.datas[i];
        if (op.priority>maxPriority) {
            maxPriority = op.priority;
            resOp = op;
        }
    }
    
    return resOp;
}

- (void)addPopupWindowOperation:( ZYPopupWindowOperation *)popupWindowOperation
{
    if (!popupWindowOperation) {
        return;
    }
    
    [self.lock lock];
    [self.datas addObject:popupWindowOperation];
    [self.lock unlock];
    if (self.datas.count == 1) {
        [self dealWithOperation:popupWindowOperation];
    }

}

- (void)reiciveZYSwizzling_viewDidDisappearNotification:(NSNotification *)noti
{
    //vc,
    for (int i = 0;i<self.datas.count;i++) {
        ZYPopupWindowOperation *op = self.datas[i];
        if (op.viewController == noti.object) {// 判断
            [self.datas removeObject:op];
            if (self.datas.count) {
                [self dealWithOperation:[self getMaxPriorityOperation]];
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
