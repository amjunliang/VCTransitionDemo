//
//  UITextViewPlace.h
//  textViewPlaceHourder
//
//  Created by 马俊良 on 2017/12/30.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextViewPlace : UITextView

@property (copy, nonatomic) NSString *placeholder;
@property (retain, nonatomic) UIColor *placeholderTextColor;
@property (nonatomic, assign) NSUInteger maxNumberOfLines;
@property(nonatomic, assign) BOOL autoGrow;
@end
