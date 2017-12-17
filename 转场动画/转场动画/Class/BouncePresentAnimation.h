//
//  BouncePresentAnimation.h
//  转场动画
//
//  Created by 马俊良 on 2017/12/17.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BouncePresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIView *mask;
@property (nonatomic, strong) UIViewController *presentedVC;


@end
