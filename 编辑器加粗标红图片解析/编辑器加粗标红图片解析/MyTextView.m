//
//  MyTextView.m
//  编辑器加粗标红图片解析
//
//  Created by 马俊良 on 2017/12/23.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "MyTextView.h"

@interface MyTextView ()

@end

static NSString const *kNSAttachment = @"NSAttachment";
@implementation MyTextView
#pragma mark - # 标红色
- (NSDictionary *)getInsetAttDic
{
    static NSInteger attIndex = 0;
    
    //init
    if (attIndex == 0) {
        attIndex = self.selectedRange.location;
    }
    
    //check
    if (attIndex == self.attributedText.length) {
        attIndex = self.attributedText.length-1;
        if (attIndex <0) {
            attIndex = 0;
        }
    }
    NSDictionary *dic;
    if (attIndex>self.attributedText.length) {
        dic= [self.attributedText attributesAtIndex:attIndex effectiveRange:nil];
    }else{
        dic = [self defaultAttribute];
    }
    
    
    BOOL dicFind = dic && ![dic objectForKey:kNSAttachment];
    BOOL endFind = attIndex == 0;
    
    if (dicFind || endFind) {
        attIndex = 0;
        return dic?:@{};
    }else{
        attIndex = attIndex -1;
        return [self getInsetAttDic];
    }
}
- (NSMutableParagraphStyle *)paragraphStyle
{
    if (!_paragraphStyle) {
        _paragraphStyle = [NSMutableParagraphStyle defaultParagraphStyle].mutableCopy;
    }
    return _paragraphStyle;
}

- (NSDictionary *)defaultAttribute
{
    return @{NSFontAttributeName: self.font?:[UIFont systemFontOfSize:16],
             NSForegroundColorAttributeName: self.textColor?:[UIColor blackColor],
            NSParagraphStyleAttributeName: self.paragraphStyle
            };
}

- (void)setTypingAttributes:(NSDictionary<NSString *,id> *)typingAttributes
{
    NSDictionary * dic = [self getInsetAttDic];
    NSMutableDictionary *mulDic = dic.mutableCopy?:@{}.mutableCopy;
    [mulDic addEntriesFromDictionary:typingAttributes];
    [super setTypingAttributes:mulDic];
    
    //setAtt
    [self.textStorage addAttributes:mulDic range:self.selectedRange];
}

- (NSRange)getSelectAttributeRange {
    NSRange selectRange = self.selectedRange;

    if (selectRange.length == 0) {
        
        char lastChar = 'a';
        if (selectRange.location>0) {
            lastChar = [self.text characterAtIndex:selectRange.location-1];
        }
        
        if (lastChar == '\n' ) {
            selectRange = NSMakeRange(selectRange.location,1);
        }else{
            selectRange = NSMakeRange(selectRange.location-1, 1);
        }
        
        //check
        if (selectRange.location +selectRange.length>self.text.length) {
            selectRange.length = 0;
        }
    }
    return selectRange;
}

- (BOOL)selecMarkRed
{
    NSRange selectRange = [self getSelectAttributeRange];
    NSAttributedString *att = [self.attributedText attributedSubstringFromRange:selectRange];
    return att.markRed;
}

- (void)setSelecMarkRed:(BOOL)selecTmarkRed
{
    
    if (selecTmarkRed) {
        [self setTypingAttributes: @{NSForegroundColorAttributeName:[UIColor redColor]}];
    } else {
        [self setTypingAttributes: @{NSForegroundColorAttributeName:[UIColor blackColor]}];
    }
}

#pragma mark - # 加粗

- (BOOL)selecMarkBlod
{
    NSRange selectRange = [self getSelectAttributeRange];
    NSAttributedString *att = [self.attributedText attributedSubstringFromRange:selectRange];
    return att.blod;
}

- (void)setSelecMarkBlod:(BOOL)selecMarkBlod{
    if (selecMarkBlod) {
        [self setTypingAttributes: @{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font.pointSize]}];
    } else {
        [self setTypingAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:self.font.pointSize]}];
    }
}

#pragma mark - # 插入 view

- (void)insertRichTextAttachment:(ZYRichTextAttachment *)attachment
{
    if (!attachment.attachedView) {
        return;
    }
    
    if (self.selectedRange.length) {
        [self deleteBackward];
    }
    
    NSMutableAttributedString *attachmentAtt = attachment.attributedString.mutableCopy;
    [attachmentAtt addAttributes:[self getInsetAttDic] range:NSMakeRange(0, attachmentAtt.length)];
    [self.textStorage insertAttributedString:attachmentAtt atIndex:self.selectedRange.location];
    
    NSRange range = NSMakeRange(MIN(self.textStorage.editedRange.location + self.textStorage.editedRange.length, self.textStorage.length), 0);
    self.selectedRange = range;
    
    //add view
    attachment.attachedView.alpha = 0;
    if (self.subviews.firstObject) {
        [self.subviews.firstObject addSubview:attachment.attachedView];
    }
}

- (instancetype)init
{
    ZYRichTextLayoutManager *manger = [ZYRichTextLayoutManager new];
    NSTextStorage *storage = [[NSTextStorage alloc]init];;
    [storage addLayoutManager:manger];
    NSTextContainer *container = [[NSTextContainer alloc]init];
    [manger addTextContainer:container];
    
    self = [super initWithFrame:CGRectZero textContainer:container];
    if (self) {
        self.typingAttributes = [self defaultAttribute];
    }
    return self;
}

#pragma mark - # Html 转码

- (void)setHtml:(NSString *)html
{
    if (!html) {
        return;
    }
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

    self.attributedText = attrStr;
}

- (NSString *)html
{
    if (!self.attributedText) {
        return nil;
    }
    
    NSArray *exclude = @[@"xml",@"doctype", @"html", @"head", @"body",@"p",@"STYLE",
                         @"APPLET", @"BASEFONT", @"CENTER", @"DIR", @"FONT", @"ISINDEX", @"MENU", @"S", @"STRIKE", @"U"];
    
    NSDictionary *htmlAtt = [NSDictionary dictionaryWithObjectsAndKeys:
                             NSHTMLTextDocumentType, NSDocumentTypeDocumentAttribute,
                             exclude, @"ExcludedElements", nil];
    NSError *error;
    NSData *htmlData = [self.attributedText dataFromRange:NSMakeRange(0,[self.attributedText length]) documentAttributes:htmlAtt error:&error ];
    NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    
    return htmlString;
}

@end
