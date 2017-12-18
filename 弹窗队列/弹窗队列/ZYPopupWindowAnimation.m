//
//  ZYPopupWindowAnimation.m
//  弹窗队列
//
//  Created by MaJunliang on 2017/12/15.
//  Copyright © 2017年 ZhangYue. All rights reserved.
//

#import "ZYPopupWindowAnimation.h"

@implementation ZYPopupWindowAnimation


#pragma mark - # Getter
- (UIView *)mask
{
    if (!_mask)
    {
        _mask = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
        _mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [_mask addGestureRecognizer:tap];
        _mask.userInteractionEnabled = YES;
        _mask.frame = CGRectMake(0, 0, 1000, 10000);
    }
    return _mask;
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer {
    if (self.presentedVC) {
        [self.presentedVC dismissViewControllerAnimated:YES completion:nil];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *transitionView = [transitionContext containerView];

    BOOL presented = [fromController presentedViewController] == toController;
    self.presentedVC = toController;
    
    if (presented) {
        _mask.alpha = 0;
        
        [transitionView insertSubview:self.mask atIndex:0];
        [transitionView addSubview: toController.view];
        [transitionView bringSubviewToFront:toController.view];
        toController.view.frame = CGRectInset(fromController.view.frame, 30, 100);
        toController.view.transform = CGAffineTransformMakeScale(0.6, 0.6);
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             _mask.alpha = 1;
                             toController.view.transform = CGAffineTransformIdentity;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }else{
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             _mask.alpha = 0;
                             fromController.view.frame =CGRectOffset(fromController.view.frame, 0, fromController.view.frame.size.height);
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
    
}

@end
