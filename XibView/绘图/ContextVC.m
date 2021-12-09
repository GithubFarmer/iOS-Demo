//
//  ContextVC.m
//  XibView
//
//  Created by Hibiscus on 2021/6/4.
//

#import "ContextVC.h"
#import "ContextView.h"

static NSString *name = @"";

@interface ContextVC ()
@property (weak, nonatomic) IBOutlet UIImageView *topImv;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImv;

@property (nonatomic, assign) NSInteger initNumber;
@property (nonatomic, copy) NSString *iInitString;

@end

@implementation ContextVC

//+ (void)load {
//    printf("我是load方法");
//}

+ (void)initialize{
    printf("***********我是initialize方法");
    name = @"111111119999999999";
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage* mars = [UIImage imageNamed:@"photo.png"];
    self.topImv.image = mars;
   // [self movePhoto:mars];
  //    [self scalePhoto:mars];
 //    [self cutPhoto:mars];
    ContextView *refView = [[ContextView alloc]init];
    refView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:refView];
    [refView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImv.mas_bottom).offset(5);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    NSLog(@"%@", name);
}

//MARK: 平移图片
- (void)movePhoto:(UIImage *)mars{
    CGSize sz = [mars size];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width*2, sz.height), NO, 0);
    //第一个参数：size：创建图片大小
    //第二个参数：bool：创建图片是否为不透明
    //第三个参数：生成图片的缩放因子，0为根据屏幕分辨率缩放
    [mars drawAtPoint:CGPointMake(0,0)];
    [mars drawAtPoint:CGPointMake(sz.width,0)];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.bottomImv.image = im;
}

//缩放图片
- (void)scalePhoto:(UIImage *)mars{


    CGSize sz = [mars size];
    UIGraphicsBeginImageContextWithOptions(sz, NO, 0);
    [mars drawInRect:CGRectMake(0,0,sz.width,sz.height)];
    [mars drawInRect:CGRectMake(sz.width/2.0, sz.height/2.0, sz.width/2, sz.height/2) blendMode:kCGBlendModeMultiply alpha:1.0];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.bottomImv.image = im;
}

//裁剪图片
- (void)cutPhoto:(UIImage *)mars{
    CGSize sz = [mars size];
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width/2, sz.height), NO, 0);
//   // [mars drawAtPoint:CGPointMake(0,0)]; //左半边
//    [mars drawAtPoint:CGPointMake(-sz.width/2,0)]; //右半边
    
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width, sz.height/2), NO, 0);
////    [mars drawAtPoint:CGPointMake(0,0)];//上半边
//    [mars drawAtPoint:CGPointMake(0, -sz.height/2)];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width/2, sz.height), NO, 0);
    [mars drawInRect:CGRectMake(0, 0, sz.width/2, sz.height)];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.bottomImv.image = im;
}



@end
