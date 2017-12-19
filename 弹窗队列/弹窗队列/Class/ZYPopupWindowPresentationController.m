//
//  ZYPopupWindowPresentationController.m
//  弹窗队列
//
//  Created by 马俊良 on 2017/12/19.
//  Copyright © 2017年 ZhangYue. All rights reserved.
//

#import "ZYPopupWindowPresentationController.h"

@interface ZYPopupWindowPresentationController ()

@property (nonatomic, strong) UIView *mask;

@end

@implementation ZYPopupWindowPresentationController

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
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6;
}

- (CGRect)frameOfPresentedViewInContainerView
{
    UIInterfaceOrientation cur = [[UIApplication sharedApplication] statusBarOrientation];
    if ( UIInterfaceOrientationIsLandscape(cur) ) {
        return CGRectInset(self.presentingViewController.view.frame, 30, 100);
        
    }else{
        return self.containerView.bounds;
    }
    
}

- (void)containerViewWillLayoutSubviews
{
    self.presentedView.frame = self.frameOfPresentedViewInContainerView;
}

- (BOOL)shouldRemovePresentersView{
    return NO;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self.presentedView setNeedsLayout];
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *transitionView = [transitionContext containerView];
    
    BOOL presented = [fromController presentedViewController] == toController;
    
    if (presented) {
        self.mask.alpha = 0;
        [transitionView insertSubview:self.mask atIndex:0];
        [transitionView addSubview: toController.view];
        [transitionView bringSubviewToFront:toController.view];
        toController.view.frame = self.frameOfPresentedViewInContainerView;
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

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return self;
}
@end
