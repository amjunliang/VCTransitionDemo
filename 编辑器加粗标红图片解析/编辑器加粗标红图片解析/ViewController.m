//
//  ViewController.m
//  编辑器加粗标红图片解析
//
//  Created by 马俊良 on 2017/12/23.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "ViewController.h"
#import "MyTextView.h"
#import "NSAttributedString+ZYRichTextEditer.h"
#import "ZYRichTextAttachment.h"

@interface ViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *blod;
@property (weak, nonatomic) IBOutlet UIButton *markRed;
@property (strong, nonatomic) IBOutlet MyTextView *textView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.textView removeFromSuperview];
    
    self.textView  =[[MyTextView alloc]init];
    self.textView.frame = self.view.bounds;
    [self.view addSubview:self.textView];
    [self.view sendSubviewToBack:self.textView];
    self.textView.font = [UIFont systemFontOfSize:20];
    
    self.textView.delegate = self;
    self.textView.allowsEditingTextAttributes = NO;
    [self.textView becomeFirstResponder];
    //self.textView.clearsOnInsertion = YES;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [textView.textStorage enumerateAttribute:NSAttachmentAttributeName
                                     inRange:range
                                     options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                                  usingBlock:^(ZYRichTextAttachment *value, NSRange range, BOOL * stop) {
                                      if ([value isKindOfClass:[ZYRichTextAttachment class]]) {
                                          [value.attachedView removeFromSuperview];
                                      }
                                  }];
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    //NSLog(@"%@",textView.text);
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    _markRed.selected = self.textView.selecMarkRed;
    _blod.selected = self.textView.selecMarkBlod;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)blodIte:(UIButton *)sender
{
    if (sender.selected) {
        self.textView.selecMarkBlod = NO;
    } else {
        self.textView.selecMarkBlod = YES;
    }
    sender.selected = !sender.selected;

}


- (IBAction)markRedIt:(UIButton *)sender
{
    
    if (sender.selected) {
        self.textView.selecMarkRed = NO;
    } else {
        self.textView.selecMarkRed = YES;
    }
    sender.selected = !sender.selected;
}
- (IBAction)insetView:(UIButton *)sender
{
    ZYRichTextAttachment *attachMent = [ZYRichTextAttachment new];
    attachMent.attachedView = [self attachView];
    [self.textView insertRichTextAttachment:attachMent];
    
}

- (UIView *)attachView
{
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor orangeColor];
    v.frame = CGRectMake(0, 0, 100, 100);
    
    return v;
    
}


@end
