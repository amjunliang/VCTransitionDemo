//
//  UIView+Hightlight.m
//  阴阳屏
//
//  Created by 马俊良 on 2018/1/20.
//  Copyright © 2018年 马俊良. All rights reserved.
//

#import "UIView+TouchUpInsideEvent.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <objc/runtime.h>


@interface HightliteGesture : UIGestureRecognizer

@property(nonatomic, assign) NSInteger tag;
@property(nonatomic, assign) BOOL touchContain;

@end
@implementation HightliteGesture

- (void)update:(NSSet<UITouch *> *)touches
{
    self.touchContain = [self.view pointInside:[touches.anyObject locationInView:self.view] withEvent:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self update:touches];
    self.state = UIGestureRecognizerStateBegan;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self update:touches];
    self.state = UIGestureRecognizerStateChanged;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self update:touches];
    self.state = UIGestureRecognizerStateFailed;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self update:touches];
    self.state = UIGestureRecognizerStateEnded;
}

@end

@implementation UIView (TouchUpInsideEvent)

- (void)addViewTouchUpInsideEventWithBlock:(ViewTouchUpInsideBlock)block
{
    
    if (block) {
        [self setViewTouchUpInsideBlock:block];
        [self addHighlightedStyle];
    }
}

- (void)removeViewTouchUpInsideEvent
{
    [self removeHighlightedStyle];
    [self setViewTouchUpInsideBlock:nil];
}

static char kAssociatedObjectKey_viewTouchUpInsideBlock;
- (void)setViewTouchUpInsideBlock:(ViewTouchUpInsideBlock)block {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_viewTouchUpInsideBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ViewTouchUpInsideBlock)viewTouchUpInsideBlock {
    return (ViewTouchUpInsideBlock)objc_getAssociatedObject(self, &kAssociatedObjectKey_viewTouchUpInsideBlock);
}

- (void)addHighlightedStyle
{
    if ([self hightliteGesture] == nil) {
        HightliteGesture *ges = [[HightliteGesture alloc]initWithTarget:self action:@selector(handleHightliteGesture:)];
        //ges.cancelsTouchesInView = NO;
        //ges.delaysTouchesBegan = NO;
        //ges.delaysTouchesEnded = NO;
        [self addGestureRecognizer:ges];
        ges.delegate = self;
        if ([self.superview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *sv = (id)self.superview;
            [ges requireGestureRecognizerToFail:sv.panGestureRecognizer];
        }
        
    }
}
- (void)removeHighlightedStyle
{
    for (HightliteGesture *ges in self.gestureRecognizers) {
        if ([ges isKindOfClass:[HightliteGesture class]]) {
            [self removeGestureRecognizer:ges];
        }
    }
}

- (HightliteGesture *)hightliteGesture
{
    
    for (HightliteGesture *ges in self.gestureRecognizers) {
        if ([ges isKindOfClass:[HightliteGesture class]]) {
            return ges;
        }
    }
    return nil;
}

- (void)handleHightliteGesture:(HightliteGesture *)ges
{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        if (ges.touchContain) {
            for (UIView *v in self.subviews) {
                v.alpha = 0.6;
            }
        }else{
            for (UIView *v in self.subviews) {
                v.alpha = 1;
            }
        }
        
        if (ges.state == UIGestureRecognizerStateEnded||
            ges.state == UIGestureRecognizerStateFailed||
            ges.state == UIGestureRecognizerStateCancelled
            ) {
            for (UIView *v in self.subviews) {
                v.alpha = 1;
            }
        }
        
    } completion:nil];

    if (ges.state == UIGestureRecognizerStateEnded) {
        if (ges.touchContain) {
            if ([self viewTouchUpInsideBlock]) {
                [self viewTouchUpInsideBlock](self);
            }
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end

