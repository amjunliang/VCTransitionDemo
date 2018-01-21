//
//  ViewController.m
//  阴阳屏
//
//  Created by 马俊良 on 2018/1/14.
//  Copyright © 2018年 马俊良. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Hightlight.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *vvv;
@property(nonatomic, weak) IBOutlet UITextView * tx;

@end

@implementation ViewController

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.view.subviews.firstObject addHighlightedStyle];

    [self.vvv addViewTouchUpInsideEventWithBlock:^(UIView *view) {
        NSLog(@"addViewTouchUpInsideEventWithBlock");
    }];
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (IBAction)tabB:(UITapGestureRecognizer *)sender {
    
    NSLog(@"%@",sender.view);
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   NSLog(@"vc touchesBegan");

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"vc touchesCancelled");

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"vc touchesEnded");
}
@end
