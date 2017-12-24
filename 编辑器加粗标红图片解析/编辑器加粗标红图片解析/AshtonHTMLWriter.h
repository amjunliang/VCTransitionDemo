#import <UIKit/UIKit.h>

@interface AshtonHTMLWriter : NSObject

+ (instancetype)sharedInstance;

- (NSString *)HTMLStringFromAttributedString:(NSAttributedString *)input;

@end
