
#import <UIKit/UIKit.h>
@interface AshtonHTMLReader : NSObject

+ (instancetype)HTMLReader;
+ (void)clearStylesCache;
- (NSAttributedString *)attributedStringFromHTMLString:(NSString *)htmlString;
- (NSAttributedString *)attributedStringFromHTMLString:(NSString *)htmlString error:(__autoreleasing NSError **)error;

@end
