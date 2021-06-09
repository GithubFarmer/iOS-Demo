//
//  RainHeader.h
//  XibView
//
//  Created by Hibiscus on 2021/6/1.
//

#ifndef RainHeader_h
#define RainHeader_h

#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        (AppDelegate *)[UIApplication sharedApplication].delegate
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kIsIphoneX (([[UIApplication sharedApplication] statusBarFrame].size.height == 44.0f) ? (YES):(NO))
///IOS 版本是否大于11
#define IS_IOS_VERSION_11 (([[[UIDevice currentDevice]systemVersion]floatValue] >= 11.0)? (YES):(NO))

#define kStatusBarHeight (kIsIphoneX ? 44 : 20)
#define kIndicatorHeight (kIsIphoneX ? 34 : 0)
#define kNavBarHeight 44.0
#define kTabBarHeight (kIsIphoneX ? 83 : 49)
#define kTopHeight (kIsIphoneX ? 88 : 64) // 这个高度根据是否是iPhone X系列手机, 来设置导航条高度, 不能使用 [[UIApplication sharedApplication] statusBarFrame].size.height 动态获取, 定位/拨打电话/共享热点会导致页面布局错落
#define kBarHeight (kIsIphoneX ? 128.5 : 89.5)

//获取屏幕宽高
#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreen_Bounds [UIScreen mainScreen].bounds

#endif /* RainHeader_h */
