//
//  ViewController.m
//  PageScroll
//
//  Created by 马俊良 on 2018/1/21.
//  Copyright © 2018年 马俊良. All rights reserved.
//

#import "ViewController.h"
#import "UIView+TouchUpInsideEvent.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setDelegate:self];
        //_scrollView.pagingEnabled =YES;
    }
    return _scrollView;
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat kCellWidth = scrollView.subviews.firstObject.frame.size.width;
    CGFloat kCellSpacing = 30;
    CGFloat kMaxIndex = scrollView.subviews.count;
    
    CGFloat targetX = scrollView.contentOffset.x + velocity.x * 1000.0;
    CGFloat targetIndex = round(targetX / (kCellWidth + kCellSpacing));
    if (targetIndex < 0)
        targetIndex = 0;
    if (targetIndex > kMaxIndex)
        targetIndex = kMaxIndex;
    targetContentOffset->x = targetIndex * (kCellWidth + kCellSpacing);


}

static CGFloat margin = 60;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.scrollView];
    
    for (int i=0; i<5; i++) {
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor orangeColor];
        v.clipsToBounds = YES;
        v.layer.cornerRadius = 10;
        
        UILabel *lab = [UILabel new];
        lab.text = @"lab";
        [v addSubview:lab];
        [lab sizeToFit];
        
        [self.scrollView addSubview:v];
    
        [v addViewTouchUpInsideEventWithBlock:^(UIView *view) {
            //[self scrollViewWillEndDragging:_scrollView withVelocity:CGPointMake(0, 0) targetContentOffset:nil];
            //[self.scrollView scrollRectToVisible:v.frame animated:YES];
            //[self.scrollView setContentOffset:CGPointMake(v.frame.origin.x, 0)] ;
            [self.scrollView setContentOffset:CGPointMake(v.frame.origin.x-margin, 0) animated:YES];
        }];
    }

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _scrollView.frame = self.view.bounds;

    CGFloat lastx = margin;
    for (int i=0; i<5; i++) {
        UIView *v = self.scrollView.subviews[i];
        CGRect rect = CGRectMake(lastx, margin, self.view.frame.size.width-margin*2, self.view.frame.size.height-margin*2);
        v.frame = rect;
        _scrollView.contentSize = CGSizeMake(lastx+rect.size.width+margin, 1);
        lastx = lastx+rect.size.width +30;
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
