//
//  UITextViewPlace.m
//  textViewPlaceHourder
//
//  Created by 马俊良 on 2017/12/30.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "UITextViewPlace.h"
@interface UITextViewPlace (){
    CGFloat _contentHeight;
}

/// 占位符
@property (nonatomic, strong) UITextView *placeholderView;
@property(nonatomic, assign) CGFloat maxContentHeight;

@end
@implementation UITextViewPlace

- (CGFloat)contentHeight
{
    CGFloat contentHeightSelf = [self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height;
    CGFloat contentHeightPlaceholder = [self.placeholderView sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height;
    return self.text.length?contentHeightSelf:contentHeightPlaceholder;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp {
    [self addSubview:self.placeholderView];
    _maxContentHeight = MAXFLOAT;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedUITextViewTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:nil];
    [self changeBounds];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}


- (void)changeBounds {
    self.placeholderView.alpha = self.text.length?0:1;
    
    if (!self.autoGrow) {
        return;
    }
    
    //fit contentHeit
    CGFloat contentHeight = [self contentHeight];
    if (ceil(_contentHeight) != ceil(contentHeight)) {
        // scroll
        self.scrollEnabled = contentHeight > _maxContentHeight?YES:NO;
        
        //set
        if (contentHeight>_maxContentHeight) {
            contentHeight = _maxContentHeight;
        }
        CGRect rect = self.bounds;
        rect.size.height = contentHeight;
        self.bounds = rect;
    }
    _contentHeight = ceil(contentHeight);
}

- (void)receivedUITextViewTextDidChangeNotification:(NSNotification *)noti
{
    
    if (noti.object == self) {
        [self changeBounds];
    }
}

- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines
{
    _maxNumberOfLines = maxNumberOfLines;
    _maxContentHeight = self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom;
    
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self.placeholderView setFont:font];
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    [super setContentInset:contentInset];
    [self.placeholderView setContentInset:contentInset];
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset
{
    [super setTextContainerInset:textContainerInset];
    [self.placeholderView setTextContainerInset:textContainerInset];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholderView.text = placeholder;
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor
{
    _placeholderTextColor = placeholderTextColor;
    self.placeholderView.textColor = placeholderTextColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.placeholderView.frame = self.bounds;
}

#pragma mark - # Getter
- (UITextView *)placeholderView
{
    if (!_placeholderView)
    {
        _placeholderView = [[UITextView alloc] init];
        _placeholderView.userInteractionEnabled = NO;
        [_placeholderView setTextColor:[UIColor blackColor]];
        _placeholderView.backgroundColor = [UIColor clearColor];
    }
    return _placeholderView;
}


@end
