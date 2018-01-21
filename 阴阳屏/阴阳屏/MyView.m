//
//  MyView.m
//  阴阳屏
//
//  Created by 马俊良 on 2018/1/20.
//  Copyright © 2018年 马俊良. All rights reserved.
//

#import "MyView.h"

@implementation MyView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"view touchesBegan");

}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"view touchesCancelled");
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"view touchesEnded");
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = self.bounds;
    rect.origin.x -= 100;
    rect.size.width += 10;
    rect.origin.y -= 5;
    rect.size.height += 10;
    return CGRectContainsPoint(rect, point);
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //NSLog(@"%zd",self.tag);

    //NSLog(@"\nhitTest%@",NSStringFromCGPoint(point));
    return [super hitTest:point withEvent:event];
}

@end
