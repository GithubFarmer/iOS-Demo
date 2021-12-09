//
//  weakObject.m
//  XibView
//
//  Created by Hibiscus on 2021/6/23.
//

#import "weakObject.h"

@implementation weakObject

- (id)initWithTarget:(id)target{
    if(self = [super init]){
        self.target = target;
    }
    return self;
}

+(void)eat{
    NSLog(@"====dadafa");
}

- (void)finishlog:(NSString *)num{
    NSLog(@"===222222==%@",num);
}

/// 对象重定向
- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    [super forwardInvocation:anInvocation];
//    [self.target forwardInvocation:anInvocation];
    [anInvocation invokeWithTarget:self.target];
}


/// 实现方法
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [self.target methodSignatureForSelector:aSelector];
}

@end
