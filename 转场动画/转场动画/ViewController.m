//
//  ViewController.m
//  转场动画
//
//  Created by 马俊良 on 2017/12/17.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "ViewController.h"
#import "BouncePresentAnimation.h"
#import "SwipeUpInteractiveTransition.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define randomColor random(arc4random_uniform(2), arc4random_uniform(256), arc4random_uniform(256), 1)

@interface ViewController ()<UIViewControllerTransitioningDelegate>
{
      SwipeUpInteractiveTransition *swipeAnimate;
}

@end
static  BouncePresentAnimation *animate;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = randomColor;
    self.view.superview.clipsToBounds = YES;
    if (!animate) {
        animate = [BouncePresentAnimation new];
    }
    swipeAnimate = [SwipeUpInteractiveTransition new];
    
}

- (IBAction)pre:(id)sender {
    
    /*
      UIModalPresentationFullScreen = 0,
      UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
      UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
      UIModalPresentationCurrentContext NS_ENUM_AVAILABLE_IOS(3_2),
      UIModalPresentationPopover NS_ENUM_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED,

     UIModalPresentationOverFullScreen NS_ENUM_AVAILABLE_IOS(8_0),
     UIModalPresentationOverCurrentContext NS_ENUM_AVAILABLE_IOS(8_0),

     
     UIModalPresentationCustom NS_ENUM_AVAILABLE_IOS(7_0),//over
     UIModalPresentationNone NS_ENUM_AVAILABLE_IOS(7_0) = -1,//he specified modal presentation style doesn't have a corresponding presentation controller.

     UIModalPresentationBlurOverFullScreen __TVOS_AVAILABLE(11_0) __IOS_PROHIBITED __WATCHOS_PROHIBITED,

     
     */
    
    ViewController *vc = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
    //vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
    
    [swipeAnimate wireToViewController:vc];
    
}

- (IBAction)disMiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - # delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
    return animate;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return animate;

}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return swipeAnimate;
}

- (void)viewWillDisappear:(BOOL)animated
{
    
}

@end
