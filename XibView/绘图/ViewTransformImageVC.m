//
//  ViewTransformImageVC.m
//  XibView
//
//  Created by Hibiscus on 2021/6/7.
//

#import "ViewTransformImageVC.h"

@interface ViewTransformImageVC ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *viewImv;

@end

@implementation ViewTransformImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self transformImage:self.viewImv.frame];
}

- (void)transformImage:(CGRect)rect{
    
    //获取图片上下文
    UIGraphicsBeginImageContext(self.backView.bounds.size);
    //获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //在上下文中进行渲染
    [self.backView.layer renderInContext:context];
    //获取当前图片的上下文
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    //结束图片的上下文
    UIGraphicsEndImageContext();
    self.viewImv.image = img;
}

@end
