//
//  ZYPopupWindowOperation.m
//  弹窗队列
//
//  Created by MaJunliang on 2017/12/15.
//  Copyright © 2017年 ZhangYue. All rights reserved.
//

#import "ZYPopupWindowOperation.h"

@interface ZYPopupWindowOperation ()



@end


@implementation ZYPopupWindowOperation

- (instancetype)initWithViewController:(UIViewController *)popVC
{
    self = [super init];
    if (self) {
        _viewController = popVC;
    }
    return self;
}

@end
