//
//  ZYPopupWindowAnimation.h
//  弹窗队列
//
//  Created by MaJunliang on 2017/12/15.
//  Copyright © 2017年 ZhangYue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYPopupWindowAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIView *mask;
@property (nonatomic, strong) UIViewController *presentedVC;

@end
