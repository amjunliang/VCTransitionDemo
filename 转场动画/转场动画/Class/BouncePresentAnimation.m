//
//  BouncePresentAnimation.m
//  转场动画
//
//  Created by 马俊良 on 2017/12/17.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "BouncePresentAnimation.h"
@implementation BouncePresentAnimation

#pragma mark - # Getter
- (UIView *)mask
{
    if (!_mask)
    {
        _mask = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
        _mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [_mask addGestureRecognizer:tap];
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
    return 1;
}



- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *transitionView = [transitionContext containerView];
    //[transitionView insertSubview:self.mask atIndex:0];
    self.mask.frame = transitionView.bounds;
    [transitionView addSubview: toController.view];

    BOOL presented = [fromController presentedViewController] == toController;
    
    //mask
    self.presentedVC = toController;
    
    if (presented) {
        [transitionView bringSubviewToFront:toController.view];
        toController.view.frame =CGRectOffset(fromController.view.frame, 0, fromController.view.frame.size.height);
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseIn animations:^{
                                toController.view.frame = CGRectInset(fromController.view.frame, 0, 0);
                                
                            } completion:^(BOOL finished) {
                                [transitionContext completeTransition:YES];
                            }];
    }else{
        [transitionView sendSubviewToBack:toController.view];
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn animations:^{
                                fromController.view.frame =CGRectOffset(fromController.view.frame, 0, fromController.view.frame.size.height);
                            } completion:^(BOOL finished) {
                               [transitionContext completeTransition:YES];
                            }];
    }

}

@end
