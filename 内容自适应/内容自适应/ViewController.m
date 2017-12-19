//
//  ViewController.m
//  内容自适应
//
//  Created by 马俊良 on 2017/12/19.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "ViewController.h"
#import "ContetView.h"
#import "ContentViewController.h"
#import "MyTX.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet MyTX *textView;
@property (strong, nonatomic)  ContetView *contentView;
@property (strong, nonatomic)  ContentViewController *contentViewController;

@end

@implementation ViewController

- (ContentViewController *)contentViewController
{
    if (!_contentViewController) {
        _contentViewController = [[ContentViewController alloc]init];
    }
    return _contentViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView.tintColor = [UIColor orangeColor];
    
}

- (void)transation:( CGRect )frame {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.contentViewController.view.frame = frame;
        _textView.inputViewController = self.contentViewController;
        
        //self.contentView.frame = frame;
        //_textView.inputView = self.contentView;
        
        [_textView reloadInputViews];
        [_textView becomeFirstResponder];
    }];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [_textView reloadInputViews];
}

- (IBAction)akeyboard:(id)sender {
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300);
    [self transation:frame];
    
}

 - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.contentViewController.view.frame = CGRectMake(0, 0, 100, 30);
    //[_textView reloadInputViews];
    //[self.view endEditing:YES];
   // _textView.inputViewController = nil;

}
- (ContetView *)contentView
{
    if (!_contentView) {
        _contentView = [ContetView new];
        _contentView.backgroundColor = self.view.tintColor;
        //_contentView.frame = CGRectMake(0, 0, 100, 100);
        //_contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.autoresizingMask = UIViewAutoresizingNone;

    }
    return _contentView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
