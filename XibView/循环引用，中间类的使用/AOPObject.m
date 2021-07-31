//
//  AOPObject.m
//  XibView
//
//  Created by Hibiscus on 2021/6/23.
//

#import "AOPObject.h"
#import <Aspects/Aspects.h>
#import <objc/runtime.h>
#import "weakObject.h"

@implementation AOPObject

+(void)methods{
//    [self createMethods];
}

+ (void)createMethods{
    
    Class method = objc_getMetaClass(NSStringFromClass([[RainTools getCurrentViewController] class]).UTF8String);
    NSLog(@"==%@",method);
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id <AspectInfo>info){
        NSLog(@"==class==%@==%@==%@",[info.instance class],[[RainTools getCurrentViewController] class], [[self rain_getCurrentVC] class]);
    } error:nil];

    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> info){

                                   //用户统计代码写在此处 啊
//                                   DDLogDebug(@"[打点统计]:%@ viewWillDisappear",NSStringFromClass([info.instance class]));
//                                   NSString *className = NSStringFromClass([info.instance class]);
//                                   DLog(@"className-->%@",className);
//                                   [MobClick endLogPageView:className];

                               }
                                    error:NULL];
    //类方法做AOP切面处理
    Class method1 = objc_getMetaClass(NSStringFromClass([weakObject class]).UTF8String);
    [method1 aspect_hookSelector:@selector(eat) withOptions:AspectPositionAfter usingBlock:^{
        NSLog(@"监控到了");
    } error:nil];
    
    //实例方法做AOP切面处理
    Class newClass = objc_getClass(@"RainTools".UTF8String);
    [newClass aspect_hookSelector:@selector(aopTest) withOptions:AspectPositionAfter usingBlock:^{
        NSLog(@"监控到了22212122");
    } error:nil];
}

#pragma mark --- 监控button的点击事件
+ (void)trackBttonEvent{
    
    __weak typeof(self) ws = self;

    //设置事件统计
    //放到异步线程去执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //读取配置文件，获取需要统计的事件列表
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EventList" ofType:@"plist"];
        NSDictionary *eventStatisticsDict = [[NSDictionary alloc] initWithContentsOfFile:path];
        for (NSString *classNameString in eventStatisticsDict.allKeys) {
            //使用运行时创建类对象
            const char * className = [classNameString UTF8String];
            //从一个字串返回一个类
            Class newClass = objc_getClass(className);
            
            NSArray *pageEventList = [eventStatisticsDict objectForKey:classNameString];
            for (NSDictionary *eventDict in pageEventList) {
                //事件方法名称
                NSString *eventMethodName = eventDict[@"MethodName"];
                SEL seletor = NSSelectorFromString(eventMethodName);
                NSString *eventId = eventDict[@"EventId"];
                
                [ws trackEventWithClass:object_getClass(newClass) selector:seletor eventID:eventId];
                [ws trackTableViewEventWithClass:object_getClass(newClass) selector:seletor eventID:eventId];
                [ws trackParameterEventWithClass:object_getClass(newClass) selector:seletor eventID:eventId];
            }
        }
    });
}

#pragma mark -- 监控button和tap点击事件(不带参数)
+ (void)trackEventWithClass:(Class)klass selector:(SEL)selector eventID:(NSString*)eventID{

    [klass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        
        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        NSLog(@"className--->%@",className);
        NSLog(@"event----->%@",eventID);
//        if ([eventID isEqualToString:@"xxx"]) {
//            [EJServiceUserInfo isLogin]?[MobClick event:eventID]:[MobClick event:@"???"];
//        }else{
//            [MobClick event:eventID];
//        }
    } error:NULL];
}


#pragma mark -- 监控button和tap点击事件（带参数）
+ (void)trackParameterEventWithClass:(Class)klass selector:(SEL)selector eventID:(NSString*)eventID{
    
    [klass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,UIButton *button) {
        
        NSLog(@"button---->%@",button);
        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        NSLog(@"className--->%@",className);
        NSLog(@"event----->%@",eventID);
        
    } error:NULL];
}


#pragma mark -- 监控tableView的点击事件
+ (void)trackTableViewEventWithClass:(Class)klass selector:(SEL)selector eventID:(NSString*)eventID{
    
    [klass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,NSSet *touches, UIEvent *event) {
        
        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        NSLog(@"className--->%@",className);
        NSLog(@"event----->%@",eventID);
        NSLog(@"section---->%@",[event valueForKeyPath:@"section"]);
        NSLog(@"row---->%@",[event valueForKeyPath:@"row"]);
        NSInteger section = [[event valueForKeyPath:@"section"]integerValue];
        NSInteger row = [[event valueForKeyPath:@"row"]integerValue];
        
        //统计事件
        if (section == 0 && row == 1) {
//            [MobClick event:eventID];
        }
        
    } error:NULL];
}
@end
