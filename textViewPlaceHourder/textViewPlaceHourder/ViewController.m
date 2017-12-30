//
//  ViewController.m
//  textViewPlaceHourder
//
//  Created by 马俊良 on 2017/12/30.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "ViewController.h"
#import "UITextViewPlace.h"
#import <JSONModel.h>

@interface CountryModel : JSONModel
@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *country;
@property (nonatomic) UIImage *img;

@end
@implementation CountryModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (BOOL)propertyIsIgnored:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"img"]) {
        return YES;
    }
    return NO;
}
@end;

@interface ViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextViewPlace *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self.textView setTextContainerInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.textView.maxNumberOfLines = 3;
    self.textView.placeholder = @"请输入文字请输入文字请输入文字请输入文字请输入文字请输入文字请输入文字请输入文字请输入文字请输入文字请输入文字请输入文字请输入文字";
    self.textView.placeholderTextColor = [UIColor redColor];
 
    CountryModel *model = [[CountryModel alloc]init];
    model.id = 100;
    model.country = @"北京";
    model.img = [UIImage imageNamed:@"img.jpg"];
    
    
    CountryModel *model1 = [[CountryModel alloc]initWithData:[model toJSONData] error:nil];
    
    //
    NSLog(@"%@",model1);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
