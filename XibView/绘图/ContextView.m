//
//  ContextView.m
//  XibView
//
//  Created by Hibiscus on 2021/6/4.
//

#import "ContextView.h"

@implementation ContextView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //core Graphics画图
//    CGContextAddEllipseInRect(context, CGRectMake(10, 10, 30, 30));
//    CGContextAddArc(<#CGContextRef  _Nullable c#>, <#CGFloat x#>, <#CGFloat y#>, <#CGFloat radius#>, <#CGFloat startAngle#>, <#CGFloat endAngle#>, <#int clockwise#>)
//    CGContextAddArc(context, 190, 25, 5, M_PI/2, M_PI, YES);
//    CGContextSetLineWidth(context, 3);
//    CGContextDrawLayerInRect(context, rect, <#CGLayerRef  _Nullable layer#>)
    
  
    //layer赋值
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
//    gradientLayer.locations = @[@0.3, @0.5, @1.0];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1.0, 0);
//    gradientLayer.frame = self.bounds;
//    gradientLayer.cornerRadius = self.bounds.size.height/2;
//    [self.layer addSublayer:gradientLayer];
    
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddRoundRect(context, rect, 20);
//    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
//    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextDrawPath(context, kCGPathStroke);
//    CGContextFillPath(context);
    
    //创建CGContextRef
       UIGraphicsBeginImageContext(self.bounds.size);
       CGContextRef gc = UIGraphicsGetCurrentContext();
       
       //创建CGMutablePathRef
//       CGMutablePathRef path = CGPathCreateMutable();
       
       //绘制Path
      // CGRect rect = CGRectMake(0, 100, 300, 200);
        UIBezierPath *berpath= [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(50, 50)];
//       CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
//       CGPathAddLineToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMaxY(rect));
//       CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMaxY(rect));
//       CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMinY(rect));
//    berpath.CGPath = path;
//       CGPathCloseSubpath(path);
       
       //绘制渐变
        [self drawLinearGradient:gc path:berpath.CGPath startColor:[UIColor greenColor].CGColor endColor:[UIColor redColor].CGColor];
       
       //注意释放CGMutablePathRef
//       CGPathRelease(path);
       
       //从Context中获取图像，并显示在界面上
       UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
       
       UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
       [self addSubview:imgView];
}

//线性渐变
- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}


void CGContextAddRoundRect(CGContextRef context,CGRect rect,CGFloat radius){
    float x1=rect.origin.x;
    float y1=rect.origin.y;
    float x2=x1+rect.size.width;
    float y2=y1;
    float x3=x2;
    float y3=y1+rect.size.height;
    float x4=x1;
    float y4=y3;
    CGContextMoveToPoint(context, x1, y1+radius);
    CGContextAddArcToPoint(context, x1, y1, x1+radius, y1, radius);
    CGContextAddArcToPoint(context, x2, y2, x2, y2+radius, radius);
    CGContextAddArcToPoint(context, x3, y3, x3-radius, y3, radius);
    CGContextAddArcToPoint(context, x4, y4, x4, y4-radius, radius);
//    CGContextAddArcToPoint(<#CGContextRef  _Nullable c#>, <#CGFloat x1#>, <#CGFloat y1#>, <#CGFloat x2#>, <#CGFloat y2#>, <#CGFloat radius#>)
    CGContextClosePath(context);
}

@end
