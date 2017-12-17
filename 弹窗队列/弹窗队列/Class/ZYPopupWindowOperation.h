//
//  ZYPopupWindowOperation.h
//  弹窗队列
//
//  Created by MaJunliang on 2017/12/15.
//  Copyright © 2017年 ZhangYue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYPopupWindowOperation : NSObject

- (instancetype)initWithViewController:(UIViewController *)popVC;

/// 弹窗控制器
@property (nonatomic, strong) UIViewController *viewController;

/// 优先级
@property (nonatomic, assign) NSInteger priority;

@end
