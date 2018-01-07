//
//  RTViewController.m
//  RTViewAttachment
//
//  Created by Ricky Tan on 06/17/2016.
//  Copyright (c) 2016 Ricky Tan. All rights reserved.
//

#import <RTViewAttachment/RTViewAttachment.h>
#import <RTViewAttachment/RTViewAttachmentTextView.h>
#import "RTTextVIew.h"

#import "RTViewController.h"

@interface RTViewController () <RTViewAttachmentTextViewDelegate>
@property (nonatomic, assign) IBOutlet RTViewAttachmentTextView *textView;
@property (nonatomic, assign) IBOutlet UIView *inputAccessoryView;
@property (nonatomic, assign) IBOutlet RTTextVIew *insertView;

@end

@implementation RTViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.textView.textView.contentInset = UIEdgeInsetsMake(100, 40, 6, 16);
    self.textView.font = [UIFont systemFontOfSize:24.f];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.textView becomeFirstResponder];
}

- (IBAction)onPrepend:(id)sender {
    [self.textView insertViewAttachment:[[RTViewAttachment alloc] initWithView:[[UISwitch alloc] init]
                                                               placeholderText:@"[switch]"]
                                atIndex:0];
}

- (IBAction)onAppend:(id)sender {
    [self.textView insertViewAttachment:[[RTViewAttachment alloc] initWithView:[[UISwitch alloc] init]
                                                               placeholderText:@"[switch]"]
                                atIndex:self.textView.length];
}

- (IBAction)onInsertSearchBar:(id)sender {
//    UISearchBar *bar = [[UISearchBar alloc] init];
//    [bar sizeToFit];
//    [self.textView insertViewAttachment:[[RTViewAttachment alloc] initWithView:bar
//                                                               placeholderText:@"[searchbar]"
//                                                                     fullWidth:YES]];
//
    //
    
    UIView *v = [RTTextVIew new];
    v.frame = CGRectMake(0, 0, 0, 1000);// 宽度自适应, 需要的是高度,
    [self.textView insertViewAttachment:[[RTViewAttachment alloc] initWithView:v
                                                               placeholderText:@"[searchbar]"
                                                                     fullWidth:YES]];
}

- (IBAction)onInsertImage:(id)sender {
    [self.textView insertViewAttachment:[[RTViewAttachment alloc] initWithView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dog"]]
                                                               placeholderText:@"[image name='dog']"]];
}

#pragma mark - RTViewAttachment Delegate

- (BOOL)attachmentTextView:(RTViewAttachmentTextView *)attachmentTextView
   shouldDeleteAttachments:(NSArray<RTViewAttachment *> *)attachments
{
    return YES;
}

@end
