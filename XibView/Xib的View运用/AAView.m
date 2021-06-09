//
//  AAView.m
//  XibView
//
//  Created by Hibiscus on 2021/6/1.
//

#import "AAView.h"
#import <AVFoundation/AVFoundation.h>

extern float ceilf(float);
extern double ceil(double);
extern long double ceill(long double);

extern float floorf(float);
extern double floor(double);
extern long double floorl(long double);

extern float roundf(float);
extern double round(double);
extern long double roundl(long double);

@implementation AAView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    NSLog(@"========initFrame");
    self = [[NSBundle mainBundle]loadNibNamed:@"AAView" owner:self options:nil].firstObject;
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"========awakeFromNib");
}

//延迟函数
- (void)printLog{
    NSLog(@"============");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"===GCD====");
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"112221231212");
    });
    
    NSLog(@"111111111111");
}


- (IBAction)clickAction:(id)sender {
    [self printLog];
//    NSLog(@"====%@",[self tt_ClientFeeCalculationMethodWithString:@"98.4569" with:@"6.9323"]);
//    NSLog(@"大爷，点我了");
//    UIWindow *mainWindow = [[UIApplication sharedApplication]windows].lastObject;
//    UIViewController *vc = mainWindow.rootViewController;
//    NSLog(@"===currentVC:%@",NSStringFromClass([vc class]));
//
//    NSLog(@"%f",ceil(30.9));
//
////    round(<#double#>) 四舍五入
////    ceil(<#double#>) 向上取整
////    floor(<#double#>) 向下取整
//
//    //跳转到设置界面
//    if(UIApplicationOpenSettingsURLString != nil){
//        UIApplication *app = [UIApplication sharedApplication];
//        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        if([app respondsToSelector:@selector(openURL:options:completionHandler:)]){
//            [app openURL:url options:@{} completionHandler:nil];
//        }else{
//
//            [app openURL:url options:@{} completionHandler:nil];
//            //运行在主线程
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//            });
//        }
//    }
}

//获取图片的第一帧图片
- (UIImage *)generateFirstImage:(NSString *)filePath{
    NSURL *url = [NSURL URLWithString:filePath];
    AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generate1 = [[AVAssetImageGenerator alloc] initWithAsset:asset1];
    generate1.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 2);
    CGImageRef oneRef = [generate1 copyCGImageAtTime:time actualTime:NULL error:&err];
    UIImage *one = [[UIImage alloc] initWithCGImage:oneRef];
    return one;
}

/**
 客户端手续费计算方法并解决金额精度问题
 @param amountValue 用户输入的具体金额
 @param rateValue   后台给予的费率
 @return            客户端计算出的手续费
 */
-(NSString *)tt_ClientFeeCalculationMethodWithString:(NSString *)amountValue with:(NSString *)rateValue{
    /*手续费计算精度问题解决：NSDecimalNumber
     加: decimalNumberByAdding
     减: decimalNumberBySubtracting：
     乘: decimalNumberByMultiplyingBy：
     除: decimalNumberByDividingBy：
     */
    rateValue = [NSString stringWithFormat:@"%@%%",rateValue];
    NSLog(@"%@",rateValue);
    NSDecimalNumber *rateValueNumber = [NSDecimalNumber decimalNumberWithString:rateValue];
    NSDecimalNumber *oneHundredValueNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d", 100]];
    NSDecimalNumber *division = [rateValueNumber decimalNumberByDividingBy:oneHundredValueNumber];
    NSDecimalNumber *amountValueNumber = [NSDecimalNumber decimalNumberWithString:amountValue];
    NSDecimalNumber *product = [amountValueNumber decimalNumberByMultiplyingBy:division];
    NSLog(@"%@", [product stringValue]);
    
    /*四舍五入精确度问题解决：NSDecimalNumberHandler
     讲述下参数的含义:
     RoundingMode: 简单讲就是你要四舍五入操作的标准.
     scale : 需要保留的精度。
     raiseOnExactness : 为YES时在处理精确时如果有错误，就会抛出异常。
     raiseOnOverflow  : YES时在计算精度向上溢出时会抛出异常，否则返回。
     raiseOnUnderflow : YES时在计算精度向下溢出时会抛出异常，否则返回.
     raiseOnDivideByZero : YES时。当除以0时会抛出异常，否则返回。
     */
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp
                                                                                                      scale:2
                                                                                           raiseOnExactness:NO
                                                                                            raiseOnOverflow:NO
                                                                                           raiseOnUnderflow:NO
                                                                                        raiseOnDivideByZero:NO];
    NSString *tempStr =[[product decimalNumberByRoundingAccordingToBehavior:roundingBehavior] stringValue];
    NSLog(@"%@",tempStr);
    return tempStr;
}

@end
