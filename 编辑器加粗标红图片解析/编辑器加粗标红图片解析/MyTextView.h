//
//  MyTextView.h
//  编辑器加粗标红图片解析
//
//  Created by 马俊良 on 2017/12/23.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAttributedString+ZYRichTextEditer.h"
#import "ZYRichTextLayoutManager.h"
#import "ZYRichTextAttachment.h"

@interface MyTextView : UITextView

@property(nonatomic, assign) BOOL selecMarkRed;
@property(nonatomic, assign) BOOL selecMarkBlod;

@property(nonatomic, strong) NSString  *html;

@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

- (void)insertRichTextAttachment:(ZYRichTextAttachment *)attachment;
@end
