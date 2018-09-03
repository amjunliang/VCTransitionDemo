//
//  UIView+Hightlight.h
//  阴阳屏
//
//  Created by 马俊良 on 2018/1/20.
//  Copyright © 2018年 马俊良. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HightliteGesture;
typedef void (^ViewTouchUpInsideBlock)(UIView *view);

@interface UIView (TouchUpInsideEvent)<UIGestureRecognizerDelegate>

- (void)addViewTouchUpInsideEventWithBlock:(ViewTouchUpInsideBlock)block;
- (void)removeViewTouchUpInsideEvent;
- (HightliteGesture *)hightliteGesture;
@end
