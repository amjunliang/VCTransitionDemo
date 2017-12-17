//
//  ZYPopupWindowOperationQueue.h
//  弹窗队列
//
//  Created by MaJunliang on 2017/12/15.
//  Copyright © 2017年 ZhangYue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYPopupWindowOperation.h"

/// 弹窗队列, 你可以使用alloc init 创建一个自己的新队列使用, 或者使用全局的队列
@interface ZYPopupWindowOperationQueue : NSObject

/// 添加一项弹窗任务, 并立即开始.
- (void)addPopupWindowOperation:(ZYPopupWindowOperation *)popupWindowOperation;

/// 全局队列
#define shareZYPopupWindowOperationQueue [ZYPopupWindowOperationQueue share]
+ (instancetype)share;
@end
