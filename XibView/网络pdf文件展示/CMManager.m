//
//  CMManager.m
//  WKProject
//
//  Created by Hibiscus on 2017/4/4.
//  Copyright © 2017年 WK. All rights reserved.
//

#import "CMManager.h"

// 获取ip地址
#import <ifaddrs.h>
#import <arpa/inet.h>
#include <net/if.h>
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation CMManager

singleton_for_class(CMManager)

#pragma mark - 判断字符串是否为空
- (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    // 去掉前后空格，判断length是否为0
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"] || [string isEqualToString:@"null"]) {
        return YES;
    }
    
    // 不为空
    return NO;
}

#pragma mark - 判断是否为真实手机号码
- (BOOL)checkInputMobile:(NSString *)_text
{
    //
    NSString *MOBILE    = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString *CM        = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378]|7[7])\\d)\\d{7}$";   // 包含电信4G 177号段
    NSString *CU        = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString *CT        = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    //
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:_text];
    BOOL res2 = [regextestcm evaluateWithObject:_text];
    BOOL res3 = [regextestcu evaluateWithObject:_text];
    BOOL res4 = [regextestct evaluateWithObject:_text];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - 判断email格式是否正确
- (BOOL)isAvailableEmail:(NSString *)emailString
{
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    //先把NSString转换为小写
    NSString *lowerString       = emailString.lowercaseString;
    
    return [regExPredicate evaluateWithObject:lowerString] ;
}

#pragma mark - 姓名验证
- (BOOL)isValidateName:(NSString *)name
{
    // 只含有汉字、数字、字母、下划线不能以下划线开头和结尾
    NSString *userNameRegex = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:name];
}

#pragma mark - 获取当前使用语言
- (NSString *)currentLanguage
{
    NSString *opinion   = [NSLocale preferredLanguages][0];
    NSDictionary *dict  = @{
                            @"chs"      : @"chs",
                            @"cht"      : @"cht",
                            @"jp"       : @"jp",
                            @"kr"       : @"kr",
                            @"zh-Hans"  : @"chs",
                            @"zh-Hant"  : @"cht",
                            @"ja"       : @"jp",
                            @"ko"       : @"kr",
                            };
    
    // 不满足以上整合的语种，则全部默认为 en 英文
    return dict[opinion] ? dict[opinion] : @"en";
}


#pragma mark - 打印出项目工程里自定义字体名
- (void)printCustomFontName
{
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames )
    {
        printf( "Family: %s \n", [familyName UTF8String]);
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames )
        {
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
}


#pragma mark - 获取手机ip地址
// Get IP Address
- (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

#pragma mark 弹出提示框
- (void)showTipsWithMsg:(NSString *)message
{
    if (![message isKindOfClass:[NSString class]]) {
        return;
    }
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.layer.cornerRadius = 4;
    bottomView.layer.masksToBounds = YES;
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.6;
    [window addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(window);
        make.bottom.equalTo (window.mas_bottom).offset(-260);
    }];
    [window bringSubviewToFront:bottomView];
    [bottomView sizeToFit];
    UILabel *label = [[UILabel alloc]init];
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    [bottomView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).with.offset(10);
        make.right.equalTo(bottomView.mas_right).with.offset(-10);
        make.bottom.equalTo(bottomView.mas_bottom).with.offset(-10);
        make.top.equalTo(bottomView.mas_top).with.offset(10);
        
    }];
    
    [UIView animateWithDuration:3 animations:^{
        bottomView.alpha = 0;
    } completion:^(BOOL finished) {
        [bottomView removeFromSuperview];
    }];
    
}
- (void)showReportTips
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.layer.cornerRadius = 4;
    bottomView.layer.masksToBounds = YES;
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.9;
    [window addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(window);
        make.bottom.equalTo (window.mas_bottom).offset(-260);
    }];
    [window bringSubviewToFront:bottomView];
    [bottomView sizeToFit];
    
    /*
    UIImageView * img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"报告提示"];
    [bottomView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).with.offset(10);
        make.width.mas_equalTo(17);
        make.centerY.equalTo(bottomView.mas_centerY);
        make.height.mas_equalTo(15);
    }];
    */
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"不要着急，你的报告还在路上~";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    [bottomView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).with.offset(10);
        make.right.equalTo(bottomView.mas_right).with.offset(-10);
        make.bottom.equalTo(bottomView.mas_bottom).with.offset(-10);
        make.top.equalTo(bottomView.mas_top).with.offset(10);
        
    }];
    
    [UIView animateWithDuration:3 animations:^{
        bottomView.alpha = 0;
    } completion:^(BOOL finished) {
        [bottomView removeFromSuperview];
    }];
    
}
- (void)showSubmitSuccess{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.layer.cornerRadius = 15;
    bottomView.layer.masksToBounds = YES;
    bottomView.backgroundColor = [UIColor blackColor];
    [window addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(window);
        make.width.height.mas_equalTo(126);
    }];
    [window bringSubviewToFront:bottomView];
   
    UIImageView * img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"submitSuccess"];
    [bottomView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView.mas_centerX);
        make.top.equalTo(bottomView.mas_top).with.offset(24);
        make.width.height.mas_equalTo(54);
    }];

    UILabel *label = [[UILabel alloc]init];
    label.text = @"感谢提交";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    [bottomView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).with.offset(10);
        make.right.equalTo(bottomView.mas_right).with.offset(-10);
        make.bottom.equalTo(bottomView.mas_bottom).with.offset(-18);
        make.height.mas_equalTo(16);
    }];
    
    [UIView animateWithDuration:3 animations:^{
        bottomView.alpha = 0;
    } completion:^(BOOL finished) {
        [bottomView removeFromSuperview];
    }];
}

//精确的身份证号码有效性检测
- (BOOL)isValidateIDCard:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}


@end
